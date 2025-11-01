/* Machine-generated using Migen */
module microwatt_soc(
	output serial_tx,
	input serial_rx,
	input clk,
	input rst,
	input sys_clk,
	input sys_rst
);

reg soc_rst;
wire cpu_rst;
reg [1:0] reset_storage = 2'd0;
reg reset_re = 1'd0;
reg [31:0] scratch_storage = 32'd305419896;
reg scratch_re = 1'd0;
wire [31:0] bus_errors_status;
wire bus_errors_we;
reg bus_errors_re = 1'd0;
wire bus_error;
reg [31:0] bus_errors = 32'd0;
wire microwatt_reset;
wire [28:0] microwatt_ibus_adr;
wire [63:0] microwatt_ibus_dat_w;
wire [63:0] microwatt_ibus_dat_r;
wire [7:0] microwatt_ibus_sel;
wire microwatt_ibus_cyc;
wire microwatt_ibus_stb;
reg microwatt_ibus_ack;
wire microwatt_ibus_we;
reg [2:0] microwatt_ibus_cti = 3'd0;
reg [1:0] microwatt_ibus_bte = 2'd0;
wire [28:0] microwatt_dbus_adr;
wire [63:0] microwatt_dbus_dat_w;
wire [63:0] microwatt_dbus_dat_r;
wire [7:0] microwatt_dbus_sel;
wire microwatt_dbus_cyc;
wire microwatt_dbus_stb;
reg microwatt_dbus_ack;
wire microwatt_dbus_we;
reg [2:0] microwatt_dbus_cti = 3'd0;
reg [1:0] microwatt_dbus_bte = 2'd0;
reg microwatt_core_ext_irq = 1'd0;
wire microwatt0;
wire microwatt1;
wire [29:0] interface0_adapted_interface_adr;
reg [31:0] interface0_adapted_interface_dat_w;
wire [31:0] interface0_adapted_interface_dat_r;
reg [3:0] interface0_adapted_interface_sel;
reg interface0_adapted_interface_cyc;
reg interface0_adapted_interface_stb;
wire interface0_adapted_interface_ack;
reg interface0_adapted_interface_we;
reg [2:0] interface0_adapted_interface_cti;
reg [1:0] interface0_adapted_interface_bte = 2'd0;
wire interface0_adapted_interface_err;
reg converter0_skip;
wire converter0_done;
reg converter0_count = 1'd0;
reg [63:0] converter0_dat_r = 64'd0;
wire [29:0] interface1_adapted_interface_adr;
reg [31:0] interface1_adapted_interface_dat_w;
wire [31:0] interface1_adapted_interface_dat_r;
reg [3:0] interface1_adapted_interface_sel;
reg interface1_adapted_interface_cyc;
reg interface1_adapted_interface_stb;
wire interface1_adapted_interface_ack;
reg interface1_adapted_interface_we;
reg [2:0] interface1_adapted_interface_cti;
reg [1:0] interface1_adapted_interface_bte = 2'd0;
wire interface1_adapted_interface_err;
reg converter1_skip;
wire converter1_done;
reg converter1_count = 1'd0;
reg [63:0] converter1_dat_r = 64'd0;
reg uart_rxtx_re;
wire [7:0] uart_rxtx_r;
reg uart_rxtx_we;
wire [7:0] uart_rxtx_w;
wire uart_txfull_status;
wire uart_txfull_we;
reg uart_txfull_re = 1'd0;
wire uart_rxempty_status;
wire uart_rxempty_we;
reg uart_rxempty_re = 1'd0;
wire uart_irq;
wire uart_tx_status;
wire uart_tx_pending;
wire uart_tx_trigger;
reg uart_tx_clear;
wire uart_rx_status;
wire uart_rx_pending;
wire uart_rx_trigger;
reg uart_rx_clear;
wire uart_tx0;
wire uart_rx0;
reg [1:0] uart_status_status;
wire uart_status_we;
reg uart_status_re = 1'd0;
wire uart_tx1;
wire uart_rx1;
reg [1:0] uart_pending_status;
wire uart_pending_we;
reg uart_pending_re = 1'd0;
reg [1:0] uart_pending_r = 2'd0;
wire uart_tx2;
wire uart_rx2;
reg [1:0] uart_enable_storage = 2'd0;
reg uart_enable_re = 1'd0;
wire uart_txempty_status;
wire uart_txempty_we;
reg uart_txempty_re = 1'd0;
wire uart_rxfull_status;
wire uart_rxfull_we;
reg uart_rxfull_re = 1'd0;
reg uart_uart_sink_valid = 1'd0;
wire uart_uart_sink_ready;
reg uart_uart_sink_first = 1'd0;
reg uart_uart_sink_last = 1'd0;
reg [7:0] uart_uart_sink_payload_data = 8'd0;
wire uart_uart_source_valid;
wire uart_uart_source_ready;
wire uart_uart_source_first;
wire uart_uart_source_last;
wire [7:0] uart_uart_source_payload_data;
wire uart_tx_fifo_sink_valid;
wire uart_tx_fifo_sink_ready;
reg uart_tx_fifo_sink_first = 1'd0;
reg uart_tx_fifo_sink_last = 1'd0;
wire [7:0] uart_tx_fifo_sink_payload_data;
wire uart_tx_fifo_source_valid;
wire uart_tx_fifo_source_ready;
wire uart_tx_fifo_source_first;
wire uart_tx_fifo_source_last;
wire [7:0] uart_tx_fifo_source_payload_data;
wire uart_rx_fifo_sink_valid;
wire uart_rx_fifo_sink_ready;
wire uart_rx_fifo_sink_first;
wire uart_rx_fifo_sink_last;
wire [7:0] uart_rx_fifo_sink_payload_data;
wire uart_rx_fifo_source_valid;
wire uart_rx_fifo_source_ready;
wire uart_rx_fifo_source_first;
wire uart_rx_fifo_source_last;
wire [7:0] uart_rx_fifo_source_payload_data;
reg [31:0] timer_load_storage = 32'd0;
reg timer_load_re = 1'd0;
reg [31:0] timer_reload_storage = 32'd0;
reg timer_reload_re = 1'd0;
reg timer_en_storage = 1'd0;
reg timer_en_re = 1'd0;
reg timer_update_value_storage = 1'd0;
reg timer_update_value_re = 1'd0;
reg [31:0] timer_value_status = 32'd0;
wire timer_value_we;
reg timer_value_re = 1'd0;
wire timer_irq;
wire timer_zero_status;
reg timer_zero_pending = 1'd0;
wire timer_zero_trigger;
reg timer_zero_clear;
reg timer_zero_trigger_d = 1'd0;
wire timer_zero0;
wire timer_status_status;
wire timer_status_we;
reg timer_status_re = 1'd0;
wire timer_zero1;
wire timer_pending_status;
wire timer_pending_we;
reg timer_pending_re = 1'd0;
reg timer_pending_r = 1'd0;
wire timer_zero2;
reg timer_enable_storage = 1'd0;
reg timer_enable_re = 1'd0;
reg [31:0] timer_value = 32'd0;
wire [9:0] cf_sram_bus_adr;
wire [31:0] cf_sram_bus_dat_w;
wire [31:0] cf_sram_bus_dat_r;
wire [3:0] cf_sram_bus_sel;
wire cf_sram_bus_cyc;
wire cf_sram_bus_stb;
wire cf_sram_bus_ack;
wire cf_sram_bus_we;
wire [2:0] cf_sram_bus_cti;
wire [1:0] cf_sram_bus_bte;
wire cf_sram_bus_err;
wire [2:0] cf_uart_bus_adr;
wire [31:0] cf_uart_bus_dat_w;
wire [31:0] cf_uart_bus_dat_r;
wire [3:0] cf_uart_bus_sel;
wire cf_uart_bus_cyc;
wire cf_uart_bus_stb;
wire cf_uart_bus_ack;
wire cf_uart_bus_we;
wire [2:0] cf_uart_bus_cti;
wire [1:0] cf_uart_bus_bte;
wire cf_uart_bus_err;
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
wire [1:0] request;
reg grant = 1'd0;
reg [2:0] slave_sel;
reg [2:0] slave_sel_r = 3'd0;
reg error;
wire wait_1;
wire done;
reg [19:0] count = 20'd1000000;
wire [13:0] interface0_bank_bus_adr;
wire interface0_bank_bus_re;
wire interface0_bank_bus_we;
wire [31:0] interface0_bank_bus_dat_w;
reg [31:0] interface0_bank_bus_dat_r = 32'd0;
reg csrbank0_reset0_re;
wire [1:0] csrbank0_reset0_r;
reg csrbank0_reset0_we;
wire [1:0] csrbank0_reset0_w;
reg csrbank0_scratch0_re;
wire [31:0] csrbank0_scratch0_r;
reg csrbank0_scratch0_we;
wire [31:0] csrbank0_scratch0_w;
reg csrbank0_bus_errors_re;
wire [31:0] csrbank0_bus_errors_r;
reg csrbank0_bus_errors_we;
wire [31:0] csrbank0_bus_errors_w;
wire csrbank0_sel;
wire [13:0] interface1_bank_bus_adr;
wire interface1_bank_bus_re;
wire interface1_bank_bus_we;
wire [31:0] interface1_bank_bus_dat_w;
reg [31:0] interface1_bank_bus_dat_r = 32'd0;
reg csrbank1_load0_re;
wire [31:0] csrbank1_load0_r;
reg csrbank1_load0_we;
wire [31:0] csrbank1_load0_w;
reg csrbank1_reload0_re;
wire [31:0] csrbank1_reload0_r;
reg csrbank1_reload0_we;
wire [31:0] csrbank1_reload0_w;
reg csrbank1_en0_re;
wire csrbank1_en0_r;
reg csrbank1_en0_we;
wire csrbank1_en0_w;
reg csrbank1_update_value0_re;
wire csrbank1_update_value0_r;
reg csrbank1_update_value0_we;
wire csrbank1_update_value0_w;
reg csrbank1_value_re;
wire [31:0] csrbank1_value_r;
reg csrbank1_value_we;
wire [31:0] csrbank1_value_w;
reg csrbank1_ev_status_re;
wire csrbank1_ev_status_r;
reg csrbank1_ev_status_we;
wire csrbank1_ev_status_w;
reg csrbank1_ev_pending_re;
wire csrbank1_ev_pending_r;
reg csrbank1_ev_pending_we;
wire csrbank1_ev_pending_w;
reg csrbank1_ev_enable0_re;
wire csrbank1_ev_enable0_r;
reg csrbank1_ev_enable0_we;
wire csrbank1_ev_enable0_w;
wire csrbank1_sel;
wire [13:0] interface2_bank_bus_adr;
wire interface2_bank_bus_re;
wire interface2_bank_bus_we;
wire [31:0] interface2_bank_bus_dat_w;
reg [31:0] interface2_bank_bus_dat_r = 32'd0;
reg csrbank2_txfull_re;
wire csrbank2_txfull_r;
reg csrbank2_txfull_we;
wire csrbank2_txfull_w;
reg csrbank2_rxempty_re;
wire csrbank2_rxempty_r;
reg csrbank2_rxempty_we;
wire csrbank2_rxempty_w;
reg csrbank2_ev_status_re;
wire [1:0] csrbank2_ev_status_r;
reg csrbank2_ev_status_we;
wire [1:0] csrbank2_ev_status_w;
reg csrbank2_ev_pending_re;
wire [1:0] csrbank2_ev_pending_r;
reg csrbank2_ev_pending_we;
wire [1:0] csrbank2_ev_pending_w;
reg csrbank2_ev_enable0_re;
wire [1:0] csrbank2_ev_enable0_r;
reg csrbank2_ev_enable0_we;
wire [1:0] csrbank2_ev_enable0_w;
reg csrbank2_txempty_re;
wire csrbank2_txempty_r;
reg csrbank2_txempty_we;
wire csrbank2_txempty_w;
reg csrbank2_rxfull_re;
wire csrbank2_rxfull_r;
reg csrbank2_rxfull_we;
wire csrbank2_rxfull_w;
wire csrbank2_sel;
wire [13:0] adr;
wire re;
wire we;
wire [31:0] dat_w;
wire [31:0] dat_r;
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

