/* Machine-generated using Migen */
module microwatt_soc(
	input sys_clk,
	input sys_rst,
	output reg serial_tx,
	input serial_rx,
	input mgmt_wb_cyc,
	input mgmt_wb_stb,
	input mgmt_wb_we,
	input [29:0] mgmt_wb_adr,
	input [31:0] mgmt_wb_dat_w,
	output [31:0] mgmt_wb_dat_r,
	input [3:0] mgmt_wb_sel,
	output mgmt_wb_ack,
	output mgmt_wb_err
);

(* keep = "true" *) wire sys_clk_1;
wire sys_rst_1;
wire por_clk;
reg int_rst = 1'd1;
reg microwattcfsramsoc_soc_rst;
wire microwattcfsramsoc_cpu_rst;
reg [1:0] microwattcfsramsoc_reset_storage = 2'd0;
reg microwattcfsramsoc_reset_re = 1'd0;
reg [31:0] microwattcfsramsoc_scratch_storage = 32'd305419896;
reg microwattcfsramsoc_scratch_re = 1'd0;
wire [31:0] microwattcfsramsoc_bus_errors_status;
wire microwattcfsramsoc_bus_errors_we;
reg microwattcfsramsoc_bus_errors_re = 1'd0;
wire microwattcfsramsoc_bus_error;
reg [31:0] microwattcfsramsoc_bus_errors = 32'd0;
wire microwattcfsramsoc_microwatt_reset;
wire [28:0] microwattcfsramsoc_microwatt_ibus_adr;
wire [63:0] microwattcfsramsoc_microwatt_ibus_dat_w;
wire [63:0] microwattcfsramsoc_microwatt_ibus_dat_r;
wire [7:0] microwattcfsramsoc_microwatt_ibus_sel;
wire microwattcfsramsoc_microwatt_ibus_cyc;
wire microwattcfsramsoc_microwatt_ibus_stb;
reg microwattcfsramsoc_microwatt_ibus_ack;
wire microwattcfsramsoc_microwatt_ibus_we;
reg [2:0] microwattcfsramsoc_microwatt_ibus_cti = 3'd0;
reg [1:0] microwattcfsramsoc_microwatt_ibus_bte = 2'd0;
wire [28:0] microwattcfsramsoc_microwatt_dbus_adr;
wire [63:0] microwattcfsramsoc_microwatt_dbus_dat_w;
wire [63:0] microwattcfsramsoc_microwatt_dbus_dat_r;
wire [7:0] microwattcfsramsoc_microwatt_dbus_sel;
wire microwattcfsramsoc_microwatt_dbus_cyc;
wire microwattcfsramsoc_microwatt_dbus_stb;
reg microwattcfsramsoc_microwatt_dbus_ack;
wire microwattcfsramsoc_microwatt_dbus_we;
reg [2:0] microwattcfsramsoc_microwatt_dbus_cti = 3'd0;
reg [1:0] microwattcfsramsoc_microwatt_dbus_bte = 2'd0;
reg microwattcfsramsoc_microwatt_core_ext_irq = 1'd0;
wire microwattcfsramsoc_microwatt0;
wire microwattcfsramsoc_microwatt1;
wire [29:0] microwattcfsramsoc_interface0_adapted_interface_adr;
reg [31:0] microwattcfsramsoc_interface0_adapted_interface_dat_w;
wire [31:0] microwattcfsramsoc_interface0_adapted_interface_dat_r;
reg [3:0] microwattcfsramsoc_interface0_adapted_interface_sel;
reg microwattcfsramsoc_interface0_adapted_interface_cyc;
reg microwattcfsramsoc_interface0_adapted_interface_stb;
wire microwattcfsramsoc_interface0_adapted_interface_ack;
reg microwattcfsramsoc_interface0_adapted_interface_we;
reg [2:0] microwattcfsramsoc_interface0_adapted_interface_cti;
reg [1:0] microwattcfsramsoc_interface0_adapted_interface_bte = 2'd0;
wire microwattcfsramsoc_interface0_adapted_interface_err;
reg microwattcfsramsoc_converter0_skip;
wire microwattcfsramsoc_converter0_done;
reg microwattcfsramsoc_converter0_count = 1'd0;
reg [63:0] microwattcfsramsoc_converter0_dat_r = 64'd0;
wire [29:0] microwattcfsramsoc_interface1_adapted_interface_adr;
reg [31:0] microwattcfsramsoc_interface1_adapted_interface_dat_w;
wire [31:0] microwattcfsramsoc_interface1_adapted_interface_dat_r;
reg [3:0] microwattcfsramsoc_interface1_adapted_interface_sel;
reg microwattcfsramsoc_interface1_adapted_interface_cyc;
reg microwattcfsramsoc_interface1_adapted_interface_stb;
wire microwattcfsramsoc_interface1_adapted_interface_ack;
reg microwattcfsramsoc_interface1_adapted_interface_we;
reg [2:0] microwattcfsramsoc_interface1_adapted_interface_cti;
reg [1:0] microwattcfsramsoc_interface1_adapted_interface_bte = 2'd0;
wire microwattcfsramsoc_interface1_adapted_interface_err;
reg microwattcfsramsoc_converter1_skip;
wire microwattcfsramsoc_converter1_done;
reg microwattcfsramsoc_converter1_count = 1'd0;
reg [63:0] microwattcfsramsoc_converter1_dat_r = 64'd0;
wire microwattcfsramsoc_tx_sink_valid;
reg microwattcfsramsoc_tx_sink_ready;
wire microwattcfsramsoc_tx_sink_first;
wire microwattcfsramsoc_tx_sink_last;
wire [7:0] microwattcfsramsoc_tx_sink_payload_data;
reg [7:0] microwattcfsramsoc_tx_data = 8'd0;
reg [3:0] microwattcfsramsoc_tx_count = 4'd0;
reg microwattcfsramsoc_tx_enable;
reg microwattcfsramsoc_tx_tick = 1'd0;
reg [31:0] microwattcfsramsoc_tx_phase = 32'd0;
reg microwattcfsramsoc_rx_source_valid;
wire microwattcfsramsoc_rx_source_ready;
reg microwattcfsramsoc_rx_source_first = 1'd0;
reg microwattcfsramsoc_rx_source_last = 1'd0;
reg [7:0] microwattcfsramsoc_rx_source_payload_data;
reg [7:0] microwattcfsramsoc_rx_data = 8'd0;
reg [3:0] microwattcfsramsoc_rx_count = 4'd0;
reg microwattcfsramsoc_rx_enable;
reg microwattcfsramsoc_rx_tick = 1'd0;
reg [31:0] microwattcfsramsoc_rx_phase = 32'd0;
wire microwattcfsramsoc_rx_rx;
reg microwattcfsramsoc_rx_rx_d = 1'd0;
reg microwattcfsramsoc_rxtx_re;
wire [7:0] microwattcfsramsoc_rxtx_r;
reg microwattcfsramsoc_rxtx_we;
wire [7:0] microwattcfsramsoc_rxtx_w;
wire microwattcfsramsoc_txfull_status;
wire microwattcfsramsoc_txfull_we;
reg microwattcfsramsoc_txfull_re = 1'd0;
wire microwattcfsramsoc_rxempty_status;
wire microwattcfsramsoc_rxempty_we;
reg microwattcfsramsoc_rxempty_re = 1'd0;
wire microwattcfsramsoc_irq;
wire microwattcfsramsoc_tx_status;
wire microwattcfsramsoc_tx_pending;
wire microwattcfsramsoc_tx_trigger;
reg microwattcfsramsoc_tx_clear;
wire microwattcfsramsoc_rx_status;
wire microwattcfsramsoc_rx_pending;
wire microwattcfsramsoc_rx_trigger;
reg microwattcfsramsoc_rx_clear;
wire microwattcfsramsoc_tx0;
wire microwattcfsramsoc_rx0;
reg [1:0] microwattcfsramsoc_status_status;
wire microwattcfsramsoc_status_we;
reg microwattcfsramsoc_status_re = 1'd0;
wire microwattcfsramsoc_tx1;
wire microwattcfsramsoc_rx1;
reg [1:0] microwattcfsramsoc_pending_status;
wire microwattcfsramsoc_pending_we;
reg microwattcfsramsoc_pending_re = 1'd0;
reg [1:0] microwattcfsramsoc_pending_r = 2'd0;
wire microwattcfsramsoc_tx2;
wire microwattcfsramsoc_rx2;
reg [1:0] microwattcfsramsoc_enable_storage = 2'd0;
reg microwattcfsramsoc_enable_re = 1'd0;
wire microwattcfsramsoc_txempty_status;
wire microwattcfsramsoc_txempty_we;
reg microwattcfsramsoc_txempty_re = 1'd0;
wire microwattcfsramsoc_rxfull_status;
wire microwattcfsramsoc_rxfull_we;
reg microwattcfsramsoc_rxfull_re = 1'd0;
wire microwattcfsramsoc_uart_sink_valid;
wire microwattcfsramsoc_uart_sink_ready;
wire microwattcfsramsoc_uart_sink_first;
wire microwattcfsramsoc_uart_sink_last;
wire [7:0] microwattcfsramsoc_uart_sink_payload_data;
wire microwattcfsramsoc_uart_source_valid;
wire microwattcfsramsoc_uart_source_ready;
wire microwattcfsramsoc_uart_source_first;
wire microwattcfsramsoc_uart_source_last;
wire [7:0] microwattcfsramsoc_uart_source_payload_data;
wire microwattcfsramsoc_tx_fifo_sink_valid;
wire microwattcfsramsoc_tx_fifo_sink_ready;
reg microwattcfsramsoc_tx_fifo_sink_first = 1'd0;
reg microwattcfsramsoc_tx_fifo_sink_last = 1'd0;
wire [7:0] microwattcfsramsoc_tx_fifo_sink_payload_data;
wire microwattcfsramsoc_tx_fifo_source_valid;
wire microwattcfsramsoc_tx_fifo_source_ready;
wire microwattcfsramsoc_tx_fifo_source_first;
wire microwattcfsramsoc_tx_fifo_source_last;
wire [7:0] microwattcfsramsoc_tx_fifo_source_payload_data;
wire microwattcfsramsoc_tx_fifo_re;
reg microwattcfsramsoc_tx_fifo_readable = 1'd0;
wire microwattcfsramsoc_tx_fifo_syncfifo_we;
wire microwattcfsramsoc_tx_fifo_syncfifo_writable;
wire microwattcfsramsoc_tx_fifo_syncfifo_re;
wire microwattcfsramsoc_tx_fifo_syncfifo_readable;
wire [9:0] microwattcfsramsoc_tx_fifo_syncfifo_din;
wire [9:0] microwattcfsramsoc_tx_fifo_syncfifo_dout;
reg [4:0] microwattcfsramsoc_tx_fifo_level0 = 5'd0;
reg microwattcfsramsoc_tx_fifo_replace = 1'd0;
reg [3:0] microwattcfsramsoc_tx_fifo_produce = 4'd0;
reg [3:0] microwattcfsramsoc_tx_fifo_consume = 4'd0;
reg [3:0] microwattcfsramsoc_tx_fifo_wrport_adr;
wire [9:0] microwattcfsramsoc_tx_fifo_wrport_dat_r;
wire microwattcfsramsoc_tx_fifo_wrport_we;
wire [9:0] microwattcfsramsoc_tx_fifo_wrport_dat_w;
wire microwattcfsramsoc_tx_fifo_do_read;
wire [3:0] microwattcfsramsoc_tx_fifo_rdport_adr;
wire [9:0] microwattcfsramsoc_tx_fifo_rdport_dat_r;
wire microwattcfsramsoc_tx_fifo_rdport_re;
wire [4:0] microwattcfsramsoc_tx_fifo_level1;
wire [7:0] microwattcfsramsoc_tx_fifo_fifo_in_payload_data;
wire microwattcfsramsoc_tx_fifo_fifo_in_first;
wire microwattcfsramsoc_tx_fifo_fifo_in_last;
wire [7:0] microwattcfsramsoc_tx_fifo_fifo_out_payload_data;
wire microwattcfsramsoc_tx_fifo_fifo_out_first;
wire microwattcfsramsoc_tx_fifo_fifo_out_last;
wire microwattcfsramsoc_rx_fifo_sink_valid;
wire microwattcfsramsoc_rx_fifo_sink_ready;
wire microwattcfsramsoc_rx_fifo_sink_first;
wire microwattcfsramsoc_rx_fifo_sink_last;
wire [7:0] microwattcfsramsoc_rx_fifo_sink_payload_data;
wire microwattcfsramsoc_rx_fifo_source_valid;
wire microwattcfsramsoc_rx_fifo_source_ready;
wire microwattcfsramsoc_rx_fifo_source_first;
wire microwattcfsramsoc_rx_fifo_source_last;
wire [7:0] microwattcfsramsoc_rx_fifo_source_payload_data;
wire microwattcfsramsoc_rx_fifo_re;
reg microwattcfsramsoc_rx_fifo_readable = 1'd0;
wire microwattcfsramsoc_rx_fifo_syncfifo_we;
wire microwattcfsramsoc_rx_fifo_syncfifo_writable;
wire microwattcfsramsoc_rx_fifo_syncfifo_re;
wire microwattcfsramsoc_rx_fifo_syncfifo_readable;
wire [9:0] microwattcfsramsoc_rx_fifo_syncfifo_din;
wire [9:0] microwattcfsramsoc_rx_fifo_syncfifo_dout;
reg [4:0] microwattcfsramsoc_rx_fifo_level0 = 5'd0;
reg microwattcfsramsoc_rx_fifo_replace = 1'd0;
reg [3:0] microwattcfsramsoc_rx_fifo_produce = 4'd0;
reg [3:0] microwattcfsramsoc_rx_fifo_consume = 4'd0;
reg [3:0] microwattcfsramsoc_rx_fifo_wrport_adr;
wire [9:0] microwattcfsramsoc_rx_fifo_wrport_dat_r;
wire microwattcfsramsoc_rx_fifo_wrport_we;
wire [9:0] microwattcfsramsoc_rx_fifo_wrport_dat_w;
wire microwattcfsramsoc_rx_fifo_do_read;
wire [3:0] microwattcfsramsoc_rx_fifo_rdport_adr;
wire [9:0] microwattcfsramsoc_rx_fifo_rdport_dat_r;
wire microwattcfsramsoc_rx_fifo_rdport_re;
wire [4:0] microwattcfsramsoc_rx_fifo_level1;
wire [7:0] microwattcfsramsoc_rx_fifo_fifo_in_payload_data;
wire microwattcfsramsoc_rx_fifo_fifo_in_first;
wire microwattcfsramsoc_rx_fifo_fifo_in_last;
wire [7:0] microwattcfsramsoc_rx_fifo_fifo_out_payload_data;
wire microwattcfsramsoc_rx_fifo_fifo_out_first;
wire microwattcfsramsoc_rx_fifo_fifo_out_last;
wire [9:0] cf_sram_1024x32_module_bus_adr;
wire [31:0] cf_sram_1024x32_module_bus_dat_w;
wire [31:0] cf_sram_1024x32_module_bus_dat_r;
wire [3:0] cf_sram_1024x32_module_bus_sel;
wire cf_sram_1024x32_module_bus_cyc;
wire cf_sram_1024x32_module_bus_stb;
wire cf_sram_1024x32_module_bus_ack;
wire cf_sram_1024x32_module_bus_we;
wire [2:0] cf_sram_1024x32_module_bus_cti;
wire [1:0] cf_sram_1024x32_module_bus_bte;
reg cf_sram_1024x32_module_bus_err = 1'd0;
reg [1:0] cf_sram_1024x32_module = 2'd0;
wire [29:0] mgmt_wb_mgmt_wb_adr;
wire [31:0] mgmt_wb_mgmt_wb_dat_w;
wire [31:0] mgmt_wb_mgmt_wb_dat_r;
wire [3:0] mgmt_wb_mgmt_wb_sel;
wire mgmt_wb_mgmt_wb_cyc;
wire mgmt_wb_mgmt_wb_stb;
wire mgmt_wb_mgmt_wb_ack;
wire mgmt_wb_mgmt_wb_we;
reg [2:0] mgmt_wb_mgmt_wb_cti = 3'd0;
reg [1:0] mgmt_wb_mgmt_wb_bte = 2'd0;
wire mgmt_wb_mgmt_wb_err;
reg [31:0] timer0_load_storage = 32'd0;
reg timer0_load_re = 1'd0;
reg [31:0] timer0_reload_storage = 32'd0;
reg timer0_reload_re = 1'd0;
reg timer0_en_storage = 1'd0;
reg timer0_en_re = 1'd0;
reg timer0_update_value_storage = 1'd0;
reg timer0_update_value_re = 1'd0;
reg [31:0] timer0_value_status = 32'd0;
wire timer0_value_we;
reg timer0_value_re = 1'd0;
wire timer0_irq;
wire timer0_zero_status;
reg timer0_zero_pending = 1'd0;
wire timer0_zero_trigger;
reg timer0_zero_clear;
reg timer0_zero_trigger_d = 1'd0;
wire timer0_zero0;
wire timer0_status_status;
wire timer0_status_we;
reg timer0_status_re = 1'd0;
wire timer0_zero1;
wire timer0_pending_status;
wire timer0_pending_we;
reg timer0_pending_re = 1'd0;
reg timer0_pending_r = 1'd0;
wire timer0_zero2;
reg timer0_enable_storage = 1'd0;
reg timer0_enable_re = 1'd0;
reg [31:0] timer0_value = 32'd0;
wire [29:0] interface0_adr;
wire [31:0] interface0_dat_w;
reg [31:0] interface0_dat_r;
wire [3:0] interface0_sel;
wire interface0_cyc;
wire interface0_stb;
reg interface0_ack;
wire interface0_we;
wire [2:0] interface0_cti;
wire [1:0] interface0_bte;
reg interface0_err = 1'd0;
reg [13:0] interface1_adr;
reg interface1_re;
reg interface1_we;
reg [31:0] interface1_dat_w;
wire [31:0] interface1_dat_r;
wire [29:0] shared_adr;
wire [31:0] shared_dat_w;
reg [31:0] shared_dat_r;
wire [3:0] shared_sel;
wire shared_cyc;
wire shared_stb;
reg shared_ack;
wire shared_we;
wire [2:0] shared_cti;
wire [1:0] shared_bte;
wire shared_err;
wire [2:0] request;
reg [1:0] grant = 2'd0;
reg [1:0] slave_sel;
reg [1:0] slave_sel_r = 2'd0;
reg error;
wire wait_1;
wire done;
reg [19:0] count = 20'd1000000;
wire [13:0] csr_bankarray_interface0_bank_bus_adr;
wire csr_bankarray_interface0_bank_bus_re;
wire csr_bankarray_interface0_bank_bus_we;
wire [31:0] csr_bankarray_interface0_bank_bus_dat_w;
reg [31:0] csr_bankarray_interface0_bank_bus_dat_r = 32'd0;
reg csr_bankarray_csrbank0_reset0_re;
wire [1:0] csr_bankarray_csrbank0_reset0_r;
reg csr_bankarray_csrbank0_reset0_we;
wire [1:0] csr_bankarray_csrbank0_reset0_w;
reg csr_bankarray_csrbank0_scratch0_re;
wire [31:0] csr_bankarray_csrbank0_scratch0_r;
reg csr_bankarray_csrbank0_scratch0_we;
wire [31:0] csr_bankarray_csrbank0_scratch0_w;
reg csr_bankarray_csrbank0_bus_errors_re;
wire [31:0] csr_bankarray_csrbank0_bus_errors_r;
reg csr_bankarray_csrbank0_bus_errors_we;
wire [31:0] csr_bankarray_csrbank0_bus_errors_w;
wire csr_bankarray_csrbank0_sel;
wire [13:0] csr_bankarray_sram_bus_adr;
wire csr_bankarray_sram_bus_re;
wire csr_bankarray_sram_bus_we;
wire [31:0] csr_bankarray_sram_bus_dat_w;
reg [31:0] csr_bankarray_sram_bus_dat_r;
wire [5:0] csr_bankarray_adr;
wire [7:0] csr_bankarray_dat_r;
wire csr_bankarray_sel;
reg csr_bankarray_sel_r = 1'd0;
wire [13:0] csr_bankarray_interface1_bank_bus_adr;
wire csr_bankarray_interface1_bank_bus_re;
wire csr_bankarray_interface1_bank_bus_we;
wire [31:0] csr_bankarray_interface1_bank_bus_dat_w;
reg [31:0] csr_bankarray_interface1_bank_bus_dat_r = 32'd0;
reg csr_bankarray_csrbank1_load0_re;
wire [31:0] csr_bankarray_csrbank1_load0_r;
reg csr_bankarray_csrbank1_load0_we;
wire [31:0] csr_bankarray_csrbank1_load0_w;
reg csr_bankarray_csrbank1_reload0_re;
wire [31:0] csr_bankarray_csrbank1_reload0_r;
reg csr_bankarray_csrbank1_reload0_we;
wire [31:0] csr_bankarray_csrbank1_reload0_w;
reg csr_bankarray_csrbank1_en0_re;
wire csr_bankarray_csrbank1_en0_r;
reg csr_bankarray_csrbank1_en0_we;
wire csr_bankarray_csrbank1_en0_w;
reg csr_bankarray_csrbank1_update_value0_re;
wire csr_bankarray_csrbank1_update_value0_r;
reg csr_bankarray_csrbank1_update_value0_we;
wire csr_bankarray_csrbank1_update_value0_w;
reg csr_bankarray_csrbank1_value_re;
wire [31:0] csr_bankarray_csrbank1_value_r;
reg csr_bankarray_csrbank1_value_we;
wire [31:0] csr_bankarray_csrbank1_value_w;
reg csr_bankarray_csrbank1_ev_status_re;
wire csr_bankarray_csrbank1_ev_status_r;
reg csr_bankarray_csrbank1_ev_status_we;
wire csr_bankarray_csrbank1_ev_status_w;
reg csr_bankarray_csrbank1_ev_pending_re;
wire csr_bankarray_csrbank1_ev_pending_r;
reg csr_bankarray_csrbank1_ev_pending_we;
wire csr_bankarray_csrbank1_ev_pending_w;
reg csr_bankarray_csrbank1_ev_enable0_re;
wire csr_bankarray_csrbank1_ev_enable0_r;
reg csr_bankarray_csrbank1_ev_enable0_we;
wire csr_bankarray_csrbank1_ev_enable0_w;
wire csr_bankarray_csrbank1_sel;
wire [13:0] csr_bankarray_interface2_bank_bus_adr;
wire csr_bankarray_interface2_bank_bus_re;
wire csr_bankarray_interface2_bank_bus_we;
wire [31:0] csr_bankarray_interface2_bank_bus_dat_w;
reg [31:0] csr_bankarray_interface2_bank_bus_dat_r = 32'd0;
reg csr_bankarray_csrbank2_txfull_re;
wire csr_bankarray_csrbank2_txfull_r;
reg csr_bankarray_csrbank2_txfull_we;
wire csr_bankarray_csrbank2_txfull_w;
reg csr_bankarray_csrbank2_rxempty_re;
wire csr_bankarray_csrbank2_rxempty_r;
reg csr_bankarray_csrbank2_rxempty_we;
wire csr_bankarray_csrbank2_rxempty_w;
reg csr_bankarray_csrbank2_ev_status_re;
wire [1:0] csr_bankarray_csrbank2_ev_status_r;
reg csr_bankarray_csrbank2_ev_status_we;
wire [1:0] csr_bankarray_csrbank2_ev_status_w;
reg csr_bankarray_csrbank2_ev_pending_re;
wire [1:0] csr_bankarray_csrbank2_ev_pending_r;
reg csr_bankarray_csrbank2_ev_pending_we;
wire [1:0] csr_bankarray_csrbank2_ev_pending_w;
reg csr_bankarray_csrbank2_ev_enable0_re;
wire [1:0] csr_bankarray_csrbank2_ev_enable0_r;
reg csr_bankarray_csrbank2_ev_enable0_we;
wire [1:0] csr_bankarray_csrbank2_ev_enable0_w;
reg csr_bankarray_csrbank2_txempty_re;
wire csr_bankarray_csrbank2_txempty_r;
reg csr_bankarray_csrbank2_txempty_we;
wire csr_bankarray_csrbank2_txempty_w;
reg csr_bankarray_csrbank2_rxfull_re;
wire csr_bankarray_csrbank2_rxfull_r;
reg csr_bankarray_csrbank2_rxfull_we;
wire csr_bankarray_csrbank2_rxfull_w;
wire csr_bankarray_csrbank2_sel;
wire [13:0] csr_interconnect_adr;
wire csr_interconnect_re;
wire csr_interconnect_we;
wire [31:0] csr_interconnect_dat_w;
wire [31:0] csr_interconnect_dat_r;
reg rs232phytx_state = 1'd0;
reg rs232phytx_next_state;
reg [3:0] microwattcfsramsoc_tx_count_rs232phytx_next_value0;
reg microwattcfsramsoc_tx_count_rs232phytx_next_value_ce0;
reg microwattcfsramsoc_serial_tx_rs232phytx_next_value1;
reg microwattcfsramsoc_serial_tx_rs232phytx_next_value_ce1;
reg [7:0] microwattcfsramsoc_tx_data_rs232phytx_next_value2;
reg microwattcfsramsoc_tx_data_rs232phytx_next_value_ce2;
reg rs232phyrx_state = 1'd0;
reg rs232phyrx_next_state;
reg [3:0] microwattcfsramsoc_rx_count_rs232phyrx_next_value0;
reg microwattcfsramsoc_rx_count_rs232phyrx_next_value_ce0;
reg [7:0] microwattcfsramsoc_rx_data_rs232phyrx_next_value1;
reg microwattcfsramsoc_rx_data_rs232phyrx_next_value_ce1;
reg state = 1'd0;
reg next_state;
reg [29:0] array_muxed0;
reg [31:0] array_muxed1;
reg [3:0] array_muxed2;
reg array_muxed3;
reg array_muxed4;
reg array_muxed5;
reg [2:0] array_muxed6;
reg [1:0] array_muxed7;
(* no_retiming = "true" *) reg regs0 = 1'd0;
(* no_retiming = "true" *) reg regs1 = 1'd0;

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign microwattcfsramsoc_microwatt_reset = (microwattcfsramsoc_soc_rst | microwattcfsramsoc_cpu_rst);
assign mgmt_wb_mgmt_wb_cyc = mgmt_wb_cyc;
assign mgmt_wb_mgmt_wb_stb = mgmt_wb_stb;
assign mgmt_wb_mgmt_wb_we = mgmt_wb_we;
assign mgmt_wb_mgmt_wb_sel = mgmt_wb_sel;
assign mgmt_wb_mgmt_wb_adr = mgmt_wb_adr;
assign mgmt_wb_mgmt_wb_dat_w = mgmt_wb_dat_w;
assign mgmt_wb_dat_r = mgmt_wb_mgmt_wb_dat_r;
assign mgmt_wb_ack = mgmt_wb_mgmt_wb_ack;
assign mgmt_wb_err = mgmt_wb_mgmt_wb_err;
assign microwattcfsramsoc_bus_error = error;
assign sys_clk_1 = sys_clk;
assign por_clk = sys_clk;
assign sys_rst_1 = int_rst;
assign microwattcfsramsoc_converter0_done = (microwattcfsramsoc_converter0_count == 1'd1);

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_interface0_adapted_interface_cti <= 3'd0;
	case (microwattcfsramsoc_microwatt_ibus_cti)
		2'd2: begin
			microwattcfsramsoc_interface0_adapted_interface_cti <= 2'd2;
		end
		3'd7: begin
			microwattcfsramsoc_interface0_adapted_interface_cti <= (microwattcfsramsoc_converter0_done ? 3'd7 : 2'd2);
		end
		default: begin
			microwattcfsramsoc_interface0_adapted_interface_cti <= 1'd0;
		end
	endcase
	if ((microwattcfsramsoc_microwatt_ibus_bte != 1'd0)) begin
		microwattcfsramsoc_interface0_adapted_interface_cti <= 1'd0;
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_microwatt_ibus_ack <= 1'd0;
	microwattcfsramsoc_interface0_adapted_interface_cyc <= 1'd0;
	microwattcfsramsoc_interface0_adapted_interface_stb <= 1'd0;
	microwattcfsramsoc_interface0_adapted_interface_we <= 1'd0;
	microwattcfsramsoc_converter0_skip <= 1'd0;
	if ((microwattcfsramsoc_microwatt_ibus_stb & microwattcfsramsoc_microwatt_ibus_cyc)) begin
		microwattcfsramsoc_converter0_skip <= ((microwattcfsramsoc_interface0_adapted_interface_sel == 1'd0) & (microwattcfsramsoc_interface0_adapted_interface_cti == 1'd0));
		microwattcfsramsoc_interface0_adapted_interface_cyc <= (~microwattcfsramsoc_converter0_skip);
		microwattcfsramsoc_interface0_adapted_interface_stb <= (~microwattcfsramsoc_converter0_skip);
		microwattcfsramsoc_interface0_adapted_interface_we <= microwattcfsramsoc_microwatt_ibus_we;
		if ((microwattcfsramsoc_interface0_adapted_interface_ack | microwattcfsramsoc_converter0_skip)) begin
			microwattcfsramsoc_microwatt_ibus_ack <= microwattcfsramsoc_converter0_done;
		end
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign microwattcfsramsoc_interface0_adapted_interface_adr = {microwattcfsramsoc_microwatt_ibus_adr, microwattcfsramsoc_converter0_count};

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_interface0_adapted_interface_dat_w <= 32'd0;
	case (microwattcfsramsoc_converter0_count)
		1'd0: begin
			microwattcfsramsoc_interface0_adapted_interface_dat_w <= microwattcfsramsoc_microwatt_ibus_dat_w[63:0];
		end
		1'd1: begin
			microwattcfsramsoc_interface0_adapted_interface_dat_w <= microwattcfsramsoc_microwatt_ibus_dat_w[63:32];
		end
	endcase
// synthesis translate_off
	dummy_d_2 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_3;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_interface0_adapted_interface_sel <= 4'd0;
	case (microwattcfsramsoc_converter0_count)
		1'd0: begin
			microwattcfsramsoc_interface0_adapted_interface_sel <= microwattcfsramsoc_microwatt_ibus_sel[7:0];
		end
		1'd1: begin
			microwattcfsramsoc_interface0_adapted_interface_sel <= microwattcfsramsoc_microwatt_ibus_sel[7:4];
		end
	endcase
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end
assign microwattcfsramsoc_microwatt_ibus_dat_r = {microwattcfsramsoc_interface0_adapted_interface_dat_r, microwattcfsramsoc_converter0_dat_r[63:32]};
assign microwattcfsramsoc_converter1_done = (microwattcfsramsoc_converter1_count == 1'd1);

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_interface1_adapted_interface_cti <= 3'd0;
	case (microwattcfsramsoc_microwatt_dbus_cti)
		2'd2: begin
			microwattcfsramsoc_interface1_adapted_interface_cti <= 2'd2;
		end
		3'd7: begin
			microwattcfsramsoc_interface1_adapted_interface_cti <= (microwattcfsramsoc_converter1_done ? 3'd7 : 2'd2);
		end
		default: begin
			microwattcfsramsoc_interface1_adapted_interface_cti <= 1'd0;
		end
	endcase
	if ((microwattcfsramsoc_microwatt_dbus_bte != 1'd0)) begin
		microwattcfsramsoc_interface1_adapted_interface_cti <= 1'd0;
	end
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_microwatt_dbus_ack <= 1'd0;
	microwattcfsramsoc_interface1_adapted_interface_cyc <= 1'd0;
	microwattcfsramsoc_interface1_adapted_interface_stb <= 1'd0;
	microwattcfsramsoc_interface1_adapted_interface_we <= 1'd0;
	microwattcfsramsoc_converter1_skip <= 1'd0;
	if ((microwattcfsramsoc_microwatt_dbus_stb & microwattcfsramsoc_microwatt_dbus_cyc)) begin
		microwattcfsramsoc_converter1_skip <= ((microwattcfsramsoc_interface1_adapted_interface_sel == 1'd0) & (microwattcfsramsoc_interface1_adapted_interface_cti == 1'd0));
		microwattcfsramsoc_interface1_adapted_interface_cyc <= (~microwattcfsramsoc_converter1_skip);
		microwattcfsramsoc_interface1_adapted_interface_stb <= (~microwattcfsramsoc_converter1_skip);
		microwattcfsramsoc_interface1_adapted_interface_we <= microwattcfsramsoc_microwatt_dbus_we;
		if ((microwattcfsramsoc_interface1_adapted_interface_ack | microwattcfsramsoc_converter1_skip)) begin
			microwattcfsramsoc_microwatt_dbus_ack <= microwattcfsramsoc_converter1_done;
		end
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end
assign microwattcfsramsoc_interface1_adapted_interface_adr = {microwattcfsramsoc_microwatt_dbus_adr, microwattcfsramsoc_converter1_count};

// synthesis translate_off
reg dummy_d_6;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_interface1_adapted_interface_dat_w <= 32'd0;
	case (microwattcfsramsoc_converter1_count)
		1'd0: begin
			microwattcfsramsoc_interface1_adapted_interface_dat_w <= microwattcfsramsoc_microwatt_dbus_dat_w[63:0];
		end
		1'd1: begin
			microwattcfsramsoc_interface1_adapted_interface_dat_w <= microwattcfsramsoc_microwatt_dbus_dat_w[63:32];
		end
	endcase
// synthesis translate_off
	dummy_d_6 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_7;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_interface1_adapted_interface_sel <= 4'd0;
	case (microwattcfsramsoc_converter1_count)
		1'd0: begin
			microwattcfsramsoc_interface1_adapted_interface_sel <= microwattcfsramsoc_microwatt_dbus_sel[7:0];
		end
		1'd1: begin
			microwattcfsramsoc_interface1_adapted_interface_sel <= microwattcfsramsoc_microwatt_dbus_sel[7:4];
		end
	endcase
// synthesis translate_off
	dummy_d_7 <= dummy_s;
// synthesis translate_on
end
assign microwattcfsramsoc_microwatt_dbus_dat_r = {microwattcfsramsoc_interface1_adapted_interface_dat_r, microwattcfsramsoc_converter1_dat_r[63:32]};
assign shared_adr = array_muxed0;
assign shared_dat_w = array_muxed1;
assign shared_sel = array_muxed2;
assign shared_cyc = array_muxed3;
assign shared_stb = array_muxed4;
assign shared_we = array_muxed5;
assign shared_cti = array_muxed6;
assign shared_bte = array_muxed7;
assign microwattcfsramsoc_interface0_adapted_interface_dat_r = shared_dat_r;
assign microwattcfsramsoc_interface1_adapted_interface_dat_r = shared_dat_r;
assign mgmt_wb_mgmt_wb_dat_r = shared_dat_r;
assign microwattcfsramsoc_interface0_adapted_interface_ack = (shared_ack & (grant == 1'd0));
assign microwattcfsramsoc_interface1_adapted_interface_ack = (shared_ack & (grant == 1'd1));
assign mgmt_wb_mgmt_wb_ack = (shared_ack & (grant == 2'd2));
assign microwattcfsramsoc_interface0_adapted_interface_err = (shared_err & (grant == 1'd0));
assign microwattcfsramsoc_interface1_adapted_interface_err = (shared_err & (grant == 1'd1));
assign mgmt_wb_mgmt_wb_err = (shared_err & (grant == 2'd2));
assign request = {mgmt_wb_mgmt_wb_cyc, microwattcfsramsoc_interface1_adapted_interface_cyc, microwattcfsramsoc_interface0_adapted_interface_cyc};

// synthesis translate_off
reg dummy_d_8;
// synthesis translate_on
always @(*) begin
	slave_sel <= 2'd0;
	slave_sel[0] <= (shared_adr[29:10] == 1'd0);
	slave_sel[1] <= (shared_adr[29:14] == 16'd51200);
// synthesis translate_off
	dummy_d_8 <= dummy_s;
// synthesis translate_on
end
assign cf_sram_1024x32_module_bus_adr = shared_adr;
assign cf_sram_1024x32_module_bus_dat_w = shared_dat_w;
assign cf_sram_1024x32_module_bus_sel = shared_sel;
assign cf_sram_1024x32_module_bus_stb = shared_stb;
assign cf_sram_1024x32_module_bus_we = shared_we;
assign cf_sram_1024x32_module_bus_cti = shared_cti;
assign cf_sram_1024x32_module_bus_bte = shared_bte;
assign interface0_adr = shared_adr;
assign interface0_dat_w = shared_dat_w;
assign interface0_sel = shared_sel;
assign interface0_stb = shared_stb;
assign interface0_we = shared_we;
assign interface0_cti = shared_cti;
assign interface0_bte = shared_bte;
assign cf_sram_1024x32_module_bus_cyc = (shared_cyc & slave_sel[0]);
assign interface0_cyc = (shared_cyc & slave_sel[1]);
assign shared_err = (cf_sram_1024x32_module_bus_err | interface0_err);
assign wait_1 = ((shared_stb & shared_cyc) & (~shared_ack));

// synthesis translate_off
reg dummy_d_9;
// synthesis translate_on
always @(*) begin
	shared_dat_r <= 32'd0;
	shared_ack <= 1'd0;
	error <= 1'd0;
	shared_ack <= (cf_sram_1024x32_module_bus_ack | interface0_ack);
	shared_dat_r <= (({32{slave_sel_r[0]}} & cf_sram_1024x32_module_bus_dat_r) | ({32{slave_sel_r[1]}} & interface0_dat_r));
	if (done) begin
		shared_dat_r <= 32'd4294967295;
		shared_ack <= 1'd1;
		error <= 1'd1;
	end
// synthesis translate_off
	dummy_d_9 <= dummy_s;
// synthesis translate_on
end
assign done = (count == 1'd0);
assign microwattcfsramsoc_bus_errors_status = microwattcfsramsoc_bus_errors;
assign microwattcfsramsoc_uart_sink_valid = microwattcfsramsoc_rx_source_valid;
assign microwattcfsramsoc_rx_source_ready = microwattcfsramsoc_uart_sink_ready;
assign microwattcfsramsoc_uart_sink_first = microwattcfsramsoc_rx_source_first;
assign microwattcfsramsoc_uart_sink_last = microwattcfsramsoc_rx_source_last;
assign microwattcfsramsoc_uart_sink_payload_data = microwattcfsramsoc_rx_source_payload_data;
assign microwattcfsramsoc_tx_sink_valid = microwattcfsramsoc_uart_source_valid;
assign microwattcfsramsoc_uart_source_ready = microwattcfsramsoc_tx_sink_ready;
assign microwattcfsramsoc_tx_sink_first = microwattcfsramsoc_uart_source_first;
assign microwattcfsramsoc_tx_sink_last = microwattcfsramsoc_uart_source_last;
assign microwattcfsramsoc_tx_sink_payload_data = microwattcfsramsoc_uart_source_payload_data;
assign microwattcfsramsoc_tx_fifo_sink_valid = microwattcfsramsoc_rxtx_re;
assign microwattcfsramsoc_tx_fifo_sink_payload_data = microwattcfsramsoc_rxtx_r;
assign microwattcfsramsoc_uart_source_valid = microwattcfsramsoc_tx_fifo_source_valid;
assign microwattcfsramsoc_tx_fifo_source_ready = microwattcfsramsoc_uart_source_ready;
assign microwattcfsramsoc_uart_source_first = microwattcfsramsoc_tx_fifo_source_first;
assign microwattcfsramsoc_uart_source_last = microwattcfsramsoc_tx_fifo_source_last;
assign microwattcfsramsoc_uart_source_payload_data = microwattcfsramsoc_tx_fifo_source_payload_data;
assign microwattcfsramsoc_txfull_status = (~microwattcfsramsoc_tx_fifo_sink_ready);
assign microwattcfsramsoc_txempty_status = (~microwattcfsramsoc_tx_fifo_source_valid);
assign microwattcfsramsoc_tx_trigger = microwattcfsramsoc_tx_fifo_sink_ready;
assign microwattcfsramsoc_rx_fifo_sink_valid = microwattcfsramsoc_uart_sink_valid;
assign microwattcfsramsoc_uart_sink_ready = microwattcfsramsoc_rx_fifo_sink_ready;
assign microwattcfsramsoc_rx_fifo_sink_first = microwattcfsramsoc_uart_sink_first;
assign microwattcfsramsoc_rx_fifo_sink_last = microwattcfsramsoc_uart_sink_last;
assign microwattcfsramsoc_rx_fifo_sink_payload_data = microwattcfsramsoc_uart_sink_payload_data;
assign microwattcfsramsoc_rxtx_w = microwattcfsramsoc_rx_fifo_source_payload_data;
assign microwattcfsramsoc_rx_fifo_source_ready = microwattcfsramsoc_rx_clear;
assign microwattcfsramsoc_rxempty_status = (~microwattcfsramsoc_rx_fifo_source_valid);
assign microwattcfsramsoc_rxfull_status = (~microwattcfsramsoc_rx_fifo_sink_ready);
assign microwattcfsramsoc_rx_trigger = microwattcfsramsoc_rx_fifo_source_valid;
assign microwattcfsramsoc_tx0 = microwattcfsramsoc_tx_status;
assign microwattcfsramsoc_tx1 = microwattcfsramsoc_tx_pending;

// synthesis translate_off
reg dummy_d_10;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_tx_clear <= 1'd0;
	if ((microwattcfsramsoc_pending_re & microwattcfsramsoc_pending_r[0])) begin
		microwattcfsramsoc_tx_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_10 <= dummy_s;
// synthesis translate_on
end
assign microwattcfsramsoc_rx0 = microwattcfsramsoc_rx_status;
assign microwattcfsramsoc_rx1 = microwattcfsramsoc_rx_pending;

// synthesis translate_off
reg dummy_d_11;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_rx_clear <= 1'd0;
	if ((microwattcfsramsoc_pending_re & microwattcfsramsoc_pending_r[1])) begin
		microwattcfsramsoc_rx_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_11 <= dummy_s;
// synthesis translate_on
end
assign microwattcfsramsoc_irq = ((microwattcfsramsoc_pending_status[0] & microwattcfsramsoc_enable_storage[0]) | (microwattcfsramsoc_pending_status[1] & microwattcfsramsoc_enable_storage[1]));
assign microwattcfsramsoc_tx_status = microwattcfsramsoc_tx_trigger;
assign microwattcfsramsoc_tx_pending = microwattcfsramsoc_tx_trigger;
assign microwattcfsramsoc_rx_status = microwattcfsramsoc_rx_trigger;
assign microwattcfsramsoc_rx_pending = microwattcfsramsoc_rx_trigger;

// synthesis translate_off
reg dummy_d_12;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_tx_sink_ready <= 1'd0;
	microwattcfsramsoc_tx_enable <= 1'd0;
	rs232phytx_next_state <= 1'd0;
	microwattcfsramsoc_tx_count_rs232phytx_next_value0 <= 4'd0;
	microwattcfsramsoc_tx_count_rs232phytx_next_value_ce0 <= 1'd0;
	microwattcfsramsoc_serial_tx_rs232phytx_next_value1 <= 1'd0;
	microwattcfsramsoc_serial_tx_rs232phytx_next_value_ce1 <= 1'd0;
	microwattcfsramsoc_tx_data_rs232phytx_next_value2 <= 8'd0;
	microwattcfsramsoc_tx_data_rs232phytx_next_value_ce2 <= 1'd0;
	rs232phytx_next_state <= rs232phytx_state;
	case (rs232phytx_state)
		1'd1: begin
			microwattcfsramsoc_tx_enable <= 1'd1;
			if (microwattcfsramsoc_tx_tick) begin
				microwattcfsramsoc_serial_tx_rs232phytx_next_value1 <= microwattcfsramsoc_tx_data[0];
				microwattcfsramsoc_serial_tx_rs232phytx_next_value_ce1 <= 1'd1;
				microwattcfsramsoc_tx_count_rs232phytx_next_value0 <= (microwattcfsramsoc_tx_count + 1'd1);
				microwattcfsramsoc_tx_count_rs232phytx_next_value_ce0 <= 1'd1;
				microwattcfsramsoc_tx_data_rs232phytx_next_value2 <= {1'd1, microwattcfsramsoc_tx_data[7:1]};
				microwattcfsramsoc_tx_data_rs232phytx_next_value_ce2 <= 1'd1;
				if ((microwattcfsramsoc_tx_count == 4'd9)) begin
					microwattcfsramsoc_tx_sink_ready <= 1'd1;
					rs232phytx_next_state <= 1'd0;
				end
			end
		end
		default: begin
			microwattcfsramsoc_tx_count_rs232phytx_next_value0 <= 1'd0;
			microwattcfsramsoc_tx_count_rs232phytx_next_value_ce0 <= 1'd1;
			microwattcfsramsoc_serial_tx_rs232phytx_next_value1 <= 1'd1;
			microwattcfsramsoc_serial_tx_rs232phytx_next_value_ce1 <= 1'd1;
			if (microwattcfsramsoc_tx_sink_valid) begin
				microwattcfsramsoc_serial_tx_rs232phytx_next_value1 <= 1'd0;
				microwattcfsramsoc_serial_tx_rs232phytx_next_value_ce1 <= 1'd1;
				microwattcfsramsoc_tx_data_rs232phytx_next_value2 <= microwattcfsramsoc_tx_sink_payload_data;
				microwattcfsramsoc_tx_data_rs232phytx_next_value_ce2 <= 1'd1;
				rs232phytx_next_state <= 1'd1;
			end
		end
	endcase
// synthesis translate_off
	dummy_d_12 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_13;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_rx_source_valid <= 1'd0;
	microwattcfsramsoc_rx_source_payload_data <= 8'd0;
	microwattcfsramsoc_rx_enable <= 1'd0;
	rs232phyrx_next_state <= 1'd0;
	microwattcfsramsoc_rx_count_rs232phyrx_next_value0 <= 4'd0;
	microwattcfsramsoc_rx_count_rs232phyrx_next_value_ce0 <= 1'd0;
	microwattcfsramsoc_rx_data_rs232phyrx_next_value1 <= 8'd0;
	microwattcfsramsoc_rx_data_rs232phyrx_next_value_ce1 <= 1'd0;
	rs232phyrx_next_state <= rs232phyrx_state;
	case (rs232phyrx_state)
		1'd1: begin
			microwattcfsramsoc_rx_enable <= 1'd1;
			if (microwattcfsramsoc_rx_tick) begin
				microwattcfsramsoc_rx_count_rs232phyrx_next_value0 <= (microwattcfsramsoc_rx_count + 1'd1);
				microwattcfsramsoc_rx_count_rs232phyrx_next_value_ce0 <= 1'd1;
				microwattcfsramsoc_rx_data_rs232phyrx_next_value1 <= {microwattcfsramsoc_rx_rx, microwattcfsramsoc_rx_data[7:1]};
				microwattcfsramsoc_rx_data_rs232phyrx_next_value_ce1 <= 1'd1;
				if ((microwattcfsramsoc_rx_count == 4'd9)) begin
					microwattcfsramsoc_rx_source_valid <= (microwattcfsramsoc_rx_rx == 1'd1);
					microwattcfsramsoc_rx_source_payload_data <= microwattcfsramsoc_rx_data;
					rs232phyrx_next_state <= 1'd0;
				end
			end
		end
		default: begin
			microwattcfsramsoc_rx_count_rs232phyrx_next_value0 <= 1'd0;
			microwattcfsramsoc_rx_count_rs232phyrx_next_value_ce0 <= 1'd1;
			if (((microwattcfsramsoc_rx_rx == 1'd0) & (microwattcfsramsoc_rx_rx_d == 1'd1))) begin
				rs232phyrx_next_state <= 1'd1;
			end
		end
	endcase
// synthesis translate_off
	dummy_d_13 <= dummy_s;
// synthesis translate_on
end
assign microwattcfsramsoc_tx_fifo_syncfifo_din = {microwattcfsramsoc_tx_fifo_fifo_in_last, microwattcfsramsoc_tx_fifo_fifo_in_first, microwattcfsramsoc_tx_fifo_fifo_in_payload_data};
assign {microwattcfsramsoc_tx_fifo_fifo_out_last, microwattcfsramsoc_tx_fifo_fifo_out_first, microwattcfsramsoc_tx_fifo_fifo_out_payload_data} = microwattcfsramsoc_tx_fifo_syncfifo_dout;
assign microwattcfsramsoc_tx_fifo_sink_ready = microwattcfsramsoc_tx_fifo_syncfifo_writable;
assign microwattcfsramsoc_tx_fifo_syncfifo_we = microwattcfsramsoc_tx_fifo_sink_valid;
assign microwattcfsramsoc_tx_fifo_fifo_in_first = microwattcfsramsoc_tx_fifo_sink_first;
assign microwattcfsramsoc_tx_fifo_fifo_in_last = microwattcfsramsoc_tx_fifo_sink_last;
assign microwattcfsramsoc_tx_fifo_fifo_in_payload_data = microwattcfsramsoc_tx_fifo_sink_payload_data;
assign microwattcfsramsoc_tx_fifo_source_valid = microwattcfsramsoc_tx_fifo_readable;
assign microwattcfsramsoc_tx_fifo_source_first = microwattcfsramsoc_tx_fifo_fifo_out_first;
assign microwattcfsramsoc_tx_fifo_source_last = microwattcfsramsoc_tx_fifo_fifo_out_last;
assign microwattcfsramsoc_tx_fifo_source_payload_data = microwattcfsramsoc_tx_fifo_fifo_out_payload_data;
assign microwattcfsramsoc_tx_fifo_re = microwattcfsramsoc_tx_fifo_source_ready;
assign microwattcfsramsoc_tx_fifo_syncfifo_re = (microwattcfsramsoc_tx_fifo_syncfifo_readable & ((~microwattcfsramsoc_tx_fifo_readable) | microwattcfsramsoc_tx_fifo_re));
assign microwattcfsramsoc_tx_fifo_level1 = (microwattcfsramsoc_tx_fifo_level0 + microwattcfsramsoc_tx_fifo_readable);

// synthesis translate_off
reg dummy_d_14;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_tx_fifo_wrport_adr <= 4'd0;
	if (microwattcfsramsoc_tx_fifo_replace) begin
		microwattcfsramsoc_tx_fifo_wrport_adr <= (microwattcfsramsoc_tx_fifo_produce - 1'd1);
	end else begin
		microwattcfsramsoc_tx_fifo_wrport_adr <= microwattcfsramsoc_tx_fifo_produce;
	end
// synthesis translate_off
	dummy_d_14 <= dummy_s;
// synthesis translate_on
end
assign microwattcfsramsoc_tx_fifo_wrport_dat_w = microwattcfsramsoc_tx_fifo_syncfifo_din;
assign microwattcfsramsoc_tx_fifo_wrport_we = (microwattcfsramsoc_tx_fifo_syncfifo_we & (microwattcfsramsoc_tx_fifo_syncfifo_writable | microwattcfsramsoc_tx_fifo_replace));
assign microwattcfsramsoc_tx_fifo_do_read = (microwattcfsramsoc_tx_fifo_syncfifo_readable & microwattcfsramsoc_tx_fifo_syncfifo_re);
assign microwattcfsramsoc_tx_fifo_rdport_adr = microwattcfsramsoc_tx_fifo_consume;
assign microwattcfsramsoc_tx_fifo_syncfifo_dout = microwattcfsramsoc_tx_fifo_rdport_dat_r;
assign microwattcfsramsoc_tx_fifo_rdport_re = microwattcfsramsoc_tx_fifo_do_read;
assign microwattcfsramsoc_tx_fifo_syncfifo_writable = (microwattcfsramsoc_tx_fifo_level0 != 5'd16);
assign microwattcfsramsoc_tx_fifo_syncfifo_readable = (microwattcfsramsoc_tx_fifo_level0 != 1'd0);
assign microwattcfsramsoc_rx_fifo_syncfifo_din = {microwattcfsramsoc_rx_fifo_fifo_in_last, microwattcfsramsoc_rx_fifo_fifo_in_first, microwattcfsramsoc_rx_fifo_fifo_in_payload_data};
assign {microwattcfsramsoc_rx_fifo_fifo_out_last, microwattcfsramsoc_rx_fifo_fifo_out_first, microwattcfsramsoc_rx_fifo_fifo_out_payload_data} = microwattcfsramsoc_rx_fifo_syncfifo_dout;
assign microwattcfsramsoc_rx_fifo_sink_ready = microwattcfsramsoc_rx_fifo_syncfifo_writable;
assign microwattcfsramsoc_rx_fifo_syncfifo_we = microwattcfsramsoc_rx_fifo_sink_valid;
assign microwattcfsramsoc_rx_fifo_fifo_in_first = microwattcfsramsoc_rx_fifo_sink_first;
assign microwattcfsramsoc_rx_fifo_fifo_in_last = microwattcfsramsoc_rx_fifo_sink_last;
assign microwattcfsramsoc_rx_fifo_fifo_in_payload_data = microwattcfsramsoc_rx_fifo_sink_payload_data;
assign microwattcfsramsoc_rx_fifo_source_valid = microwattcfsramsoc_rx_fifo_readable;
assign microwattcfsramsoc_rx_fifo_source_first = microwattcfsramsoc_rx_fifo_fifo_out_first;
assign microwattcfsramsoc_rx_fifo_source_last = microwattcfsramsoc_rx_fifo_fifo_out_last;
assign microwattcfsramsoc_rx_fifo_source_payload_data = microwattcfsramsoc_rx_fifo_fifo_out_payload_data;
assign microwattcfsramsoc_rx_fifo_re = microwattcfsramsoc_rx_fifo_source_ready;
assign microwattcfsramsoc_rx_fifo_syncfifo_re = (microwattcfsramsoc_rx_fifo_syncfifo_readable & ((~microwattcfsramsoc_rx_fifo_readable) | microwattcfsramsoc_rx_fifo_re));
assign microwattcfsramsoc_rx_fifo_level1 = (microwattcfsramsoc_rx_fifo_level0 + microwattcfsramsoc_rx_fifo_readable);

// synthesis translate_off
reg dummy_d_15;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_rx_fifo_wrport_adr <= 4'd0;
	if (microwattcfsramsoc_rx_fifo_replace) begin
		microwattcfsramsoc_rx_fifo_wrport_adr <= (microwattcfsramsoc_rx_fifo_produce - 1'd1);
	end else begin
		microwattcfsramsoc_rx_fifo_wrport_adr <= microwattcfsramsoc_rx_fifo_produce;
	end
// synthesis translate_off
	dummy_d_15 <= dummy_s;
// synthesis translate_on
end
assign microwattcfsramsoc_rx_fifo_wrport_dat_w = microwattcfsramsoc_rx_fifo_syncfifo_din;
assign microwattcfsramsoc_rx_fifo_wrport_we = (microwattcfsramsoc_rx_fifo_syncfifo_we & (microwattcfsramsoc_rx_fifo_syncfifo_writable | microwattcfsramsoc_rx_fifo_replace));
assign microwattcfsramsoc_rx_fifo_do_read = (microwattcfsramsoc_rx_fifo_syncfifo_readable & microwattcfsramsoc_rx_fifo_syncfifo_re);
assign microwattcfsramsoc_rx_fifo_rdport_adr = microwattcfsramsoc_rx_fifo_consume;
assign microwattcfsramsoc_rx_fifo_syncfifo_dout = microwattcfsramsoc_rx_fifo_rdport_dat_r;
assign microwattcfsramsoc_rx_fifo_rdport_re = microwattcfsramsoc_rx_fifo_do_read;
assign microwattcfsramsoc_rx_fifo_syncfifo_writable = (microwattcfsramsoc_rx_fifo_level0 != 5'd16);
assign microwattcfsramsoc_rx_fifo_syncfifo_readable = (microwattcfsramsoc_rx_fifo_level0 != 1'd0);
assign timer0_zero_trigger = (timer0_value == 1'd0);
assign timer0_zero0 = timer0_zero_status;
assign timer0_zero1 = timer0_zero_pending;

// synthesis translate_off
reg dummy_d_16;
// synthesis translate_on
always @(*) begin
	timer0_zero_clear <= 1'd0;
	if ((timer0_pending_re & timer0_pending_r)) begin
		timer0_zero_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_16 <= dummy_s;
// synthesis translate_on
end
assign timer0_irq = (timer0_pending_status & timer0_enable_storage);
assign timer0_zero_status = timer0_zero_trigger;

// synthesis translate_off
reg dummy_d_17;
// synthesis translate_on
always @(*) begin
	interface0_dat_r <= 32'd0;
	interface0_ack <= 1'd0;
	interface1_adr <= 14'd0;
	interface1_re <= 1'd0;
	interface1_we <= 1'd0;
	interface1_dat_w <= 32'd0;
	next_state <= 1'd0;
	next_state <= state;
	case (state)
		1'd1: begin
			interface0_ack <= 1'd1;
			interface0_dat_r <= interface1_dat_r;
			next_state <= 1'd0;
		end
		default: begin
			interface1_dat_w <= interface0_dat_w;
			if ((interface0_cyc & interface0_stb)) begin
				interface1_adr <= interface0_adr[29:0];
				interface1_re <= ((~interface0_we) & (interface0_sel != 1'd0));
				interface1_we <= (interface0_we & (interface0_sel != 1'd0));
				next_state <= 1'd1;
			end
		end
	endcase
// synthesis translate_off
	dummy_d_17 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank0_sel = (csr_bankarray_interface0_bank_bus_adr[13:9] == 1'd1);
assign csr_bankarray_csrbank0_reset0_r = csr_bankarray_interface0_bank_bus_dat_w[1:0];

// synthesis translate_off
reg dummy_d_18;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank0_reset0_re <= 1'd0;
	csr_bankarray_csrbank0_reset0_we <= 1'd0;
	if ((csr_bankarray_csrbank0_sel & (csr_bankarray_interface0_bank_bus_adr[8:0] == 1'd0))) begin
		csr_bankarray_csrbank0_reset0_re <= csr_bankarray_interface0_bank_bus_we;
		csr_bankarray_csrbank0_reset0_we <= csr_bankarray_interface0_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_18 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank0_scratch0_r = csr_bankarray_interface0_bank_bus_dat_w[31:0];

// synthesis translate_off
reg dummy_d_19;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank0_scratch0_re <= 1'd0;
	csr_bankarray_csrbank0_scratch0_we <= 1'd0;
	if ((csr_bankarray_csrbank0_sel & (csr_bankarray_interface0_bank_bus_adr[8:0] == 1'd1))) begin
		csr_bankarray_csrbank0_scratch0_re <= csr_bankarray_interface0_bank_bus_we;
		csr_bankarray_csrbank0_scratch0_we <= csr_bankarray_interface0_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_19 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank0_bus_errors_r = csr_bankarray_interface0_bank_bus_dat_w[31:0];

// synthesis translate_off
reg dummy_d_20;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank0_bus_errors_re <= 1'd0;
	csr_bankarray_csrbank0_bus_errors_we <= 1'd0;
	if ((csr_bankarray_csrbank0_sel & (csr_bankarray_interface0_bank_bus_adr[8:0] == 2'd2))) begin
		csr_bankarray_csrbank0_bus_errors_re <= csr_bankarray_interface0_bank_bus_we;
		csr_bankarray_csrbank0_bus_errors_we <= csr_bankarray_interface0_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_20 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_21;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_soc_rst <= 1'd0;
	if (microwattcfsramsoc_reset_re) begin
		microwattcfsramsoc_soc_rst <= microwattcfsramsoc_reset_storage[0];
	end
// synthesis translate_off
	dummy_d_21 <= dummy_s;
// synthesis translate_on
end
assign microwattcfsramsoc_cpu_rst = microwattcfsramsoc_reset_storage[1];
assign csr_bankarray_csrbank0_reset0_w = microwattcfsramsoc_reset_storage[1:0];
assign csr_bankarray_csrbank0_scratch0_w = microwattcfsramsoc_scratch_storage[31:0];
assign csr_bankarray_csrbank0_bus_errors_w = microwattcfsramsoc_bus_errors_status[31:0];
assign microwattcfsramsoc_bus_errors_we = csr_bankarray_csrbank0_bus_errors_we;
assign csr_bankarray_sel = (csr_bankarray_sram_bus_adr[13:9] == 2'd2);

// synthesis translate_off
reg dummy_d_22;
// synthesis translate_on
always @(*) begin
	csr_bankarray_sram_bus_dat_r <= 32'd0;
	if (csr_bankarray_sel_r) begin
		csr_bankarray_sram_bus_dat_r <= csr_bankarray_dat_r;
	end
// synthesis translate_off
	dummy_d_22 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_adr = csr_bankarray_sram_bus_adr[5:0];
assign csr_bankarray_csrbank1_sel = (csr_bankarray_interface1_bank_bus_adr[13:9] == 1'd0);
assign csr_bankarray_csrbank1_load0_r = csr_bankarray_interface1_bank_bus_dat_w[31:0];

// synthesis translate_off
reg dummy_d_23;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank1_load0_re <= 1'd0;
	csr_bankarray_csrbank1_load0_we <= 1'd0;
	if ((csr_bankarray_csrbank1_sel & (csr_bankarray_interface1_bank_bus_adr[8:0] == 1'd0))) begin
		csr_bankarray_csrbank1_load0_re <= csr_bankarray_interface1_bank_bus_we;
		csr_bankarray_csrbank1_load0_we <= csr_bankarray_interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_23 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank1_reload0_r = csr_bankarray_interface1_bank_bus_dat_w[31:0];

// synthesis translate_off
reg dummy_d_24;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank1_reload0_re <= 1'd0;
	csr_bankarray_csrbank1_reload0_we <= 1'd0;
	if ((csr_bankarray_csrbank1_sel & (csr_bankarray_interface1_bank_bus_adr[8:0] == 1'd1))) begin
		csr_bankarray_csrbank1_reload0_re <= csr_bankarray_interface1_bank_bus_we;
		csr_bankarray_csrbank1_reload0_we <= csr_bankarray_interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_24 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank1_en0_r = csr_bankarray_interface1_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_25;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank1_en0_re <= 1'd0;
	csr_bankarray_csrbank1_en0_we <= 1'd0;
	if ((csr_bankarray_csrbank1_sel & (csr_bankarray_interface1_bank_bus_adr[8:0] == 2'd2))) begin
		csr_bankarray_csrbank1_en0_re <= csr_bankarray_interface1_bank_bus_we;
		csr_bankarray_csrbank1_en0_we <= csr_bankarray_interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_25 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank1_update_value0_r = csr_bankarray_interface1_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_26;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank1_update_value0_re <= 1'd0;
	csr_bankarray_csrbank1_update_value0_we <= 1'd0;
	if ((csr_bankarray_csrbank1_sel & (csr_bankarray_interface1_bank_bus_adr[8:0] == 2'd3))) begin
		csr_bankarray_csrbank1_update_value0_re <= csr_bankarray_interface1_bank_bus_we;
		csr_bankarray_csrbank1_update_value0_we <= csr_bankarray_interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_26 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank1_value_r = csr_bankarray_interface1_bank_bus_dat_w[31:0];

// synthesis translate_off
reg dummy_d_27;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank1_value_re <= 1'd0;
	csr_bankarray_csrbank1_value_we <= 1'd0;
	if ((csr_bankarray_csrbank1_sel & (csr_bankarray_interface1_bank_bus_adr[8:0] == 3'd4))) begin
		csr_bankarray_csrbank1_value_re <= csr_bankarray_interface1_bank_bus_we;
		csr_bankarray_csrbank1_value_we <= csr_bankarray_interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_27 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank1_ev_status_r = csr_bankarray_interface1_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_28;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank1_ev_status_re <= 1'd0;
	csr_bankarray_csrbank1_ev_status_we <= 1'd0;
	if ((csr_bankarray_csrbank1_sel & (csr_bankarray_interface1_bank_bus_adr[8:0] == 3'd5))) begin
		csr_bankarray_csrbank1_ev_status_re <= csr_bankarray_interface1_bank_bus_we;
		csr_bankarray_csrbank1_ev_status_we <= csr_bankarray_interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_28 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank1_ev_pending_r = csr_bankarray_interface1_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_29;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank1_ev_pending_re <= 1'd0;
	csr_bankarray_csrbank1_ev_pending_we <= 1'd0;
	if ((csr_bankarray_csrbank1_sel & (csr_bankarray_interface1_bank_bus_adr[8:0] == 3'd6))) begin
		csr_bankarray_csrbank1_ev_pending_re <= csr_bankarray_interface1_bank_bus_we;
		csr_bankarray_csrbank1_ev_pending_we <= csr_bankarray_interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_29 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank1_ev_enable0_r = csr_bankarray_interface1_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_30;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank1_ev_enable0_re <= 1'd0;
	csr_bankarray_csrbank1_ev_enable0_we <= 1'd0;
	if ((csr_bankarray_csrbank1_sel & (csr_bankarray_interface1_bank_bus_adr[8:0] == 3'd7))) begin
		csr_bankarray_csrbank1_ev_enable0_re <= csr_bankarray_interface1_bank_bus_we;
		csr_bankarray_csrbank1_ev_enable0_we <= csr_bankarray_interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_30 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank1_load0_w = timer0_load_storage[31:0];
assign csr_bankarray_csrbank1_reload0_w = timer0_reload_storage[31:0];
assign csr_bankarray_csrbank1_en0_w = timer0_en_storage;
assign csr_bankarray_csrbank1_update_value0_w = timer0_update_value_storage;
assign csr_bankarray_csrbank1_value_w = timer0_value_status[31:0];
assign timer0_value_we = csr_bankarray_csrbank1_value_we;
assign timer0_status_status = timer0_zero0;
assign csr_bankarray_csrbank1_ev_status_w = timer0_status_status;
assign timer0_status_we = csr_bankarray_csrbank1_ev_status_we;
assign timer0_pending_status = timer0_zero1;
assign csr_bankarray_csrbank1_ev_pending_w = timer0_pending_status;
assign timer0_pending_we = csr_bankarray_csrbank1_ev_pending_we;
assign timer0_zero2 = timer0_enable_storage;
assign csr_bankarray_csrbank1_ev_enable0_w = timer0_enable_storage;
assign csr_bankarray_csrbank2_sel = (csr_bankarray_interface2_bank_bus_adr[13:9] == 2'd3);
assign microwattcfsramsoc_rxtx_r = csr_bankarray_interface2_bank_bus_dat_w[7:0];

// synthesis translate_off
reg dummy_d_31;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_rxtx_re <= 1'd0;
	microwattcfsramsoc_rxtx_we <= 1'd0;
	if ((csr_bankarray_csrbank2_sel & (csr_bankarray_interface2_bank_bus_adr[8:0] == 1'd0))) begin
		microwattcfsramsoc_rxtx_re <= csr_bankarray_interface2_bank_bus_we;
		microwattcfsramsoc_rxtx_we <= csr_bankarray_interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_31 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank2_txfull_r = csr_bankarray_interface2_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_32;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank2_txfull_re <= 1'd0;
	csr_bankarray_csrbank2_txfull_we <= 1'd0;
	if ((csr_bankarray_csrbank2_sel & (csr_bankarray_interface2_bank_bus_adr[8:0] == 1'd1))) begin
		csr_bankarray_csrbank2_txfull_re <= csr_bankarray_interface2_bank_bus_we;
		csr_bankarray_csrbank2_txfull_we <= csr_bankarray_interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_32 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank2_rxempty_r = csr_bankarray_interface2_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_33;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank2_rxempty_re <= 1'd0;
	csr_bankarray_csrbank2_rxempty_we <= 1'd0;
	if ((csr_bankarray_csrbank2_sel & (csr_bankarray_interface2_bank_bus_adr[8:0] == 2'd2))) begin
		csr_bankarray_csrbank2_rxempty_re <= csr_bankarray_interface2_bank_bus_we;
		csr_bankarray_csrbank2_rxempty_we <= csr_bankarray_interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_33 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank2_ev_status_r = csr_bankarray_interface2_bank_bus_dat_w[1:0];

// synthesis translate_off
reg dummy_d_34;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank2_ev_status_re <= 1'd0;
	csr_bankarray_csrbank2_ev_status_we <= 1'd0;
	if ((csr_bankarray_csrbank2_sel & (csr_bankarray_interface2_bank_bus_adr[8:0] == 2'd3))) begin
		csr_bankarray_csrbank2_ev_status_re <= csr_bankarray_interface2_bank_bus_we;
		csr_bankarray_csrbank2_ev_status_we <= csr_bankarray_interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_34 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank2_ev_pending_r = csr_bankarray_interface2_bank_bus_dat_w[1:0];

// synthesis translate_off
reg dummy_d_35;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank2_ev_pending_re <= 1'd0;
	csr_bankarray_csrbank2_ev_pending_we <= 1'd0;
	if ((csr_bankarray_csrbank2_sel & (csr_bankarray_interface2_bank_bus_adr[8:0] == 3'd4))) begin
		csr_bankarray_csrbank2_ev_pending_re <= csr_bankarray_interface2_bank_bus_we;
		csr_bankarray_csrbank2_ev_pending_we <= csr_bankarray_interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_35 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank2_ev_enable0_r = csr_bankarray_interface2_bank_bus_dat_w[1:0];

// synthesis translate_off
reg dummy_d_36;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank2_ev_enable0_re <= 1'd0;
	csr_bankarray_csrbank2_ev_enable0_we <= 1'd0;
	if ((csr_bankarray_csrbank2_sel & (csr_bankarray_interface2_bank_bus_adr[8:0] == 3'd5))) begin
		csr_bankarray_csrbank2_ev_enable0_re <= csr_bankarray_interface2_bank_bus_we;
		csr_bankarray_csrbank2_ev_enable0_we <= csr_bankarray_interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_36 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank2_txempty_r = csr_bankarray_interface2_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_37;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank2_txempty_re <= 1'd0;
	csr_bankarray_csrbank2_txempty_we <= 1'd0;
	if ((csr_bankarray_csrbank2_sel & (csr_bankarray_interface2_bank_bus_adr[8:0] == 3'd6))) begin
		csr_bankarray_csrbank2_txempty_re <= csr_bankarray_interface2_bank_bus_we;
		csr_bankarray_csrbank2_txempty_we <= csr_bankarray_interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_37 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank2_rxfull_r = csr_bankarray_interface2_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_38;
// synthesis translate_on
always @(*) begin
	csr_bankarray_csrbank2_rxfull_re <= 1'd0;
	csr_bankarray_csrbank2_rxfull_we <= 1'd0;
	if ((csr_bankarray_csrbank2_sel & (csr_bankarray_interface2_bank_bus_adr[8:0] == 3'd7))) begin
		csr_bankarray_csrbank2_rxfull_re <= csr_bankarray_interface2_bank_bus_we;
		csr_bankarray_csrbank2_rxfull_we <= csr_bankarray_interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_38 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank2_txfull_w = microwattcfsramsoc_txfull_status;
assign microwattcfsramsoc_txfull_we = csr_bankarray_csrbank2_txfull_we;
assign csr_bankarray_csrbank2_rxempty_w = microwattcfsramsoc_rxempty_status;
assign microwattcfsramsoc_rxempty_we = csr_bankarray_csrbank2_rxempty_we;

// synthesis translate_off
reg dummy_d_39;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_status_status <= 2'd0;
	microwattcfsramsoc_status_status[0] <= microwattcfsramsoc_tx0;
	microwattcfsramsoc_status_status[1] <= microwattcfsramsoc_rx0;
// synthesis translate_off
	dummy_d_39 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank2_ev_status_w = microwattcfsramsoc_status_status[1:0];
assign microwattcfsramsoc_status_we = csr_bankarray_csrbank2_ev_status_we;

// synthesis translate_off
reg dummy_d_40;
// synthesis translate_on
always @(*) begin
	microwattcfsramsoc_pending_status <= 2'd0;
	microwattcfsramsoc_pending_status[0] <= microwattcfsramsoc_tx1;
	microwattcfsramsoc_pending_status[1] <= microwattcfsramsoc_rx1;
// synthesis translate_off
	dummy_d_40 <= dummy_s;
// synthesis translate_on
end
assign csr_bankarray_csrbank2_ev_pending_w = microwattcfsramsoc_pending_status[1:0];
assign microwattcfsramsoc_pending_we = csr_bankarray_csrbank2_ev_pending_we;
assign microwattcfsramsoc_tx2 = microwattcfsramsoc_enable_storage[0];
assign microwattcfsramsoc_rx2 = microwattcfsramsoc_enable_storage[1];
assign csr_bankarray_csrbank2_ev_enable0_w = microwattcfsramsoc_enable_storage[1:0];
assign csr_bankarray_csrbank2_txempty_w = microwattcfsramsoc_txempty_status;
assign microwattcfsramsoc_txempty_we = csr_bankarray_csrbank2_txempty_we;
assign csr_bankarray_csrbank2_rxfull_w = microwattcfsramsoc_rxfull_status;
assign microwattcfsramsoc_rxfull_we = csr_bankarray_csrbank2_rxfull_we;
assign csr_interconnect_adr = interface1_adr;
assign csr_interconnect_re = interface1_re;
assign csr_interconnect_we = interface1_we;
assign csr_interconnect_dat_w = interface1_dat_w;
assign interface1_dat_r = csr_interconnect_dat_r;
assign csr_bankarray_interface0_bank_bus_adr = csr_interconnect_adr;
assign csr_bankarray_interface1_bank_bus_adr = csr_interconnect_adr;
assign csr_bankarray_interface2_bank_bus_adr = csr_interconnect_adr;
assign csr_bankarray_sram_bus_adr = csr_interconnect_adr;
assign csr_bankarray_interface0_bank_bus_re = csr_interconnect_re;
assign csr_bankarray_interface1_bank_bus_re = csr_interconnect_re;
assign csr_bankarray_interface2_bank_bus_re = csr_interconnect_re;
assign csr_bankarray_sram_bus_re = csr_interconnect_re;
assign csr_bankarray_interface0_bank_bus_we = csr_interconnect_we;
assign csr_bankarray_interface1_bank_bus_we = csr_interconnect_we;
assign csr_bankarray_interface2_bank_bus_we = csr_interconnect_we;
assign csr_bankarray_sram_bus_we = csr_interconnect_we;
assign csr_bankarray_interface0_bank_bus_dat_w = csr_interconnect_dat_w;
assign csr_bankarray_interface1_bank_bus_dat_w = csr_interconnect_dat_w;
assign csr_bankarray_interface2_bank_bus_dat_w = csr_interconnect_dat_w;
assign csr_bankarray_sram_bus_dat_w = csr_interconnect_dat_w;
assign csr_interconnect_dat_r = (((csr_bankarray_interface0_bank_bus_dat_r | csr_bankarray_interface1_bank_bus_dat_r) | csr_bankarray_interface2_bank_bus_dat_r) | csr_bankarray_sram_bus_dat_r);

// synthesis translate_off
reg dummy_d_41;
// synthesis translate_on
always @(*) begin
	array_muxed0 <= 30'd0;
	case (grant)
		1'd0: begin
			array_muxed0 <= microwattcfsramsoc_interface0_adapted_interface_adr;
		end
		1'd1: begin
			array_muxed0 <= microwattcfsramsoc_interface1_adapted_interface_adr;
		end
		default: begin
			array_muxed0 <= mgmt_wb_mgmt_wb_adr;
		end
	endcase
// synthesis translate_off
	dummy_d_41 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_42;
// synthesis translate_on
always @(*) begin
	array_muxed1 <= 32'd0;
	case (grant)
		1'd0: begin
			array_muxed1 <= microwattcfsramsoc_interface0_adapted_interface_dat_w;
		end
		1'd1: begin
			array_muxed1 <= microwattcfsramsoc_interface1_adapted_interface_dat_w;
		end
		default: begin
			array_muxed1 <= mgmt_wb_mgmt_wb_dat_w;
		end
	endcase
// synthesis translate_off
	dummy_d_42 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_43;
// synthesis translate_on
always @(*) begin
	array_muxed2 <= 4'd0;
	case (grant)
		1'd0: begin
			array_muxed2 <= microwattcfsramsoc_interface0_adapted_interface_sel;
		end
		1'd1: begin
			array_muxed2 <= microwattcfsramsoc_interface1_adapted_interface_sel;
		end
		default: begin
			array_muxed2 <= mgmt_wb_mgmt_wb_sel;
		end
	endcase
// synthesis translate_off
	dummy_d_43 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_44;
// synthesis translate_on
always @(*) begin
	array_muxed3 <= 1'd0;
	case (grant)
		1'd0: begin
			array_muxed3 <= microwattcfsramsoc_interface0_adapted_interface_cyc;
		end
		1'd1: begin
			array_muxed3 <= microwattcfsramsoc_interface1_adapted_interface_cyc;
		end
		default: begin
			array_muxed3 <= mgmt_wb_mgmt_wb_cyc;
		end
	endcase
// synthesis translate_off
	dummy_d_44 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_45;
// synthesis translate_on
always @(*) begin
	array_muxed4 <= 1'd0;
	case (grant)
		1'd0: begin
			array_muxed4 <= microwattcfsramsoc_interface0_adapted_interface_stb;
		end
		1'd1: begin
			array_muxed4 <= microwattcfsramsoc_interface1_adapted_interface_stb;
		end
		default: begin
			array_muxed4 <= mgmt_wb_mgmt_wb_stb;
		end
	endcase
// synthesis translate_off
	dummy_d_45 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_46;
// synthesis translate_on
always @(*) begin
	array_muxed5 <= 1'd0;
	case (grant)
		1'd0: begin
			array_muxed5 <= microwattcfsramsoc_interface0_adapted_interface_we;
		end
		1'd1: begin
			array_muxed5 <= microwattcfsramsoc_interface1_adapted_interface_we;
		end
		default: begin
			array_muxed5 <= mgmt_wb_mgmt_wb_we;
		end
	endcase
// synthesis translate_off
	dummy_d_46 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_47;
// synthesis translate_on
always @(*) begin
	array_muxed6 <= 3'd0;
	case (grant)
		1'd0: begin
			array_muxed6 <= microwattcfsramsoc_interface0_adapted_interface_cti;
		end
		1'd1: begin
			array_muxed6 <= microwattcfsramsoc_interface1_adapted_interface_cti;
		end
		default: begin
			array_muxed6 <= mgmt_wb_mgmt_wb_cti;
		end
	endcase
// synthesis translate_off
	dummy_d_47 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_48;
// synthesis translate_on
always @(*) begin
	array_muxed7 <= 2'd0;
	case (grant)
		1'd0: begin
			array_muxed7 <= microwattcfsramsoc_interface0_adapted_interface_bte;
		end
		1'd1: begin
			array_muxed7 <= microwattcfsramsoc_interface1_adapted_interface_bte;
		end
		default: begin
			array_muxed7 <= mgmt_wb_mgmt_wb_bte;
		end
	endcase
// synthesis translate_off
	dummy_d_48 <= dummy_s;
// synthesis translate_on
end
assign microwattcfsramsoc_rx_rx = regs1;

always @(posedge por_clk) begin
	int_rst <= sys_rst;
end

always @(posedge sys_clk_1) begin
	if ((((microwattcfsramsoc_interface0_adapted_interface_stb & microwattcfsramsoc_interface0_adapted_interface_cyc) & microwattcfsramsoc_interface0_adapted_interface_ack) | microwattcfsramsoc_converter0_skip)) begin
		microwattcfsramsoc_converter0_count <= (microwattcfsramsoc_converter0_count + 1'd1);
	end
	if ((microwattcfsramsoc_microwatt_ibus_ack | (~microwattcfsramsoc_microwatt_ibus_cyc))) begin
		microwattcfsramsoc_converter0_count <= 1'd0;
	end
	if ((microwattcfsramsoc_interface0_adapted_interface_ack | microwattcfsramsoc_converter0_skip)) begin
		microwattcfsramsoc_converter0_dat_r <= microwattcfsramsoc_microwatt_ibus_dat_r;
	end
	if ((((microwattcfsramsoc_interface1_adapted_interface_stb & microwattcfsramsoc_interface1_adapted_interface_cyc) & microwattcfsramsoc_interface1_adapted_interface_ack) | microwattcfsramsoc_converter1_skip)) begin
		microwattcfsramsoc_converter1_count <= (microwattcfsramsoc_converter1_count + 1'd1);
	end
	if ((microwattcfsramsoc_microwatt_dbus_ack | (~microwattcfsramsoc_microwatt_dbus_cyc))) begin
		microwattcfsramsoc_converter1_count <= 1'd0;
	end
	if ((microwattcfsramsoc_interface1_adapted_interface_ack | microwattcfsramsoc_converter1_skip)) begin
		microwattcfsramsoc_converter1_dat_r <= microwattcfsramsoc_microwatt_dbus_dat_r;
	end
	case (grant)
		1'd0: begin
			if ((~request[0])) begin
				if (request[1]) begin
					grant <= 1'd1;
				end else begin
					if (request[2]) begin
						grant <= 2'd2;
					end
				end
			end
		end
		1'd1: begin
			if ((~request[1])) begin
				if (request[2]) begin
					grant <= 2'd2;
				end else begin
					if (request[0]) begin
						grant <= 1'd0;
					end
				end
			end
		end
		2'd2: begin
			if ((~request[2])) begin
				if (request[0]) begin
					grant <= 1'd0;
				end else begin
					if (request[1]) begin
						grant <= 1'd1;
					end
				end
			end
		end
	endcase
	slave_sel_r <= slave_sel;
	if (wait_1) begin
		if ((~done)) begin
			count <= (count - 1'd1);
		end
	end else begin
		count <= 20'd1000000;
	end
	if ((microwattcfsramsoc_bus_errors != 32'd4294967295)) begin
		if (microwattcfsramsoc_bus_error) begin
			microwattcfsramsoc_bus_errors <= (microwattcfsramsoc_bus_errors + 1'd1);
		end
	end
	{microwattcfsramsoc_tx_tick, microwattcfsramsoc_tx_phase} <= 24'd9895604;
	if (microwattcfsramsoc_tx_enable) begin
		{microwattcfsramsoc_tx_tick, microwattcfsramsoc_tx_phase} <= (microwattcfsramsoc_tx_phase + 24'd9895604);
	end
	rs232phytx_state <= rs232phytx_next_state;
	if (microwattcfsramsoc_tx_count_rs232phytx_next_value_ce0) begin
		microwattcfsramsoc_tx_count <= microwattcfsramsoc_tx_count_rs232phytx_next_value0;
	end
	if (microwattcfsramsoc_serial_tx_rs232phytx_next_value_ce1) begin
		serial_tx <= microwattcfsramsoc_serial_tx_rs232phytx_next_value1;
	end
	if (microwattcfsramsoc_tx_data_rs232phytx_next_value_ce2) begin
		microwattcfsramsoc_tx_data <= microwattcfsramsoc_tx_data_rs232phytx_next_value2;
	end
	microwattcfsramsoc_rx_rx_d <= microwattcfsramsoc_rx_rx;
	{microwattcfsramsoc_rx_tick, microwattcfsramsoc_rx_phase} <= 32'd2147483648;
	if (microwattcfsramsoc_rx_enable) begin
		{microwattcfsramsoc_rx_tick, microwattcfsramsoc_rx_phase} <= (microwattcfsramsoc_rx_phase + 24'd9895604);
	end
	rs232phyrx_state <= rs232phyrx_next_state;
	if (microwattcfsramsoc_rx_count_rs232phyrx_next_value_ce0) begin
		microwattcfsramsoc_rx_count <= microwattcfsramsoc_rx_count_rs232phyrx_next_value0;
	end
	if (microwattcfsramsoc_rx_data_rs232phyrx_next_value_ce1) begin
		microwattcfsramsoc_rx_data <= microwattcfsramsoc_rx_data_rs232phyrx_next_value1;
	end
	if (microwattcfsramsoc_tx_fifo_syncfifo_re) begin
		microwattcfsramsoc_tx_fifo_readable <= 1'd1;
	end else begin
		if (microwattcfsramsoc_tx_fifo_re) begin
			microwattcfsramsoc_tx_fifo_readable <= 1'd0;
		end
	end
	if (((microwattcfsramsoc_tx_fifo_syncfifo_we & microwattcfsramsoc_tx_fifo_syncfifo_writable) & (~microwattcfsramsoc_tx_fifo_replace))) begin
		microwattcfsramsoc_tx_fifo_produce <= (microwattcfsramsoc_tx_fifo_produce + 1'd1);
	end
	if (microwattcfsramsoc_tx_fifo_do_read) begin
		microwattcfsramsoc_tx_fifo_consume <= (microwattcfsramsoc_tx_fifo_consume + 1'd1);
	end
	if (((microwattcfsramsoc_tx_fifo_syncfifo_we & microwattcfsramsoc_tx_fifo_syncfifo_writable) & (~microwattcfsramsoc_tx_fifo_replace))) begin
		if ((~microwattcfsramsoc_tx_fifo_do_read)) begin
			microwattcfsramsoc_tx_fifo_level0 <= (microwattcfsramsoc_tx_fifo_level0 + 1'd1);
		end
	end else begin
		if (microwattcfsramsoc_tx_fifo_do_read) begin
			microwattcfsramsoc_tx_fifo_level0 <= (microwattcfsramsoc_tx_fifo_level0 - 1'd1);
		end
	end
	if (microwattcfsramsoc_rx_fifo_syncfifo_re) begin
		microwattcfsramsoc_rx_fifo_readable <= 1'd1;
	end else begin
		if (microwattcfsramsoc_rx_fifo_re) begin
			microwattcfsramsoc_rx_fifo_readable <= 1'd0;
		end
	end
	if (((microwattcfsramsoc_rx_fifo_syncfifo_we & microwattcfsramsoc_rx_fifo_syncfifo_writable) & (~microwattcfsramsoc_rx_fifo_replace))) begin
		microwattcfsramsoc_rx_fifo_produce <= (microwattcfsramsoc_rx_fifo_produce + 1'd1);
	end
	if (microwattcfsramsoc_rx_fifo_do_read) begin
		microwattcfsramsoc_rx_fifo_consume <= (microwattcfsramsoc_rx_fifo_consume + 1'd1);
	end
	if (((microwattcfsramsoc_rx_fifo_syncfifo_we & microwattcfsramsoc_rx_fifo_syncfifo_writable) & (~microwattcfsramsoc_rx_fifo_replace))) begin
		if ((~microwattcfsramsoc_rx_fifo_do_read)) begin
			microwattcfsramsoc_rx_fifo_level0 <= (microwattcfsramsoc_rx_fifo_level0 + 1'd1);
		end
	end else begin
		if (microwattcfsramsoc_rx_fifo_do_read) begin
			microwattcfsramsoc_rx_fifo_level0 <= (microwattcfsramsoc_rx_fifo_level0 - 1'd1);
		end
	end
	if (timer0_en_storage) begin
		if ((timer0_value == 1'd0)) begin
			timer0_value <= timer0_reload_storage;
		end else begin
			timer0_value <= (timer0_value - 1'd1);
		end
	end else begin
		timer0_value <= timer0_load_storage;
	end
	if (timer0_update_value_re) begin
		timer0_value_status <= timer0_value;
	end
	if (timer0_zero_clear) begin
		timer0_zero_pending <= 1'd0;
	end
	timer0_zero_trigger_d <= timer0_zero_trigger;
	if ((timer0_zero_trigger & (~timer0_zero_trigger_d))) begin
		timer0_zero_pending <= 1'd1;
	end
	state <= next_state;
	csr_bankarray_interface0_bank_bus_dat_r <= 1'd0;
	if (csr_bankarray_csrbank0_sel) begin
		case (csr_bankarray_interface0_bank_bus_adr[8:0])
			1'd0: begin
				csr_bankarray_interface0_bank_bus_dat_r <= csr_bankarray_csrbank0_reset0_w;
			end
			1'd1: begin
				csr_bankarray_interface0_bank_bus_dat_r <= csr_bankarray_csrbank0_scratch0_w;
			end
			2'd2: begin
				csr_bankarray_interface0_bank_bus_dat_r <= csr_bankarray_csrbank0_bus_errors_w;
			end
		endcase
	end
	if (csr_bankarray_csrbank0_reset0_re) begin
		microwattcfsramsoc_reset_storage[1:0] <= csr_bankarray_csrbank0_reset0_r;
	end
	microwattcfsramsoc_reset_re <= csr_bankarray_csrbank0_reset0_re;
	if (csr_bankarray_csrbank0_scratch0_re) begin
		microwattcfsramsoc_scratch_storage[31:0] <= csr_bankarray_csrbank0_scratch0_r;
	end
	microwattcfsramsoc_scratch_re <= csr_bankarray_csrbank0_scratch0_re;
	microwattcfsramsoc_bus_errors_re <= csr_bankarray_csrbank0_bus_errors_re;
	csr_bankarray_sel_r <= csr_bankarray_sel;
	csr_bankarray_interface1_bank_bus_dat_r <= 1'd0;
	if (csr_bankarray_csrbank1_sel) begin
		case (csr_bankarray_interface1_bank_bus_adr[8:0])
			1'd0: begin
				csr_bankarray_interface1_bank_bus_dat_r <= csr_bankarray_csrbank1_load0_w;
			end
			1'd1: begin
				csr_bankarray_interface1_bank_bus_dat_r <= csr_bankarray_csrbank1_reload0_w;
			end
			2'd2: begin
				csr_bankarray_interface1_bank_bus_dat_r <= csr_bankarray_csrbank1_en0_w;
			end
			2'd3: begin
				csr_bankarray_interface1_bank_bus_dat_r <= csr_bankarray_csrbank1_update_value0_w;
			end
			3'd4: begin
				csr_bankarray_interface1_bank_bus_dat_r <= csr_bankarray_csrbank1_value_w;
			end
			3'd5: begin
				csr_bankarray_interface1_bank_bus_dat_r <= csr_bankarray_csrbank1_ev_status_w;
			end
			3'd6: begin
				csr_bankarray_interface1_bank_bus_dat_r <= csr_bankarray_csrbank1_ev_pending_w;
			end
			3'd7: begin
				csr_bankarray_interface1_bank_bus_dat_r <= csr_bankarray_csrbank1_ev_enable0_w;
			end
		endcase
	end
	if (csr_bankarray_csrbank1_load0_re) begin
		timer0_load_storage[31:0] <= csr_bankarray_csrbank1_load0_r;
	end
	timer0_load_re <= csr_bankarray_csrbank1_load0_re;
	if (csr_bankarray_csrbank1_reload0_re) begin
		timer0_reload_storage[31:0] <= csr_bankarray_csrbank1_reload0_r;
	end
	timer0_reload_re <= csr_bankarray_csrbank1_reload0_re;
	if (csr_bankarray_csrbank1_en0_re) begin
		timer0_en_storage <= csr_bankarray_csrbank1_en0_r;
	end
	timer0_en_re <= csr_bankarray_csrbank1_en0_re;
	if (csr_bankarray_csrbank1_update_value0_re) begin
		timer0_update_value_storage <= csr_bankarray_csrbank1_update_value0_r;
	end
	timer0_update_value_re <= csr_bankarray_csrbank1_update_value0_re;
	timer0_value_re <= csr_bankarray_csrbank1_value_re;
	timer0_status_re <= csr_bankarray_csrbank1_ev_status_re;
	if (csr_bankarray_csrbank1_ev_pending_re) begin
		timer0_pending_r <= csr_bankarray_csrbank1_ev_pending_r;
	end
	timer0_pending_re <= csr_bankarray_csrbank1_ev_pending_re;
	if (csr_bankarray_csrbank1_ev_enable0_re) begin
		timer0_enable_storage <= csr_bankarray_csrbank1_ev_enable0_r;
	end
	timer0_enable_re <= csr_bankarray_csrbank1_ev_enable0_re;
	csr_bankarray_interface2_bank_bus_dat_r <= 1'd0;
	if (csr_bankarray_csrbank2_sel) begin
		case (csr_bankarray_interface2_bank_bus_adr[8:0])
			1'd0: begin
				csr_bankarray_interface2_bank_bus_dat_r <= microwattcfsramsoc_rxtx_w;
			end
			1'd1: begin
				csr_bankarray_interface2_bank_bus_dat_r <= csr_bankarray_csrbank2_txfull_w;
			end
			2'd2: begin
				csr_bankarray_interface2_bank_bus_dat_r <= csr_bankarray_csrbank2_rxempty_w;
			end
			2'd3: begin
				csr_bankarray_interface2_bank_bus_dat_r <= csr_bankarray_csrbank2_ev_status_w;
			end
			3'd4: begin
				csr_bankarray_interface2_bank_bus_dat_r <= csr_bankarray_csrbank2_ev_pending_w;
			end
			3'd5: begin
				csr_bankarray_interface2_bank_bus_dat_r <= csr_bankarray_csrbank2_ev_enable0_w;
			end
			3'd6: begin
				csr_bankarray_interface2_bank_bus_dat_r <= csr_bankarray_csrbank2_txempty_w;
			end
			3'd7: begin
				csr_bankarray_interface2_bank_bus_dat_r <= csr_bankarray_csrbank2_rxfull_w;
			end
		endcase
	end
	microwattcfsramsoc_txfull_re <= csr_bankarray_csrbank2_txfull_re;
	microwattcfsramsoc_rxempty_re <= csr_bankarray_csrbank2_rxempty_re;
	microwattcfsramsoc_status_re <= csr_bankarray_csrbank2_ev_status_re;
	if (csr_bankarray_csrbank2_ev_pending_re) begin
		microwattcfsramsoc_pending_r[1:0] <= csr_bankarray_csrbank2_ev_pending_r;
	end
	microwattcfsramsoc_pending_re <= csr_bankarray_csrbank2_ev_pending_re;
	if (csr_bankarray_csrbank2_ev_enable0_re) begin
		microwattcfsramsoc_enable_storage[1:0] <= csr_bankarray_csrbank2_ev_enable0_r;
	end
	microwattcfsramsoc_enable_re <= csr_bankarray_csrbank2_ev_enable0_re;
	microwattcfsramsoc_txempty_re <= csr_bankarray_csrbank2_txempty_re;
	microwattcfsramsoc_rxfull_re <= csr_bankarray_csrbank2_rxfull_re;
	if (sys_rst_1) begin
		microwattcfsramsoc_reset_storage <= 2'd0;
		microwattcfsramsoc_reset_re <= 1'd0;
		microwattcfsramsoc_scratch_storage <= 32'd305419896;
		microwattcfsramsoc_scratch_re <= 1'd0;
		microwattcfsramsoc_bus_errors_re <= 1'd0;
		microwattcfsramsoc_bus_errors <= 32'd0;
		microwattcfsramsoc_converter0_count <= 1'd0;
		microwattcfsramsoc_converter1_count <= 1'd0;
		serial_tx <= 1'd1;
		microwattcfsramsoc_tx_tick <= 1'd0;
		microwattcfsramsoc_rx_tick <= 1'd0;
		microwattcfsramsoc_rx_rx_d <= 1'd0;
		microwattcfsramsoc_txfull_re <= 1'd0;
		microwattcfsramsoc_rxempty_re <= 1'd0;
		microwattcfsramsoc_status_re <= 1'd0;
		microwattcfsramsoc_pending_re <= 1'd0;
		microwattcfsramsoc_pending_r <= 2'd0;
		microwattcfsramsoc_enable_storage <= 2'd0;
		microwattcfsramsoc_enable_re <= 1'd0;
		microwattcfsramsoc_txempty_re <= 1'd0;
		microwattcfsramsoc_rxfull_re <= 1'd0;
		microwattcfsramsoc_tx_fifo_readable <= 1'd0;
		microwattcfsramsoc_tx_fifo_level0 <= 5'd0;
		microwattcfsramsoc_tx_fifo_produce <= 4'd0;
		microwattcfsramsoc_tx_fifo_consume <= 4'd0;
		microwattcfsramsoc_rx_fifo_readable <= 1'd0;
		microwattcfsramsoc_rx_fifo_level0 <= 5'd0;
		microwattcfsramsoc_rx_fifo_produce <= 4'd0;
		microwattcfsramsoc_rx_fifo_consume <= 4'd0;
		timer0_load_storage <= 32'd0;
		timer0_load_re <= 1'd0;
		timer0_reload_storage <= 32'd0;
		timer0_reload_re <= 1'd0;
		timer0_en_storage <= 1'd0;
		timer0_en_re <= 1'd0;
		timer0_update_value_storage <= 1'd0;
		timer0_update_value_re <= 1'd0;
		timer0_value_status <= 32'd0;
		timer0_value_re <= 1'd0;
		timer0_zero_pending <= 1'd0;
		timer0_zero_trigger_d <= 1'd0;
		timer0_status_re <= 1'd0;
		timer0_pending_re <= 1'd0;
		timer0_pending_r <= 1'd0;
		timer0_enable_storage <= 1'd0;
		timer0_enable_re <= 1'd0;
		timer0_value <= 32'd0;
		grant <= 2'd0;
		slave_sel_r <= 2'd0;
		count <= 20'd1000000;
		csr_bankarray_sel_r <= 1'd0;
		rs232phytx_state <= 1'd0;
		rs232phyrx_state <= 1'd0;
		state <= 1'd0;
	end
	regs0 <= serial_rx;
	regs1 <= regs0;
end

reg [7:0] mem[0:43];
reg [5:0] memadr;
always @(posedge sys_clk_1) begin
	memadr <= csr_bankarray_adr;
end

assign csr_bankarray_dat_r = mem[memadr];

reg [9:0] storage[0:15];
reg [9:0] memdat;
reg [9:0] memdat_1;
always @(posedge sys_clk_1) begin
	if (microwattcfsramsoc_tx_fifo_wrport_we)
		storage[microwattcfsramsoc_tx_fifo_wrport_adr] <= microwattcfsramsoc_tx_fifo_wrport_dat_w;
	memdat <= storage[microwattcfsramsoc_tx_fifo_wrport_adr];
end

always @(posedge sys_clk_1) begin
	if (microwattcfsramsoc_tx_fifo_rdport_re)
		memdat_1 <= storage[microwattcfsramsoc_tx_fifo_rdport_adr];
end

assign microwattcfsramsoc_tx_fifo_wrport_dat_r = memdat;
assign microwattcfsramsoc_tx_fifo_rdport_dat_r = memdat_1;

reg [9:0] storage_1[0:15];
reg [9:0] memdat_2;
reg [9:0] memdat_3;
always @(posedge sys_clk_1) begin
	if (microwattcfsramsoc_rx_fifo_wrport_we)
		storage_1[microwattcfsramsoc_rx_fifo_wrport_adr] <= microwattcfsramsoc_rx_fifo_wrport_dat_w;
	memdat_2 <= storage_1[microwattcfsramsoc_rx_fifo_wrport_adr];
end

always @(posedge sys_clk_1) begin
	if (microwattcfsramsoc_rx_fifo_rdport_re)
		memdat_3 <= storage_1[microwattcfsramsoc_rx_fifo_rdport_adr];
end

assign microwattcfsramsoc_rx_fifo_wrport_dat_r = memdat_2;
assign microwattcfsramsoc_rx_fifo_rdport_dat_r = memdat_3;

CF_SRAM_1024x32_wb_wrapper CF_SRAM_1024x32_wb_wrapper (
	.wb_clk_i(sys_clk_1),
	.wb_rst_i(sys_rst_1),
	.wbs_adr_i({cf_sram_1024x32_module_bus_adr, cf_sram_1024x32_module}),
	.wbs_cyc_i(cf_sram_1024x32_module_bus_cyc),
	.wbs_dat_i(cf_sram_1024x32_module_bus_dat_w),
	.wbs_sel_i(cf_sram_1024x32_module_bus_sel),
	.wbs_stb_i(cf_sram_1024x32_module_bus_stb),
	.wbs_we_i(cf_sram_1024x32_module_bus_we),
	.wbs_ack_o(cf_sram_1024x32_module_bus_ack),
	.wbs_dat_o(cf_sram_1024x32_module_bus_dat_r)
);

microwatt_wrapper microwatt_wrapper(
	.clk(sys_clk_1),
	.core_ext_irq(microwattcfsramsoc_microwatt_core_ext_irq),
	.dmi_addr(1'd0),
	.dmi_din(1'd0),
	.dmi_req(1'd0),
	.dmi_wr(1'd0),
	.rst((sys_rst_1 | microwattcfsramsoc_microwatt_reset)),
	.wb_snoop_in_adr(1'd0),
	.wb_snoop_in_cyc(1'd0),
	.wb_snoop_in_dat_w(1'd0),
	.wb_snoop_in_sel(1'd0),
	.wb_snoop_in_stb(1'd0),
	.wb_snoop_in_we(1'd0),
	.wishbone_data_ack(microwattcfsramsoc_microwatt_dbus_ack),
	.wishbone_data_dat_r(microwattcfsramsoc_microwatt_dbus_dat_r),
	.wishbone_data_stall((microwattcfsramsoc_microwatt_dbus_cyc & (~microwattcfsramsoc_microwatt_dbus_ack))),
	.wishbone_insn_ack(microwattcfsramsoc_microwatt_ibus_ack),
	.wishbone_insn_dat_r(microwattcfsramsoc_microwatt_ibus_dat_r),
	.wishbone_insn_stall((microwattcfsramsoc_microwatt_ibus_cyc & (~microwattcfsramsoc_microwatt_ibus_ack))),
	.dmi_ack(microwattcfsramsoc_microwatt1),
	.dmi_dout(microwattcfsramsoc_microwatt0),
	.wishbone_data_adr(microwattcfsramsoc_microwatt_dbus_adr),
	.wishbone_data_cyc(microwattcfsramsoc_microwatt_dbus_cyc),
	.wishbone_data_dat_w(microwattcfsramsoc_microwatt_dbus_dat_w),
	.wishbone_data_sel(microwattcfsramsoc_microwatt_dbus_sel),
	.wishbone_data_stb(microwattcfsramsoc_microwatt_dbus_stb),
	.wishbone_data_we(microwattcfsramsoc_microwatt_dbus_we),
	.wishbone_insn_adr(microwattcfsramsoc_microwatt_ibus_adr),
	.wishbone_insn_cyc(microwattcfsramsoc_microwatt_ibus_cyc),
	.wishbone_insn_dat_w(microwattcfsramsoc_microwatt_ibus_dat_w),
	.wishbone_insn_sel(microwattcfsramsoc_microwatt_ibus_sel),
	.wishbone_insn_stb(microwattcfsramsoc_microwatt_ibus_stb),
	.wishbone_insn_we(microwattcfsramsoc_microwatt_ibus_we)
);

endmodule
