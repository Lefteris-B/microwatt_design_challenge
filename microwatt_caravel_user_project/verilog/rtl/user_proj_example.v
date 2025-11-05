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
 * user_proj_example
 *
 * This module has been refactored to instantiate the user's
 * Microwatt SoC (microwatt_cf_sram_soc) instead of the example
 * counter. The SoC is connected to the Caravel Wishbone slave
 * interface (renamed from mgmt_wb_* in the SoC). UART TX/RX
 * are mapped to specific IO pads (e.g., io_out[0] for TX,
 * io_in[0] for RX). Logic Analyzer and IRQ are unused/tied off.
 * The parameter BITS is reduced to 2 for minimal IO usage, but
 * can be expanded if needed. The SoC's mgmt_wb_err is unused
 * since Caravel's WB slave interface does not support error signals.
 * Address connection truncates wbs_adr_i to 30 bits as per SoC.
 *
 * Assumptions:
 * - SoC clock: wb_clk_i
 * - SoC reset: wb_rst_i
 * - UART TX: io_out[0], oe=0 (output)
 * - UART RX: io_in[0], oe=1 (input)
 * - Unused IOs: output 0, oe=1 (disabled/high-Z)
 * - LA: outputs tied to 0
 * - IRQ: tied to 0
 * - No analog usage
 *
 * Harden this module first, then the wrapper.
 *
 *-------------------------------------------------------------
 */

module user_proj_example #(
    parameter BITS = 2  // Minimal for UART TX/RX; adjust if more IOs needed
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
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
    input  [BITS-1:0] io_in,
    output [BITS-1:0] io_out,
    output [BITS-1:0] io_oeb,

    // IRQ
    output [2:0] irq
);

    // Wire for unused SoC error signal (Caravel WB has no err)
    wire unused_err;

    // Instantiate the Microwatt SoC
    microwatt_soc microwatt_soc_inst (
        .sys_clk(wb_clk_i),
        .sys_rst(wb_rst_i),
        .serial_tx(io_out[0]),
        .serial_rx(io_in[0]),
        .mgmt_wb_cyc(wbs_cyc_i),
        .mgmt_wb_stb(wbs_stb_i),
        .mgmt_wb_we(wbs_we_i),
        .mgmt_wb_adr(wbs_adr_i[29:0]),  // Truncate to 30 bits as per SoC (adjust if needed for address mapping)
        .mgmt_wb_dat_w(wbs_dat_i),
        .mgmt_wb_dat_r(wbs_dat_o),
        .mgmt_wb_sel(wbs_sel_i),
        .mgmt_wb_ack(wbs_ack_o),
        .mgmt_wb_err(unused_err)  // Unused; tie off or handle if errors possible
    );

    // Tie off unused signals
    assign io_out[BITS-1:1] = {(BITS-1){1'b0}};  // Unused outputs to 0
    assign io_oeb[0] = 1'b0;                     // TX as output
    assign io_oeb[BITS-1:1] = {(BITS-1){1'b1}};  // Other IOs as inputs/high-Z
    assign la_data_out = 128'b0;                 // Unused LA outputs
    assign irq = 3'b000;                         // No interrupts

endmodule

`default_nettype wire