// synthesis translate_off
reg dummy_s;
initial dummy_s <= 1'd0;
// synthesis translate_on

assign microwatt_reset = (soc_rst | cpu_rst);
assign uart_uart_source_ready = 1'd1;
assign bus_error = error;
assign converter0_done = (converter0_count == 1'd1);

// synthesis translate_off
reg dummy_d;
// synthesis translate_on
always @(*) begin
	interface0_adapted_interface_cti <= 3'd0;
	case (microwatt_ibus_cti)
		2'd2: begin
			interface0_adapted_interface_cti <= 2'd2;
		end
		3'd7: begin
			interface0_adapted_interface_cti <= (converter0_done ? 3'd7 : 2'd2);
		end
		default: begin
			interface0_adapted_interface_cti <= 1'd0;
		end
	endcase
	if ((microwatt_ibus_bte != 1'd0)) begin
		interface0_adapted_interface_cti <= 1'd0;
	end
// synthesis translate_off
	dummy_d <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_1;
// synthesis translate_on
always @(*) begin
	microwatt_ibus_ack <= 1'd0;
	interface0_adapted_interface_cyc <= 1'd0;
	interface0_adapted_interface_stb <= 1'd0;
	interface0_adapted_interface_we <= 1'd0;
	converter0_skip <= 1'd0;
	if ((microwatt_ibus_stb & microwatt_ibus_cyc)) begin
		converter0_skip <= ((interface0_adapted_interface_sel == 1'd0) & (interface0_adapted_interface_cti == 1'd0));
		interface0_adapted_interface_cyc <= (~converter0_skip);
		interface0_adapted_interface_stb <= (~converter0_skip);
		interface0_adapted_interface_we <= microwatt_ibus_we;
		if ((interface0_adapted_interface_ack | converter0_skip)) begin
			microwatt_ibus_ack <= converter0_done;
		end
	end
// synthesis translate_off
	dummy_d_1 <= dummy_s;
// synthesis translate_on
end
assign interface0_adapted_interface_adr = {microwatt_ibus_adr, converter0_count};

// synthesis translate_off
reg dummy_d_2;
// synthesis translate_on
always @(*) begin
	interface0_adapted_interface_dat_w <= 32'd0;
	case (converter0_count)
		1'd0: begin
			interface0_adapted_interface_dat_w <= microwatt_ibus_dat_w[63:0];
		end
		1'd1: begin
			interface0_adapted_interface_dat_w <= microwatt_ibus_dat_w[63:32];
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
	interface0_adapted_interface_sel <= 4'd0;
	case (converter0_count)
		1'd0: begin
			interface0_adapted_interface_sel <= microwatt_ibus_sel[7:0];
		end
		1'd1: begin
			interface0_adapted_interface_sel <= microwatt_ibus_sel[7:4];
		end
	endcase
// synthesis translate_off
	dummy_d_3 <= dummy_s;
// synthesis translate_on
end
assign microwatt_ibus_dat_r = {interface0_adapted_interface_dat_r, converter0_dat_r[63:32]};
assign converter1_done = (converter1_count == 1'd1);

// synthesis translate_off
reg dummy_d_4;
// synthesis translate_on
always @(*) begin
	interface1_adapted_interface_cti <= 3'd0;
	case (microwatt_dbus_cti)
		2'd2: begin
			interface1_adapted_interface_cti <= 2'd2;
		end
		3'd7: begin
			interface1_adapted_interface_cti <= (converter1_done ? 3'd7 : 2'd2);
		end
		default: begin
			interface1_adapted_interface_cti <= 1'd0;
		end
	endcase
	if ((microwatt_dbus_bte != 1'd0)) begin
		interface1_adapted_interface_cti <= 1'd0;
	end
// synthesis translate_off
	dummy_d_4 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_5;
// synthesis translate_on
always @(*) begin
	microwatt_dbus_ack <= 1'd0;
	interface1_adapted_interface_cyc <= 1'd0;
	interface1_adapted_interface_stb <= 1'd0;
	interface1_adapted_interface_we <= 1'd0;
	converter1_skip <= 1'd0;
	if ((microwatt_dbus_stb & microwatt_dbus_cyc)) begin
		converter1_skip <= ((interface1_adapted_interface_sel == 1'd0) & (interface1_adapted_interface_cti == 1'd0));
		interface1_adapted_interface_cyc <= (~converter1_skip);
		interface1_adapted_interface_stb <= (~converter1_skip);
		interface1_adapted_interface_we <= microwatt_dbus_we;
		if ((interface1_adapted_interface_ack | converter1_skip)) begin
			microwatt_dbus_ack <= converter1_done;
		end
	end
// synthesis translate_off
	dummy_d_5 <= dummy_s;
// synthesis translate_on
end
assign interface1_adapted_interface_adr = {microwatt_dbus_adr, converter1_count};

// synthesis translate_off
reg dummy_d_6;
// synthesis translate_on
always @(*) begin
	interface1_adapted_interface_dat_w <= 32'd0;
	case (converter1_count)
		1'd0: begin
			interface1_adapted_interface_dat_w <= microwatt_dbus_dat_w[63:0];
		end
		1'd1: begin
			interface1_adapted_interface_dat_w <= microwatt_dbus_dat_w[63:32];
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
	interface1_adapted_interface_sel <= 4'd0;
	case (converter1_count)
		1'd0: begin
			interface1_adapted_interface_sel <= microwatt_dbus_sel[7:0];
		end
		1'd1: begin
			interface1_adapted_interface_sel <= microwatt_dbus_sel[7:4];
		end
	endcase
// synthesis translate_off
	dummy_d_7 <= dummy_s;
// synthesis translate_on
end
assign microwatt_dbus_dat_r = {interface1_adapted_interface_dat_r, converter1_dat_r[63:32]};
assign shared_adr = array_muxed0;
assign shared_dat_w = array_muxed1;
assign shared_sel = array_muxed2;
assign shared_cyc = array_muxed3;
assign shared_stb = array_muxed4;
assign shared_we = array_muxed5;
assign shared_cti = array_muxed6;
assign shared_bte = array_muxed7;
assign interface0_adapted_interface_dat_r = shared_dat_r;
assign interface1_adapted_interface_dat_r = shared_dat_r;
assign interface0_adapted_interface_ack = (shared_ack & (grant == 1'd0));
assign interface1_adapted_interface_ack = (shared_ack & (grant == 1'd1));
assign interface0_adapted_interface_err = (shared_err & (grant == 1'd0));
assign interface1_adapted_interface_err = (shared_err & (grant == 1'd1));
assign request = {interface1_adapted_interface_cyc, interface0_adapted_interface_cyc};

// synthesis translate_off
reg dummy_d_8;
// synthesis translate_on
always @(*) begin
	slave_sel <= 3'd0;
	slave_sel[0] <= (shared_adr[29:10] == 1'd0);
	slave_sel[1] <= (shared_adr[29:3] == 27'd100663296);
	slave_sel[2] <= (shared_adr[29:14] == 16'd51200);
// synthesis translate_off
	dummy_d_8 <= dummy_s;
// synthesis translate_on
end
assign cf_sram_bus_adr = shared_adr;
assign cf_sram_bus_dat_w = shared_dat_w;
assign cf_sram_bus_sel = shared_sel;
assign cf_sram_bus_stb = shared_stb;
assign cf_sram_bus_we = shared_we;
assign cf_sram_bus_cti = shared_cti;
assign cf_sram_bus_bte = shared_bte;
assign cf_uart_bus_adr = shared_adr;
assign cf_uart_bus_dat_w = shared_dat_w;
assign cf_uart_bus_sel = shared_sel;
assign cf_uart_bus_stb = shared_stb;
assign cf_uart_bus_we = shared_we;
assign cf_uart_bus_cti = shared_cti;
assign cf_uart_bus_bte = shared_bte;
assign interface0_adr = shared_adr;
assign interface0_dat_w = shared_dat_w;
assign interface0_sel = shared_sel;
assign interface0_stb = shared_stb;
assign interface0_we = shared_we;
assign interface0_cti = shared_cti;
assign interface0_bte = shared_bte;
assign cf_sram_bus_cyc = (shared_cyc & slave_sel[0]);
assign cf_uart_bus_cyc = (shared_cyc & slave_sel[1]);
assign interface0_cyc = (shared_cyc & slave_sel[2]);
assign shared_err = ((cf_sram_bus_err | cf_uart_bus_err) | interface0_err);
assign wait_1 = ((shared_stb & shared_cyc) & (~shared_ack));

// synthesis translate_off
reg dummy_d_9;
// synthesis translate_on
always @(*) begin
	shared_dat_r <= 32'd0;
	shared_ack <= 1'd0;
	error <= 1'd0;
	shared_ack <= ((cf_sram_bus_ack | cf_uart_bus_ack) | interface0_ack);
	shared_dat_r <= ((({32{slave_sel_r[0]}} & cf_sram_bus_dat_r) | ({32{slave_sel_r[1]}} & cf_uart_bus_dat_r)) | ({32{slave_sel_r[2]}} & interface0_dat_r));
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
assign bus_errors_status = bus_errors;
assign uart_tx_fifo_sink_valid = uart_rxtx_re;
assign uart_tx_fifo_sink_payload_data = uart_rxtx_r;
assign uart_uart_source_valid = uart_tx_fifo_source_valid;
assign uart_tx_fifo_source_ready = uart_uart_source_ready;
assign uart_uart_source_first = uart_tx_fifo_source_first;
assign uart_uart_source_last = uart_tx_fifo_source_last;
assign uart_uart_source_payload_data = uart_tx_fifo_source_payload_data;
assign uart_txfull_status = (~uart_tx_fifo_sink_ready);
assign uart_txempty_status = (~uart_tx_fifo_source_valid);
assign uart_tx_trigger = uart_tx_fifo_sink_ready;
assign uart_rx_fifo_sink_valid = uart_uart_sink_valid;
assign uart_uart_sink_ready = uart_rx_fifo_sink_ready;
assign uart_rx_fifo_sink_first = uart_uart_sink_first;
assign uart_rx_fifo_sink_last = uart_uart_sink_last;
assign uart_rx_fifo_sink_payload_data = uart_uart_sink_payload_data;
assign uart_rxtx_w = uart_rx_fifo_source_payload_data;
assign uart_rx_fifo_source_ready = uart_rx_clear;
assign uart_rxempty_status = (~uart_rx_fifo_source_valid);
assign uart_rxfull_status = (~uart_rx_fifo_sink_ready);
assign uart_rx_trigger = uart_rx_fifo_source_valid;
assign uart_tx0 = uart_tx_status;
assign uart_tx1 = uart_tx_pending;

// synthesis translate_off
reg dummy_d_10;
// synthesis translate_on
always @(*) begin
	uart_tx_clear <= 1'd0;
	if ((uart_pending_re & uart_pending_r[0])) begin
		uart_tx_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_10 <= dummy_s;
// synthesis translate_on
end
assign uart_rx0 = uart_rx_status;
assign uart_rx1 = uart_rx_pending;

// synthesis translate_off
reg dummy_d_11;
// synthesis translate_on
always @(*) begin
	uart_rx_clear <= 1'd0;
	if ((uart_pending_re & uart_pending_r[1])) begin
		uart_rx_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_11 <= dummy_s;
// synthesis translate_on
end
assign uart_irq = ((uart_pending_status[0] & uart_enable_storage[0]) | (uart_pending_status[1] & uart_enable_storage[1]));
assign uart_tx_status = uart_tx_trigger;
assign uart_tx_pending = uart_tx_trigger;
assign uart_rx_status = uart_rx_trigger;
assign uart_rx_pending = uart_rx_trigger;
assign uart_tx_fifo_source_valid = uart_tx_fifo_sink_valid;
assign uart_tx_fifo_sink_ready = uart_tx_fifo_source_ready;
assign uart_tx_fifo_source_first = uart_tx_fifo_sink_first;
assign uart_tx_fifo_source_last = uart_tx_fifo_sink_last;
assign uart_tx_fifo_source_payload_data = uart_tx_fifo_sink_payload_data;
assign uart_rx_fifo_source_valid = uart_rx_fifo_sink_valid;
assign uart_rx_fifo_sink_ready = uart_rx_fifo_source_ready;
assign uart_rx_fifo_source_first = uart_rx_fifo_sink_first;
assign uart_rx_fifo_source_last = uart_rx_fifo_sink_last;
assign uart_rx_fifo_source_payload_data = uart_rx_fifo_sink_payload_data;
assign timer_zero_trigger = (timer_value == 1'd0);
assign timer_zero0 = timer_zero_status;
assign timer_zero1 = timer_zero_pending;

// synthesis translate_off
reg dummy_d_12;
// synthesis translate_on
always @(*) begin
	timer_zero_clear <= 1'd0;
	if ((timer_pending_re & timer_pending_r)) begin
		timer_zero_clear <= 1'd1;
	end
// synthesis translate_off
	dummy_d_12 <= dummy_s;
// synthesis translate_on
end
assign timer_irq = (timer_pending_status & timer_enable_storage);
assign timer_zero_status = timer_zero_trigger;
assign cf_uart_bus_err = 1'd0;

// synthesis translate_off
reg dummy_d_13;
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
	dummy_d_13 <= dummy_s;
// synthesis translate_on
end
assign csrbank0_sel = (interface0_bank_bus_adr[13:9] == 1'd0);
assign csrbank0_reset0_r = interface0_bank_bus_dat_w[1:0];

// synthesis translate_off
reg dummy_d_14;
// synthesis translate_on
always @(*) begin
	csrbank0_reset0_re <= 1'd0;
	csrbank0_reset0_we <= 1'd0;
	if ((csrbank0_sel & (interface0_bank_bus_adr[8:0] == 1'd0))) begin
		csrbank0_reset0_re <= interface0_bank_bus_we;
		csrbank0_reset0_we <= interface0_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_14 <= dummy_s;
// synthesis translate_on
end
assign csrbank0_scratch0_r = interface0_bank_bus_dat_w[31:0];

// synthesis translate_off
reg dummy_d_15;
// synthesis translate_on
always @(*) begin
	csrbank0_scratch0_re <= 1'd0;
	csrbank0_scratch0_we <= 1'd0;
	if ((csrbank0_sel & (interface0_bank_bus_adr[8:0] == 1'd1))) begin
		csrbank0_scratch0_re <= interface0_bank_bus_we;
		csrbank0_scratch0_we <= interface0_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_15 <= dummy_s;
// synthesis translate_on
end
assign csrbank0_bus_errors_r = interface0_bank_bus_dat_w[31:0];

// synthesis translate_off
reg dummy_d_16;
// synthesis translate_on
always @(*) begin
	csrbank0_bus_errors_re <= 1'd0;
	csrbank0_bus_errors_we <= 1'd0;
	if ((csrbank0_sel & (interface0_bank_bus_adr[8:0] == 2'd2))) begin
		csrbank0_bus_errors_re <= interface0_bank_bus_we;
		csrbank0_bus_errors_we <= interface0_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_16 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_17;
// synthesis translate_on
always @(*) begin
	soc_rst <= 1'd0;
	if (reset_re) begin
		soc_rst <= reset_storage[0];
	end
// synthesis translate_off
	dummy_d_17 <= dummy_s;
// synthesis translate_on
end
assign cpu_rst = reset_storage[1];
assign csrbank0_reset0_w = reset_storage[1:0];
assign csrbank0_scratch0_w = scratch_storage[31:0];
assign csrbank0_bus_errors_w = bus_errors_status[31:0];
assign bus_errors_we = csrbank0_bus_errors_we;
assign csrbank1_sel = (interface1_bank_bus_adr[13:9] == 1'd1);
assign csrbank1_load0_r = interface1_bank_bus_dat_w[31:0];

// synthesis translate_off
reg dummy_d_18;
// synthesis translate_on
always @(*) begin
	csrbank1_load0_re <= 1'd0;
	csrbank1_load0_we <= 1'd0;
	if ((csrbank1_sel & (interface1_bank_bus_adr[8:0] == 1'd0))) begin
		csrbank1_load0_re <= interface1_bank_bus_we;
		csrbank1_load0_we <= interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_18 <= dummy_s;
// synthesis translate_on
end
assign csrbank1_reload0_r = interface1_bank_bus_dat_w[31:0];

// synthesis translate_off
reg dummy_d_19;
// synthesis translate_on
always @(*) begin
	csrbank1_reload0_re <= 1'd0;
	csrbank1_reload0_we <= 1'd0;
	if ((csrbank1_sel & (interface1_bank_bus_adr[8:0] == 1'd1))) begin
		csrbank1_reload0_re <= interface1_bank_bus_we;
		csrbank1_reload0_we <= interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_19 <= dummy_s;
// synthesis translate_on
end
assign csrbank1_en0_r = interface1_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_20;
// synthesis translate_on
always @(*) begin
	csrbank1_en0_re <= 1'd0;
	csrbank1_en0_we <= 1'd0;
	if ((csrbank1_sel & (interface1_bank_bus_adr[8:0] == 2'd2))) begin
		csrbank1_en0_re <= interface1_bank_bus_we;
		csrbank1_en0_we <= interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_20 <= dummy_s;
// synthesis translate_on
end
assign csrbank1_update_value0_r = interface1_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_21;
// synthesis translate_on
always @(*) begin
	csrbank1_update_value0_re <= 1'd0;
	csrbank1_update_value0_we <= 1'd0;
	if ((csrbank1_sel & (interface1_bank_bus_adr[8:0] == 2'd3))) begin
		csrbank1_update_value0_re <= interface1_bank_bus_we;
		csrbank1_update_value0_we <= interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_21 <= dummy_s;
// synthesis translate_on
end
assign csrbank1_value_r = interface1_bank_bus_dat_w[31:0];

// synthesis translate_off
reg dummy_d_22;
// synthesis translate_on
always @(*) begin
	csrbank1_value_re <= 1'd0;
	csrbank1_value_we <= 1'd0;
	if ((csrbank1_sel & (interface1_bank_bus_adr[8:0] == 3'd4))) begin
		csrbank1_value_re <= interface1_bank_bus_we;
		csrbank1_value_we <= interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_22 <= dummy_s;
// synthesis translate_on
end
assign csrbank1_ev_status_r = interface1_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_23;
// synthesis translate_on
always @(*) begin
	csrbank1_ev_status_re <= 1'd0;
	csrbank1_ev_status_we <= 1'd0;
	if ((csrbank1_sel & (interface1_bank_bus_adr[8:0] == 3'd5))) begin
		csrbank1_ev_status_re <= interface1_bank_bus_we;
		csrbank1_ev_status_we <= interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_23 <= dummy_s;
// synthesis translate_on
end
assign csrbank1_ev_pending_r = interface1_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_24;
// synthesis translate_on
always @(*) begin
	csrbank1_ev_pending_re <= 1'd0;
	csrbank1_ev_pending_we <= 1'd0;
	if ((csrbank1_sel & (interface1_bank_bus_adr[8:0] == 3'd6))) begin
		csrbank1_ev_pending_re <= interface1_bank_bus_we;
		csrbank1_ev_pending_we <= interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_24 <= dummy_s;
// synthesis translate_on
end
assign csrbank1_ev_enable0_r = interface1_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_25;
// synthesis translate_on
always @(*) begin
	csrbank1_ev_enable0_re <= 1'd0;
	csrbank1_ev_enable0_we <= 1'd0;
	if ((csrbank1_sel & (interface1_bank_bus_adr[8:0] == 3'd7))) begin
		csrbank1_ev_enable0_re <= interface1_bank_bus_we;
		csrbank1_ev_enable0_we <= interface1_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_25 <= dummy_s;
// synthesis translate_on
end
assign csrbank1_load0_w = timer_load_storage[31:0];
assign csrbank1_reload0_w = timer_reload_storage[31:0];
assign csrbank1_en0_w = timer_en_storage;
assign csrbank1_update_value0_w = timer_update_value_storage;
assign csrbank1_value_w = timer_value_status[31:0];
assign timer_value_we = csrbank1_value_we;
assign timer_status_status = timer_zero0;
assign csrbank1_ev_status_w = timer_status_status;
assign timer_status_we = csrbank1_ev_status_we;
assign timer_pending_status = timer_zero1;
assign csrbank1_ev_pending_w = timer_pending_status;
assign timer_pending_we = csrbank1_ev_pending_we;
assign timer_zero2 = timer_enable_storage;
assign csrbank1_ev_enable0_w = timer_enable_storage;
assign csrbank2_sel = (interface2_bank_bus_adr[13:9] == 2'd2);
assign uart_rxtx_r = interface2_bank_bus_dat_w[7:0];

// synthesis translate_off
reg dummy_d_26;
// synthesis translate_on
always @(*) begin
	uart_rxtx_re <= 1'd0;
	uart_rxtx_we <= 1'd0;
	if ((csrbank2_sel & (interface2_bank_bus_adr[8:0] == 1'd0))) begin
		uart_rxtx_re <= interface2_bank_bus_we;
		uart_rxtx_we <= interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_26 <= dummy_s;
// synthesis translate_on
end
assign csrbank2_txfull_r = interface2_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_27;
// synthesis translate_on
always @(*) begin
	csrbank2_txfull_re <= 1'd0;
	csrbank2_txfull_we <= 1'd0;
	if ((csrbank2_sel & (interface2_bank_bus_adr[8:0] == 1'd1))) begin
		csrbank2_txfull_re <= interface2_bank_bus_we;
		csrbank2_txfull_we <= interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_27 <= dummy_s;
// synthesis translate_on
end
assign csrbank2_rxempty_r = interface2_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_28;
// synthesis translate_on
always @(*) begin
	csrbank2_rxempty_re <= 1'd0;
	csrbank2_rxempty_we <= 1'd0;
	if ((csrbank2_sel & (interface2_bank_bus_adr[8:0] == 2'd2))) begin
		csrbank2_rxempty_re <= interface2_bank_bus_we;
		csrbank2_rxempty_we <= interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_28 <= dummy_s;
// synthesis translate_on
end
assign csrbank2_ev_status_r = interface2_bank_bus_dat_w[1:0];

// synthesis translate_off
reg dummy_d_29;
// synthesis translate_on
always @(*) begin
	csrbank2_ev_status_re <= 1'd0;
	csrbank2_ev_status_we <= 1'd0;
	if ((csrbank2_sel & (interface2_bank_bus_adr[8:0] == 2'd3))) begin
		csrbank2_ev_status_re <= interface2_bank_bus_we;
		csrbank2_ev_status_we <= interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_29 <= dummy_s;
// synthesis translate_on
end
assign csrbank2_ev_pending_r = interface2_bank_bus_dat_w[1:0];

// synthesis translate_off
reg dummy_d_30;
// synthesis translate_on
always @(*) begin
	csrbank2_ev_pending_re <= 1'd0;
	csrbank2_ev_pending_we <= 1'd0;
	if ((csrbank2_sel & (interface2_bank_bus_adr[8:0] == 3'd4))) begin
		csrbank2_ev_pending_re <= interface2_bank_bus_we;
		csrbank2_ev_pending_we <= interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_30 <= dummy_s;
// synthesis translate_on
end
assign csrbank2_ev_enable0_r = interface2_bank_bus_dat_w[1:0];

// synthesis translate_off
reg dummy_d_31;
// synthesis translate_on
always @(*) begin
	csrbank2_ev_enable0_re <= 1'd0;
	csrbank2_ev_enable0_we <= 1'd0;
	if ((csrbank2_sel & (interface2_bank_bus_adr[8:0] == 3'd5))) begin
		csrbank2_ev_enable0_re <= interface2_bank_bus_we;
		csrbank2_ev_enable0_we <= interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_31 <= dummy_s;
// synthesis translate_on
end
assign csrbank2_txempty_r = interface2_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_32;
// synthesis translate_on
always @(*) begin
	csrbank2_txempty_re <= 1'd0;
	csrbank2_txempty_we <= 1'd0;
	if ((csrbank2_sel & (interface2_bank_bus_adr[8:0] == 3'd6))) begin
		csrbank2_txempty_re <= interface2_bank_bus_we;
		csrbank2_txempty_we <= interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_32 <= dummy_s;
// synthesis translate_on
end
assign csrbank2_rxfull_r = interface2_bank_bus_dat_w[0];

// synthesis translate_off
reg dummy_d_33;
// synthesis translate_on
always @(*) begin
	csrbank2_rxfull_re <= 1'd0;
	csrbank2_rxfull_we <= 1'd0;
	if ((csrbank2_sel & (interface2_bank_bus_adr[8:0] == 3'd7))) begin
		csrbank2_rxfull_re <= interface2_bank_bus_we;
		csrbank2_rxfull_we <= interface2_bank_bus_re;
	end
// synthesis translate_off
	dummy_d_33 <= dummy_s;
// synthesis translate_on
end
assign csrbank2_txfull_w = uart_txfull_status;
assign uart_txfull_we = csrbank2_txfull_we;
assign csrbank2_rxempty_w = uart_rxempty_status;
assign uart_rxempty_we = csrbank2_rxempty_we;

// synthesis translate_off
reg dummy_d_34;
// synthesis translate_on
always @(*) begin
	uart_status_status <= 2'd0;
	uart_status_status[0] <= uart_tx0;
	uart_status_status[1] <= uart_rx0;
// synthesis translate_off
	dummy_d_34 <= dummy_s;
// synthesis translate_on
end
assign csrbank2_ev_status_w = uart_status_status[1:0];
assign uart_status_we = csrbank2_ev_status_we;

// synthesis translate_off
reg dummy_d_35;
// synthesis translate_on
always @(*) begin
	uart_pending_status <= 2'd0;
	uart_pending_status[0] <= uart_tx1;
	uart_pending_status[1] <= uart_rx1;
// synthesis translate_off
	dummy_d_35 <= dummy_s;
// synthesis translate_on
end
assign csrbank2_ev_pending_w = uart_pending_status[1:0];
assign uart_pending_we = csrbank2_ev_pending_we;
assign uart_tx2 = uart_enable_storage[0];
assign uart_rx2 = uart_enable_storage[1];
assign csrbank2_ev_enable0_w = uart_enable_storage[1:0];
assign csrbank2_txempty_w = uart_txempty_status;
assign uart_txempty_we = csrbank2_txempty_we;
assign csrbank2_rxfull_w = uart_rxfull_status;
assign uart_rxfull_we = csrbank2_rxfull_we;
assign adr = interface1_adr;
assign re = interface1_re;
assign we = interface1_we;
assign dat_w = interface1_dat_w;
assign interface1_dat_r = dat_r;
assign interface0_bank_bus_adr = adr;
assign interface1_bank_bus_adr = adr;
assign interface2_bank_bus_adr = adr;
assign interface0_bank_bus_re = re;
assign interface1_bank_bus_re = re;
assign interface2_bank_bus_re = re;
assign interface0_bank_bus_we = we;
assign interface1_bank_bus_we = we;
assign interface2_bank_bus_we = we;
assign interface0_bank_bus_dat_w = dat_w;
assign interface1_bank_bus_dat_w = dat_w;
assign interface2_bank_bus_dat_w = dat_w;
assign dat_r = ((interface0_bank_bus_dat_r | interface1_bank_bus_dat_r) | interface2_bank_bus_dat_r);

// synthesis translate_off
reg dummy_d_36;
// synthesis translate_on
always @(*) begin
	array_muxed0 <= 30'd0;
	case (grant)
		1'd0: begin
			array_muxed0 <= interface0_adapted_interface_adr;
		end
		default: begin
			array_muxed0 <= interface1_adapted_interface_adr;
		end
	endcase
// synthesis translate_off
	dummy_d_36 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_37;
// synthesis translate_on
always @(*) begin
	array_muxed1 <= 32'd0;
	case (grant)
		1'd0: begin
			array_muxed1 <= interface0_adapted_interface_dat_w;
		end
		default: begin
			array_muxed1 <= interface1_adapted_interface_dat_w;
		end
	endcase
// synthesis translate_off
	dummy_d_37 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_38;
// synthesis translate_on
always @(*) begin
	array_muxed2 <= 4'd0;
	case (grant)
		1'd0: begin
			array_muxed2 <= interface0_adapted_interface_sel;
		end
		default: begin
			array_muxed2 <= interface1_adapted_interface_sel;
		end
	endcase
// synthesis translate_off
	dummy_d_38 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_39;
// synthesis translate_on
always @(*) begin
	array_muxed3 <= 1'd0;
	case (grant)
		1'd0: begin
			array_muxed3 <= interface0_adapted_interface_cyc;
		end
		default: begin
			array_muxed3 <= interface1_adapted_interface_cyc;
		end
	endcase
// synthesis translate_off
	dummy_d_39 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_40;
// synthesis translate_on
always @(*) begin
	array_muxed4 <= 1'd0;
	case (grant)
		1'd0: begin
			array_muxed4 <= interface0_adapted_interface_stb;
		end
		default: begin
			array_muxed4 <= interface1_adapted_interface_stb;
		end
	endcase
// synthesis translate_off
	dummy_d_40 <= dummy_s;
// synthesis translate_on
end

// synthesis translate_off
reg dummy_d_41;
// synthesis translate_on
always @(*) begin
	array_muxed5 <= 1'd0;
	case (grant)
		1'd0: begin
			array_muxed5 <= interface0_adapted_interface_we;
		end
		default: begin
			array_muxed5 <= interface1_adapted_interface_we;
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
	array_muxed6 <= 3'd0;
	case (grant)
		1'd0: begin
			array_muxed6 <= interface0_adapted_interface_cti;
		end
		default: begin
			array_muxed6 <= interface1_adapted_interface_cti;
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
	array_muxed7 <= 2'd0;
	case (grant)
		1'd0: begin
			array_muxed7 <= interface0_adapted_interface_bte;
		end
		default: begin
			array_muxed7 <= interface1_adapted_interface_bte;
		end
	endcase
// synthesis translate_off
	dummy_d_43 <= dummy_s;
// synthesis translate_on
end

always @(posedge sys_clk) begin
	if ((((interface0_adapted_interface_stb & interface0_adapted_interface_cyc) & interface0_adapted_interface_ack) | converter0_skip)) begin
		converter0_count <= (converter0_count + 1'd1);
	end
	if ((microwatt_ibus_ack | (~microwatt_ibus_cyc))) begin
		converter0_count <= 1'd0;
	end
	if ((interface0_adapted_interface_ack | converter0_skip)) begin
		converter0_dat_r <= microwatt_ibus_dat_r;
	end
	if ((((interface1_adapted_interface_stb & interface1_adapted_interface_cyc) & interface1_adapted_interface_ack) | converter1_skip)) begin
		converter1_count <= (converter1_count + 1'd1);
	end
	if ((microwatt_dbus_ack | (~microwatt_dbus_cyc))) begin
		converter1_count <= 1'd0;
	end
	if ((interface1_adapted_interface_ack | converter1_skip)) begin
		converter1_dat_r <= microwatt_dbus_dat_r;
	end
	case (grant)
		1'd0: begin
			if ((~request[0])) begin
				if (request[1]) begin
					grant <= 1'd1;
				end
			end
		end
		1'd1: begin
			if ((~request[1])) begin
				if (request[0]) begin
					grant <= 1'd0;
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
	if ((bus_errors != 32'd4294967295)) begin
		if (bus_error) begin
			bus_errors <= (bus_errors + 1'd1);
		end
	end
	if (timer_en_storage) begin
		if ((timer_value == 1'd0)) begin
			timer_value <= timer_reload_storage;
		end else begin
			timer_value <= (timer_value - 1'd1);
		end
	end else begin
		timer_value <= timer_load_storage;
	end
	if (timer_update_value_re) begin
		timer_value_status <= timer_value;
	end
	if (timer_zero_clear) begin
		timer_zero_pending <= 1'd0;
	end
	timer_zero_trigger_d <= timer_zero_trigger;
	if ((timer_zero_trigger & (~timer_zero_trigger_d))) begin
		timer_zero_pending <= 1'd1;
	end
	state <= next_state;
	interface0_bank_bus_dat_r <= 1'd0;
	if (csrbank0_sel) begin
		case (interface0_bank_bus_adr[8:0])
			1'd0: begin
				interface0_bank_bus_dat_r <= csrbank0_reset0_w;
			end
			1'd1: begin
				interface0_bank_bus_dat_r <= csrbank0_scratch0_w;
			end
			2'd2: begin
				interface0_bank_bus_dat_r <= csrbank0_bus_errors_w;
			end
		endcase
	end
	if (csrbank0_reset0_re) begin
		reset_storage[1:0] <= csrbank0_reset0_r;
	end
	reset_re <= csrbank0_reset0_re;
	if (csrbank0_scratch0_re) begin
		scratch_storage[31:0] <= csrbank0_scratch0_r;
	end
	scratch_re <= csrbank0_scratch0_re;
	bus_errors_re <= csrbank0_bus_errors_re;
	interface1_bank_bus_dat_r <= 1'd0;
	if (csrbank1_sel) begin
		case (interface1_bank_bus_adr[8:0])
			1'd0: begin
				interface1_bank_bus_dat_r <= csrbank1_load0_w;
			end
			1'd1: begin
				interface1_bank_bus_dat_r <= csrbank1_reload0_w;
			end
			2'd2: begin
				interface1_bank_bus_dat_r <= csrbank1_en0_w;
			end
			2'd3: begin
				interface1_bank_bus_dat_r <= csrbank1_update_value0_w;
			end
			3'd4: begin
				interface1_bank_bus_dat_r <= csrbank1_value_w;
			end
			3'd5: begin
				interface1_bank_bus_dat_r <= csrbank1_ev_status_w;
			end
			3'd6: begin
				interface1_bank_bus_dat_r <= csrbank1_ev_pending_w;
			end
			3'd7: begin
				interface1_bank_bus_dat_r <= csrbank1_ev_enable0_w;
			end
		endcase
	end
	if (csrbank1_load0_re) begin
		timer_load_storage[31:0] <= csrbank1_load0_r;
	end
	timer_load_re <= csrbank1_load0_re;
	if (csrbank1_reload0_re) begin
		timer_reload_storage[31:0] <= csrbank1_reload0_r;
	end
	timer_reload_re <= csrbank1_reload0_re;
	if (csrbank1_en0_re) begin
		timer_en_storage <= csrbank1_en0_r;
	end
	timer_en_re <= csrbank1_en0_re;
	if (csrbank1_update_value0_re) begin
		timer_update_value_storage <= csrbank1_update_value0_r;
	end
	timer_update_value_re <= csrbank1_update_value0_re;
	timer_value_re <= csrbank1_value_re;
	timer_status_re <= csrbank1_ev_status_re;
	if (csrbank1_ev_pending_re) begin
		timer_pending_r <= csrbank1_ev_pending_r;
	end
	timer_pending_re <= csrbank1_ev_pending_re;
	if (csrbank1_ev_enable0_re) begin
		timer_enable_storage <= csrbank1_ev_enable0_r;
	end
	timer_enable_re <= csrbank1_ev_enable0_re;
	interface2_bank_bus_dat_r <= 1'd0;
	if (csrbank2_sel) begin
		case (interface2_bank_bus_adr[8:0])
			1'd0: begin
				interface2_bank_bus_dat_r <= uart_rxtx_w;
			end
			1'd1: begin
				interface2_bank_bus_dat_r <= csrbank2_txfull_w;
			end
			2'd2: begin
				interface2_bank_bus_dat_r <= csrbank2_rxempty_w;
			end
			2'd3: begin
				interface2_bank_bus_dat_r <= csrbank2_ev_status_w;
			end
			3'd4: begin
				interface2_bank_bus_dat_r <= csrbank2_ev_pending_w;
			end
			3'd5: begin
				interface2_bank_bus_dat_r <= csrbank2_ev_enable0_w;
			end
			3'd6: begin
				interface2_bank_bus_dat_r <= csrbank2_txempty_w;
			end
			3'd7: begin
				interface2_bank_bus_dat_r <= csrbank2_rxfull_w;
			end
		endcase
	end
	uart_txfull_re <= csrbank2_txfull_re;
	uart_rxempty_re <= csrbank2_rxempty_re;
	uart_status_re <= csrbank2_ev_status_re;
	if (csrbank2_ev_pending_re) begin
		uart_pending_r[1:0] <= csrbank2_ev_pending_r;
	end
	uart_pending_re <= csrbank2_ev_pending_re;
	if (csrbank2_ev_enable0_re) begin
		uart_enable_storage[1:0] <= csrbank2_ev_enable0_r;
	end
	uart_enable_re <= csrbank2_ev_enable0_re;
	uart_txempty_re <= csrbank2_txempty_re;
	uart_rxfull_re <= csrbank2_rxfull_re;
	if (sys_rst) begin
		reset_storage <= 2'd0;
		reset_re <= 1'd0;
		scratch_storage <= 32'd305419896;
		scratch_re <= 1'd0;
		bus_errors_re <= 1'd0;
		bus_errors <= 32'd0;
		converter0_count <= 1'd0;
		converter1_count <= 1'd0;
		uart_txfull_re <= 1'd0;
		uart_rxempty_re <= 1'd0;
		uart_status_re <= 1'd0;
		uart_pending_re <= 1'd0;
		uart_pending_r <= 2'd0;
		uart_enable_storage <= 2'd0;
		uart_enable_re <= 1'd0;
		uart_txempty_re <= 1'd0;
		uart_rxfull_re <= 1'd0;
		timer_load_storage <= 32'd0;
		timer_load_re <= 1'd0;
		timer_reload_storage <= 32'd0;
		timer_reload_re <= 1'd0;
		timer_en_storage <= 1'd0;
		timer_en_re <= 1'd0;
		timer_update_value_storage <= 1'd0;
		timer_update_value_re <= 1'd0;
		timer_value_status <= 32'd0;
		timer_value_re <= 1'd0;
		timer_zero_pending <= 1'd0;
		timer_zero_trigger_d <= 1'd0;
		timer_status_re <= 1'd0;
		timer_pending_re <= 1'd0;
		timer_pending_r <= 1'd0;
		timer_enable_storage <= 1'd0;
		timer_enable_re <= 1'd0;
		timer_value <= 32'd0;
		grant <= 1'd0;
		slave_sel_r <= 3'd0;
		count <= 20'd1000000;
		state <= 1'd0;
	end
end

SRAM_1024x32 SRAM_1024x32(
	.wb_adr_i(cf_sram_bus_adr),
	.wb_clk_i(sys_clk),
	.wb_cyc_i(cf_sram_bus_cyc),
	.wb_dat_i(cf_sram_bus_dat_w),
	.wb_rst_i(sys_rst),
	.wb_sel_i(cf_sram_bus_sel),
	.wb_stb_i(cf_sram_bus_stb),
	.wb_we_i(cf_sram_bus_we),
	.wb_ack_o(cf_sram_bus_ack),
	.wb_dat_o(cf_sram_bus_dat_r),
	.wb_err_o(cf_sram_bus_err)
);

CF_UART #(
	.DIVISOR(5'd27)
) CF_UART (
	.rx(serial_rx),
	.wb_adr_i(cf_uart_bus_adr),
	.wb_clk_i(sys_clk),
	.wb_cyc_i(cf_uart_bus_cyc),
	.wb_dat_i(cf_uart_bus_dat_w),
	.wb_rst_i(sys_rst),
	.wb_sel_i(cf_uart_bus_sel),
	.wb_stb_i(cf_uart_bus_stb),
	.wb_we_i(cf_uart_bus_we),
	.tx(serial_tx),
	.wb_ack_o(cf_uart_bus_ack),
	.wb_dat_o(cf_uart_bus_dat_r)
);

microwatt_wrapper microwatt_wrapper(
	.clk(sys_clk),
	.core_ext_irq(microwatt_core_ext_irq),
	.dmi_addr(1'd0),
	.dmi_din(1'd0),
	.dmi_req(1'd0),
	.dmi_wr(1'd0),
	.rst((sys_rst | microwatt_reset)),
	.wb_snoop_in_adr(1'd0),
	.wb_snoop_in_cyc(1'd0),
	.wb_snoop_in_dat_w(1'd0),
	.wb_snoop_in_sel(1'd0),
	.wb_snoop_in_stb(1'd0),
	.wb_snoop_in_we(1'd0),
	.wishbone_data_ack(microwatt_dbus_ack),
	.wishbone_data_dat_r(microwatt_dbus_dat_r),
	.wishbone_data_stall((microwatt_dbus_cyc & (~microwatt_dbus_ack))),
	.wishbone_insn_ack(microwatt_ibus_ack),
	.wishbone_insn_dat_r(microwatt_ibus_dat_r),
	.wishbone_insn_stall((microwatt_ibus_cyc & (~microwatt_ibus_ack))),
	.dmi_ack(microwatt1),
	.dmi_dout(microwatt0),
	.wishbone_data_adr(microwatt_dbus_adr),
	.wishbone_data_cyc(microwatt_dbus_cyc),
	.wishbone_data_dat_w(microwatt_dbus_dat_w),
	.wishbone_data_sel(microwatt_dbus_sel),
	.wishbone_data_stb(microwatt_dbus_stb),
	.wishbone_data_we(microwatt_dbus_we),
	.wishbone_insn_adr(microwatt_ibus_adr),
	.wishbone_insn_cyc(microwatt_ibus_cyc),
	.wishbone_insn_dat_w(microwatt_ibus_dat_w),
	.wishbone_insn_sel(microwatt_ibus_sel),
	.wishbone_insn_stb(microwatt_ibus_stb),
	.wishbone_insn_we(microwatt_ibus_we)
);

endmodule

