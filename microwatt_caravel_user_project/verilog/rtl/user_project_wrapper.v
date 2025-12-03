// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper directly integrates the Microwatt SoC (OpenPOWER soft-core)
 * into the Caravel harness without using a separate user_proj_example macro.
 *
 * The microwatt_soc.v and microwatt_wrapper.v are hardened together with
 * this wrapper in a flat hierarchy.
 *
 * Pin Mapping (matches user_defines.v configuration):
 *   - UART TX: io_out[5] / GPIO 5 (output)
 *   - UART RX: io_in[6]  / GPIO 6 (input)
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,    // User area 1 3.3V supply
    inout vdda2,    // User area 2 3.3V supply
    inout vssa1,    // User area 1 analog ground
    inout vssa2,    // User area 2 analog ground
    inout vccd1,    // User area 1 1.8V supply
    inout vccd2,    // User area 2 1.8V supply
    inout vssd1,    // User area 1 digital ground
    inout vssd2,    // User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

    /*--------------------------------------*/
    /* Local Parameters                     */
    /*--------------------------------------*/
    
    // GPIO pin assignments (must match user_defines.v)
    localparam GPIO_UART_TX = 5;    // UART TX output
    localparam GPIO_UART_RX = 6;    // UART RX input

    /*--------------------------------------*/
    /* Internal Wires                       */
    /*--------------------------------------*/
    
    // UART signals from Microwatt SoC
    wire uart_tx;           // TX output from SoC
    wire uart_rx;           // RX input to SoC
    
    // Wire for unused SoC error signal (Caravel WB has no err)
    (* keep = "true" *) wire unused_err;

    // =========================================================================
    // FIX FOR LVS: Prevent synthesis from optimizing constant-driven outputs
    // 
    // PROBLEM: When outputs are tied to constants (like la_data_out = 128'b0),
    // synthesis optimizes them, causing net renaming and LVS mismatches.
    //
    // SOLUTION: Use (* keep *) attributes on intermediate wires to preserve
    // the signal hierarchy and prevent constant propagation.
    // =========================================================================

    // -------------------------------------------------------------------------
    // IO Output Enable - preserved wires for UART pins
    // -------------------------------------------------------------------------
    (* keep = "true" *) wire io_oeb_tx;  // GPIO_UART_TX output enable
    (* keep = "true" *) wire io_oeb_rx;  // GPIO_UART_RX output enable
    
    assign io_oeb_tx = 1'b0;  // Active low: 0 = output enabled (for TX)
    assign io_oeb_rx = 1'b1;  // Active low: 1 = output disabled/high-z (for RX input)

    // -------------------------------------------------------------------------
    // Logic Analyzer Output - preserved with generate block
    // Each bit gets its own kept wire to prevent any reordering/collapsing
    // -------------------------------------------------------------------------
    (* keep = "true" *) wire [127:0] la_data_out_kept;
    
    genvar i;
    generate
        for (i = 0; i < 128; i = i + 1) begin : la_keep_gen
            (* keep = "true" *) wire la_bit_tied;
            assign la_bit_tied = 1'b0;
            assign la_data_out_kept[i] = la_bit_tied;
        end
    endgenerate
    
    assign la_data_out = la_data_out_kept;

    // -------------------------------------------------------------------------
    // IRQ - preserved wires  
    // -------------------------------------------------------------------------
    (* keep = "true" *) wire [2:0] irq_kept;
    
    (* keep = "true" *) wire irq_bit0, irq_bit1, irq_bit2;
    assign irq_bit0 = 1'b0;
    assign irq_bit1 = 1'b0;
    assign irq_bit2 = 1'b0;
    assign irq_kept = {irq_bit2, irq_bit1, irq_bit0};
    
    assign user_irq = irq_kept;

    /*--------------------------------------*/
    /* UART Signal Mapping                  */
    /*--------------------------------------*/
    
    // Map GPIO to UART signals
    assign uart_rx = io_in[GPIO_UART_RX];    // GPIO 6 -> UART RX input

    /*--------------------------------------*/
    /* GPIO / IO Pad Connections            */
    /*--------------------------------------*/
    
    // GPIO Assignment Summary:
    //   GPIO[4:0]   - Reserved/unused (directly active as inputs)
    //   GPIO[5]     - UART TX (output from Microwatt)
    //   GPIO[6]     - UART RX (input to Microwatt)
    //   GPIO[37:7]  - Unused (directly active as inputs)
    
    // IO Output Data
    assign io_out[4:0]          = 5'b0;         // GPIO 0-4: tied low
    assign io_out[GPIO_UART_TX] = uart_tx;      // GPIO 5: UART TX from SoC
    assign io_out[GPIO_UART_RX] = 1'b0;         // GPIO 6: RX doesn't drive output
    assign io_out[37:7]         = 31'b0;        // GPIO 7-37: tied low
    
    // IO Output Enable (active low: 0=output enabled, 1=input/high-z)
    assign io_oeb[4:0]          = 5'b11111;     // GPIO 0-4: inputs (high-z)
    assign io_oeb[GPIO_UART_TX] = io_oeb_tx;    // GPIO 5: TX output enable
    assign io_oeb[GPIO_UART_RX] = io_oeb_rx;    // GPIO 6: RX input (high-z)
    assign io_oeb[37:7]         = {31{1'b1}};   // GPIO 7-37: inputs (high-z)

    /*--------------------------------------*/
    /* Microwatt SoC Instantiation          */
    /*--------------------------------------*/
    
    microwatt_soc microwatt_soc_inst (
        .sys_clk(wb_clk_i),
        .sys_rst(wb_rst_i),
        
        // UART connections
        .serial_tx(uart_tx),          // TX output
        .serial_rx(uart_rx),          // RX input (from GPIO 6)
        
        // Wishbone slave interface
        .mgmt_wb_cyc(wbs_cyc_i),
        .mgmt_wb_stb(wbs_stb_i),
        .mgmt_wb_we(wbs_we_i),
        .mgmt_wb_adr(wbs_adr_i[29:0]),  // 30-bit address
        .mgmt_wb_dat_w(wbs_dat_i),
        .mgmt_wb_dat_r(wbs_dat_o),
        .mgmt_wb_sel(wbs_sel_i),
        .mgmt_wb_ack(wbs_ack_o),
        .mgmt_wb_err(unused_err)        // Error signal (unused)
    );

endmodule    // user_project_wrapper

`default_nettype wire
