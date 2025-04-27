`define assert(expression) \
        if (!(expression)) begin \
            $display("ASSERTION FAILED"); \
            $finish; \
        end
module riscv_peripherals (
	clk_i,
	rst_ni,
	testmode_i,
	priv_lvl_i,
	debug_mode_i,
	we_flag_0,
	we_flag_1,
	we_flag_2,
	we_flag_3,
	we_flag_4,
	pmpcfg_i,
	pmpaddr_i,
	buf_ariane_rsa_noc2_data_i,
	buf_ariane_rsa_noc2_valid_i,
	ariane_rsa_buf_noc2_ready_o,
	ariane_rsa_buf_noc3_data_o,
	ariane_rsa_buf_noc3_valid_o,
	buf_ariane_rsa_noc3_ready_i,
	buf_ariane_rng_noc2_data_i,
	buf_ariane_rng_noc2_valid_i,
	ariane_rng_buf_noc2_ready_o,
	ariane_rng_buf_noc3_data_o,
	ariane_rng_buf_noc3_valid_o,
	buf_ariane_rng_noc3_ready_i,
	buf_ariane_debug_noc2_data_i,
	buf_ariane_debug_noc2_valid_i,
	ariane_debug_buf_noc2_ready_o,
	ariane_debug_buf_noc3_data_o,
	ariane_debug_buf_noc3_valid_o,
	buf_ariane_debug_noc3_ready_i,
	buf_ariane_bootrom_noc2_data_i,
	buf_ariane_bootrom_noc2_valid_i,
	ariane_bootrom_buf_noc2_ready_o,
	ariane_bootrom_buf_noc3_data_o,
	ariane_bootrom_buf_noc3_valid_o,
	buf_ariane_bootrom_noc3_ready_i,
	buf_ariane_clint_noc2_data_i,
	buf_ariane_clint_noc2_valid_i,
	ariane_clint_buf_noc2_ready_o,
	ariane_clint_buf_noc3_data_o,
	ariane_clint_buf_noc3_valid_o,
	buf_ariane_clint_noc3_ready_i,
	buf_ariane_plic_noc2_data_i,
	buf_ariane_plic_noc2_valid_i,
	ariane_plic_buf_noc2_ready_o,
	ariane_plic_buf_noc3_data_o,
	ariane_plic_buf_noc3_valid_o,
	buf_ariane_plic_noc3_ready_i,
	buf_ariane_aes0_noc2_data_i,
	buf_ariane_aes0_noc2_valid_i,
	ariane_aes0_buf_noc2_ready_o,
	ariane_aes0_buf_noc3_data_o,
	ariane_aes0_buf_noc3_valid_o,
	buf_ariane_aes0_noc3_ready_i,
	buf_ariane_aes1_noc2_data_i,
	buf_ariane_aes1_noc2_valid_i,
	ariane_aes1_buf_noc2_ready_o,
	ariane_aes1_buf_noc3_data_o,
	ariane_aes1_buf_noc3_valid_o,
	buf_ariane_aes1_noc3_ready_i,
	buf_ariane_aes2_noc2_data_i,
	buf_ariane_aes2_noc2_valid_i,
	ariane_aes2_buf_noc2_ready_o,
	ariane_aes2_buf_noc3_data_o,
	ariane_aes2_buf_noc3_valid_o,
	buf_ariane_aes2_noc3_ready_i,
	buf_ariane_rst_noc2_data_i,
	buf_ariane_rst_noc2_valid_i,
	ariane_rst_buf_noc2_ready_o,
	ariane_rst_buf_noc3_data_o,
	ariane_rst_buf_noc3_valid_o,
	buf_ariane_rst_noc3_ready_i,
	buf_ariane_sha256_noc2_data_i,
	buf_ariane_sha256_noc2_valid_i,
	ariane_sha256_buf_noc2_ready_o,
	ariane_sha256_buf_noc3_data_o,
	ariane_sha256_buf_noc3_valid_o,
	buf_ariane_sha256_noc3_ready_i,
	buf_ariane_hmac_noc2_data_i,
	buf_ariane_hmac_noc2_valid_i,
	ariane_hmac_buf_noc2_ready_o,
	ariane_hmac_buf_noc3_data_o,
	ariane_hmac_buf_noc3_valid_o,
	buf_ariane_hmac_noc3_ready_i,
	buf_ariane_pkt_noc2_data_i,
	buf_ariane_pkt_noc2_valid_i,
	ariane_pkt_buf_noc2_ready_o,
	ariane_pkt_buf_noc3_data_o,
	ariane_pkt_buf_noc3_valid_o,
	buf_ariane_pkt_noc3_ready_i,
	buf_ariane_acct_noc2_data_i,
	buf_ariane_acct_noc2_valid_i,
	ariane_acct_buf_noc2_ready_o,
	ariane_acct_buf_noc3_data_o,
	ariane_acct_buf_noc3_valid_o,
	buf_ariane_acct_noc3_ready_i,
	buf_ariane_reglk_noc2_data_i,
	buf_ariane_reglk_noc2_valid_i,
	ariane_reglk_buf_noc2_ready_o,
	ariane_reglk_buf_noc3_data_o,
	ariane_reglk_buf_noc3_valid_o,
	buf_ariane_reglk_noc3_ready_i,
	buf_ariane_dma_noc2_data_i,
	buf_ariane_dma_noc2_valid_i,
	ariane_dma_buf_noc2_ready_o,
	ariane_dma_buf_noc3_data_o,
	ariane_dma_buf_noc3_valid_o,
	buf_ariane_dma_noc3_ready_i,
	ariane_boot_sel_i,
	ndmreset_o,
	dmactive_o,
	debug_req_o,
	unavailable_i,
	tck_i,
	tms_i,
	trst_ni,
	td_i,
	td_o,
	tdo_oe_o,
	rtc_i,
	timer_irq_o,
	ipi_o,
	irq_sources_i,
	irq_le_i,
	irq_o
);
	reg _sv2v_0;
	parameter [31:0] DataWidth = 64;
	parameter [31:0] NumHarts = 1;
	parameter [31:0] NumSources = 1;
	parameter [31:0] PlicMaxPriority = 7;
	parameter [0:0] SwapEndianess = 0;
	parameter [63:0] DmBase = 64'h000000fff1000000;
	parameter [63:0] RomBase = 64'h000000fff1010000;
	parameter [63:0] ClintBase = 64'h000000fff1020000;
	parameter [63:0] PlicBase = 64'h000000fff1100000;
	parameter [63:0] AES0Base = 64'h000000fff5200000;
	parameter [63:0] AES1Base = 64'h000000fff5201000;
	parameter [63:0] AES2Base = 64'h000000fff5209000;
	parameter [63:0] SHA256Base = 64'h000000fff5202000;
	parameter [63:0] HMACBase = 64'h000000fff5203000;
	parameter [63:0] PKTBase = 64'h000000fff5204000;
	parameter [63:0] ACCTBase = 64'h000000fff5205000;
	parameter [63:0] REGLKBase = 64'h000000fff5206000;
	parameter [63:0] DMABase = 64'h000000fff5207000;
	parameter [63:0] RNGBase = 64'h000000fff5208000;
	parameter [63:0] RSTBase = 64'h000000fff520a000;
	parameter [63:0] RSABase = 64'h000000fff5211000;
	input clk_i;
	input rst_ni;
	input testmode_i;
	input wire [1:0] priv_lvl_i;
	input debug_mode_i;
	input we_flag_0;
	input we_flag_1;
	input we_flag_2;
	input we_flag_3;
	input we_flag_4;
	input wire [127:0] pmpcfg_i;
	input [863:0] pmpaddr_i;
	input [DataWidth - 1:0] buf_ariane_rsa_noc2_data_i;
	input buf_ariane_rsa_noc2_valid_i;
	output wire ariane_rsa_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_rsa_buf_noc3_data_o;
	output wire ariane_rsa_buf_noc3_valid_o;
	input buf_ariane_rsa_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_rng_noc2_data_i;
	input buf_ariane_rng_noc2_valid_i;
	output wire ariane_rng_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_rng_buf_noc3_data_o;
	output wire ariane_rng_buf_noc3_valid_o;
	input buf_ariane_rng_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_debug_noc2_data_i;
	input buf_ariane_debug_noc2_valid_i;
	output wire ariane_debug_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_debug_buf_noc3_data_o;
	output wire ariane_debug_buf_noc3_valid_o;
	input buf_ariane_debug_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_bootrom_noc2_data_i;
	input buf_ariane_bootrom_noc2_valid_i;
	output wire ariane_bootrom_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_bootrom_buf_noc3_data_o;
	output wire ariane_bootrom_buf_noc3_valid_o;
	input buf_ariane_bootrom_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_clint_noc2_data_i;
	input buf_ariane_clint_noc2_valid_i;
	output wire ariane_clint_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_clint_buf_noc3_data_o;
	output wire ariane_clint_buf_noc3_valid_o;
	input buf_ariane_clint_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_plic_noc2_data_i;
	input buf_ariane_plic_noc2_valid_i;
	output wire ariane_plic_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_plic_buf_noc3_data_o;
	output wire ariane_plic_buf_noc3_valid_o;
	input buf_ariane_plic_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_aes0_noc2_data_i;
	input buf_ariane_aes0_noc2_valid_i;
	output wire ariane_aes0_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_aes0_buf_noc3_data_o;
	output wire ariane_aes0_buf_noc3_valid_o;
	input buf_ariane_aes0_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_aes1_noc2_data_i;
	input buf_ariane_aes1_noc2_valid_i;
	output wire ariane_aes1_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_aes1_buf_noc3_data_o;
	output wire ariane_aes1_buf_noc3_valid_o;
	input buf_ariane_aes1_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_aes2_noc2_data_i;
	input buf_ariane_aes2_noc2_valid_i;
	output wire ariane_aes2_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_aes2_buf_noc3_data_o;
	output wire ariane_aes2_buf_noc3_valid_o;
	input buf_ariane_aes2_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_rst_noc2_data_i;
	input buf_ariane_rst_noc2_valid_i;
	output wire ariane_rst_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_rst_buf_noc3_data_o;
	output wire ariane_rst_buf_noc3_valid_o;
	input buf_ariane_rst_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_sha256_noc2_data_i;
	input buf_ariane_sha256_noc2_valid_i;
	output wire ariane_sha256_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_sha256_buf_noc3_data_o;
	output wire ariane_sha256_buf_noc3_valid_o;
	input buf_ariane_sha256_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_hmac_noc2_data_i;
	input buf_ariane_hmac_noc2_valid_i;
	output wire ariane_hmac_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_hmac_buf_noc3_data_o;
	output wire ariane_hmac_buf_noc3_valid_o;
	input buf_ariane_hmac_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_pkt_noc2_data_i;
	input buf_ariane_pkt_noc2_valid_i;
	output wire ariane_pkt_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_pkt_buf_noc3_data_o;
	output wire ariane_pkt_buf_noc3_valid_o;
	input buf_ariane_pkt_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_acct_noc2_data_i;
	input buf_ariane_acct_noc2_valid_i;
	output wire ariane_acct_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_acct_buf_noc3_data_o;
	output wire ariane_acct_buf_noc3_valid_o;
	input buf_ariane_acct_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_reglk_noc2_data_i;
	input buf_ariane_reglk_noc2_valid_i;
	output wire ariane_reglk_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_reglk_buf_noc3_data_o;
	output wire ariane_reglk_buf_noc3_valid_o;
	input buf_ariane_reglk_noc3_ready_i;
	input [DataWidth - 1:0] buf_ariane_dma_noc2_data_i;
	input buf_ariane_dma_noc2_valid_i;
	output wire ariane_dma_buf_noc2_ready_o;
	output wire [DataWidth - 1:0] ariane_dma_buf_noc3_data_o;
	output wire ariane_dma_buf_noc3_valid_o;
	input buf_ariane_dma_noc3_ready_i;
	input ariane_boot_sel_i;
	output wire ndmreset_o;
	output wire dmactive_o;
	output wire [NumHarts - 1:0] debug_req_o;
	input [NumHarts - 1:0] unavailable_i;
	input tck_i;
	input tms_i;
	input trst_ni;
	input td_i;
	output wire td_o;
	output wire tdo_oe_o;
	input rtc_i;
	output wire [NumHarts - 1:0] timer_irq_o;
	output wire [NumHarts - 1:0] ipi_o;
	input [NumSources - 1:0] irq_sources_i;
	input [NumSources - 1:0] irq_le_i;
	output wire [(NumHarts * 2) - 1:0] irq_o;
	localparam [31:0] AxiIdWidth = 1;
	localparam [31:0] AxiAddrWidth = 64;
	localparam [31:0] AxiDataWidth = 64;
	localparam [31:0] AxiUserWidth = 1;
	parameter FUSE_MEM_SIZE = 150;
	parameter NB_SLAVE = 1;
	parameter NB_PERIPHERALS = 14;
	wire [(8 * NB_PERIPHERALS) - 1:0] reglk_ctrl;
	wire [(4 * NB_PERIPHERALS) - 1:0] acc_ctrl;
	wire [(4 * NB_PERIPHERALS) - 1:0] acc_ctrl_c;
	genvar _gv_i_1;
	genvar _gv_j_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < 4; _gv_i_1 = _gv_i_1 + 1) begin : genblk1
			localparam i = _gv_i_1;
			for (_gv_j_1 = 0; _gv_j_1 < NB_PERIPHERALS; _gv_j_1 = _gv_j_1 + 1) begin : genblk1
				localparam j = _gv_j_1;
				assign acc_ctrl_c[(i * NB_PERIPHERALS) + j] = acc_ctrl[(j * 4) + i] | ((j == 5) && acc_ctrl[16 + i]);
			end
		end
	endgenerate
	wire debug_req_valid;
	wire debug_req_ready;
	wire debug_resp_valid;
	wire debug_resp_ready;
	wire [255:0] jtag_hash;
	wire [255:0] ikey_hash;
	wire [255:0] okey_hash;
	wire jtag_unlock;
	wire [40:0] debug_req;
	wire [33:0] debug_resp;
	wire tck;
	wire tms;
	wire trst_n;
	wire tdi;
	wire tdo;
	wire tdo_oe;
	// dmi_jtag i_dmi_jtag(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.testmode_i(testmode_i),
	// 	.we_flag(we_flag_4),
	// 	.jtag_hash_i(jtag_hash),
	// 	.okey_hash_i(okey_hash),
	// 	.ikey_hash_i(ikey_hash),
	// 	.jtag_unlock_o(jtag_unlock),
	// 	.dmi_req_o(debug_req),
	// 	.dmi_req_valid_o(debug_req_valid),
	// 	.dmi_req_ready_i(debug_req_ready),
	// 	.dmi_resp_i(debug_resp),
	// 	.dmi_resp_ready_o(debug_resp_ready),
	// 	.dmi_resp_valid_i(debug_resp_valid),
	// 	.dmi_rst_no(),
	// 	.tck_i(tck),
	// 	.tms_i(tms),
	// 	.trst_ni(trst_n),
	// 	.td_i(tdi),
	// 	.td_o(tdo),
	// 	.tdo_oe_o(tdo_oe)
	// );
	assign tck = tck_i;
	assign tms = tms_i;
	assign trst_n = trst_ni;
	assign tdi = td_i;
	assign td_o = tdo;
	assign tdo_oe_o = tdo_oe;
	wire dm_slave_req;
	wire dm_slave_we;
	wire [63:0] dm_slave_addr;
	wire [7:0] dm_slave_be;
	wire [63:0] dm_slave_wdata;
	wire [63:0] dm_slave_rdata;
	wire dm_master_req;
	wire [63:0] dm_master_add;
	wire dm_master_we;
	wire [63:0] dm_master_wdata;
	wire [7:0] dm_master_be;
	wire dm_master_gnt;
	wire dm_master_r_valid;
	wire [63:0] dm_master_r_rdata;
	localparam [11:0] dm_DataAddr = 12'h380;
	localparam [3:0] dm_DataCount = 4'h2;
	localparam [31:0] ariane_pkg_DebugHartInfo = {16'h0021, dm_DataCount, dm_DataAddr};
	// dm_top #(
	// 	.NrHarts(NumHarts),
	// 	.BusWidth(AxiDataWidth),
	// 	.SelectableHarts({NumHarts {1'b1}})
	// ) i_dm_top(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.testmode_i(testmode_i),
	// 	.ndmreset_o(ndmreset_o),
	// 	.dmactive_o(dmactive_o),
	// 	.debug_req_o(debug_req_o),
	// 	.unavailable_i(unavailable_i),
	// 	.hartinfo_i({NumHarts {ariane_pkg_DebugHartInfo}}),
	// 	.slave_req_i(dm_slave_req),
	// 	.slave_we_i(dm_slave_we),
	// 	.slave_addr_i(dm_slave_addr),
	// 	.slave_be_i(dm_slave_be),
	// 	.slave_wdata_i(dm_slave_wdata),
	// 	.slave_rdata_o(dm_slave_rdata),
	// 	.master_req_o(dm_master_req),
	// 	.master_add_o(dm_master_add),
	// 	.master_we_o(dm_master_we),
	// 	.master_wdata_o(dm_master_wdata),
	// 	.master_be_o(dm_master_be),
	// 	.master_gnt_i(dm_master_gnt),
	// 	.master_r_valid_i(dm_master_r_valid),
	// 	.master_r_rdata_i(dm_master_r_rdata),
	// 	.dmi_rst_ni(rst_ni),
	// 	.dmi_req_valid_i(debug_req_valid),
	// 	.dmi_req_ready_o(debug_req_ready),
	// 	.dmi_req_i(debug_req),
	// 	.dmi_resp_valid_o(debug_resp_valid),
	// 	.dmi_resp_ready_i(debug_resp_ready),
	// 	.dmi_resp_o(debug_resp)
	// );
	// AXI_BUS #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth),
	// 	.AXI_USER_WIDTH(AxiUserWidth)
	// ) dm_master();
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_debug_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_debug_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_debug_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_debug_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_debug_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_debug_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_debug_noc3_ready_i),
	// 	.m_axi_awaddr(dm_master.aw_addr),
	// 	.m_axi_awvalid(dm_master.aw_valid),
	// 	.m_axi_awready(dm_master.aw_ready),
	// 	.m_axi_wdata(dm_master.w_data),
	// 	.m_axi_wstrb(dm_master.w_strb),
	// 	.m_axi_wvalid(dm_master.w_valid),
	// 	.m_axi_wready(dm_master.w_ready),
	// 	.m_axi_araddr(dm_master.ar_addr),
	// 	.m_axi_arvalid(dm_master.ar_valid),
	// 	.m_axi_arready(dm_master.ar_ready),
	// 	.m_axi_rdata(dm_master.r_data),
	// 	.m_axi_rresp(dm_master.r_resp),
	// 	.m_axi_rvalid(dm_master.r_valid),
	// 	.m_axi_rready(dm_master.r_ready),
	// 	.m_axi_bresp(dm_master.b_resp),
	// 	.m_axi_bvalid(dm_master.b_valid),
	// 	.m_axi_bready(dm_master.b_ready),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign dm_master_gnt = 1'sb0;
	assign dm_master_r_valid = 1'sb0;
	assign dm_master_r_rdata = 1'sb0;
	// assign dm_master.aw_id = 1'sb0;
	// assign dm_master.aw_len = 1'sb0;
	// assign dm_master.aw_size = 3'b011;
	// assign dm_master.aw_burst = 1'sb0;
	// assign dm_master.aw_lock = 1'sb0;
	// assign dm_master.aw_cache = 1'sb0;
	// assign dm_master.aw_prot = 1'sb0;
	// assign dm_master.aw_qos = 1'sb0;
	// assign dm_master.aw_region = 1'sb0;
	// assign dm_master.aw_atop = 1'sb0;
	// assign dm_master.w_last = 1'b1;
	// assign dm_master.ar_id = 1'sb0;
	// assign dm_master.ar_len = 1'sb0;
	// assign dm_master.ar_size = 3'b011;
	// assign dm_master.ar_burst = 1'sb0;
	// assign dm_master.ar_lock = 1'sb0;
	// assign dm_master.ar_cache = 1'sb0;
	// assign dm_master.ar_prot = 1'sb0;
	// assign dm_master.ar_qos = 1'sb0;
	// assign dm_master.ar_region = 1'sb0;
	wire rom_req_acct;
	wire rom_req;
	wire [63:0] rom_addr;
	wire [63:0] rom_rdata;
	wire [63:0] rom_rdata_bm;
	wire [63:0] rom_rdata_linux;
	assign rom_req = rom_req_acct && acc_ctrl_c[priv_lvl_i * NB_PERIPHERALS];
	// bootrom i_bootrom_bm(
	// 	.clk_i(clk_i),
	// 	.req_i(rom_req),
	// 	.addr_i(rom_addr),
	// 	.rdata_o(rom_rdata_bm)
	// );
	// bootrom_linux i_bootrom_linux(
	// 	.clk_i(clk_i),
	// 	.req_i(rom_req),
	// 	.addr_i(rom_addr),
	// 	.rdata_o(rom_rdata_linux)
	// );
	assign rom_rdata = (ariane_boot_sel_i ? rom_rdata_linux : rom_rdata_linux);
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_bootrom_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_bootrom_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_bootrom_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_bootrom_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_bootrom_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_bootrom_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_bootrom_noc3_ready_i),
	// 	.m_axi_awaddr(br_master.aw_addr),
	// 	.m_axi_awvalid(br_master.aw_valid),
	// 	.m_axi_awready(br_master.aw_ready),
	// 	.m_axi_wdata(br_master.w_data),
	// 	.m_axi_wstrb(br_master.w_strb),
	// 	.m_axi_wvalid(br_master.w_valid),
	// 	.m_axi_wready(br_master.w_ready),
	// 	.m_axi_araddr(br_master.ar_addr),
	// 	.m_axi_arvalid(br_master.ar_valid),
	// 	.m_axi_arready(br_master.ar_ready),
	// 	.m_axi_rdata(br_master.r_data),
	// 	.m_axi_rresp(br_master.r_resp),
	// 	.m_axi_rvalid(br_master.r_valid),
	// 	.m_axi_rready(br_master.r_ready),
	// 	.m_axi_bresp(br_master.b_resp),
	// 	.m_axi_bvalid(br_master.b_valid),
	// 	.m_axi_bready(br_master.b_ready),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	// assign br_master.aw_id = 1'sb0;
	// assign br_master.aw_len = 1'sb0;
	// assign br_master.aw_size = 3'b011;
	// assign br_master.aw_burst = 1'sb0;
	// assign br_master.aw_lock = 1'sb0;
	// assign br_master.aw_cache = 1'sb0;
	// assign br_master.aw_prot = 1'sb0;
	// assign br_master.aw_qos = 1'sb0;
	// assign br_master.aw_region = 1'sb0;
	// assign br_master.aw_atop = 1'sb0;
	// assign br_master.w_last = 1'b1;
	// assign br_master.ar_id = 1'sb0;
	// assign br_master.ar_len = 1'sb0;
	// assign br_master.ar_size = 3'b011;
	// assign br_master.ar_burst = 1'sb0;
	// assign br_master.ar_lock = 1'sb0;
	// assign br_master.ar_cache = 1'sb0;
	// assign br_master.ar_prot = 1'sb0;
	// assign br_master.ar_qos = 1'sb0;
	// assign br_master.ar_region = 1'sb0;
	localparam ariane_axi_AddrWidth = 64;
	localparam ariane_soc_IdWidth = 4;
	localparam ariane_axi_DataWidth = 64;
	localparam ariane_axi_StrbWidth = 8;
	wire [277:0] clint_axi_req;
	wire [81:0] clint_axi_resp;
	// clint #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth),
	// 	.NR_CORES(NumHarts)
	// ) i_clint(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.testmode_i(testmode_i),
	// 	.axi_req_i(clint_axi_req),
	// 	.axi_resp_o(clint_axi_resp),
	// 	.rtc_i(rtc_i),
	// 	.timer_irq_o(timer_irq_o),
	// 	.ipi_o(ipi_o)
	// );
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_clint_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_clint_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_clint_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_clint_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_clint_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_clint_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_clint_noc3_ready_i),
	// 	.m_axi_awaddr(clint_axi_req[273-:64]),
	// 	.m_axi_awvalid(clint_axi_req[174]),
	// 	.m_axi_awready(clint_axi_resp[81]),
	// 	.m_axi_wdata(clint_axi_req[173-:64]),
	// 	.m_axi_wstrb(clint_axi_req[109-:8]),
	// 	.m_axi_wvalid(clint_axi_req[100]),
	// 	.m_axi_wready(clint_axi_resp[79]),
	// 	.m_axi_araddr(clint_axi_req[94-:64]),
	// 	.m_axi_arvalid(clint_axi_req[1]),
	// 	.m_axi_arready(clint_axi_resp[80]),
	// 	.m_axi_rdata(clint_axi_resp[66-:64]),
	// 	.m_axi_rresp(clint_axi_resp[2-:2]),
	// 	.m_axi_rvalid(clint_axi_resp[71]),
	// 	.m_axi_rready(clint_axi_req[0]),
	// 	.m_axi_bresp(clint_axi_resp[73-:2]),
	// 	.m_axi_bvalid(clint_axi_resp[78]),
	// 	.m_axi_bready(clint_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign clint_axi_req[277-:4] = 1'sb0;
	assign clint_axi_req[209-:8] = 1'sb0;
	assign clint_axi_req[201-:3] = 3'b011;
	assign clint_axi_req[198-:2] = 1'sb0;
	assign clint_axi_req[196] = 1'sb0;
	assign clint_axi_req[195-:4] = 1'sb0;
	assign clint_axi_req[191-:3] = 1'sb0;
	assign clint_axi_req[188-:4] = 1'sb0;
	assign clint_axi_req[184-:4] = 1'sb0;
	assign clint_axi_req[180-:6] = 1'sb0;
	assign clint_axi_req[101] = 1'b1;
	assign clint_axi_req[98-:4] = 1'sb0;
	assign clint_axi_req[30-:8] = 1'sb0;
	assign clint_axi_req[22-:3] = 3'b011;
	assign clint_axi_req[19-:2] = 1'sb0;
	assign clint_axi_req[17] = 1'sb0;
	assign clint_axi_req[16-:4] = 1'sb0;
	assign clint_axi_req[12-:3] = 1'sb0;
	assign clint_axi_req[9-:4] = 1'sb0;
	assign clint_axi_req[5-:4] = 1'sb0;
	// AXI_BUS #(
	// 	.AXI_ID_WIDTH(AxiIdWidth),
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_USER_WIDTH(AxiUserWidth)
	// ) plic_master();
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(0),
	// 	.SWAP_ENDIANESS(SwapEndianess),
	// 	.ALIGN_RDATA(0)
	// ) i_plic_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_plic_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_plic_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_plic_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_plic_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_plic_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_plic_noc3_ready_i),
	// 	.m_axi_awaddr(plic_master.aw_addr),
	// 	.m_axi_awvalid(plic_master.aw_valid),
	// 	.m_axi_awready(plic_master.aw_ready),
	// 	.m_axi_wdata(plic_master.w_data),
	// 	.m_axi_wstrb(plic_master.w_strb),
	// 	.m_axi_wvalid(plic_master.w_valid),
	// 	.m_axi_wready(plic_master.w_ready),
	// 	.m_axi_araddr(plic_master.ar_addr),
	// 	.m_axi_arvalid(plic_master.ar_valid),
	// 	.m_axi_arready(plic_master.ar_ready),
	// 	.m_axi_rdata(plic_master.r_data),
	// 	.m_axi_rresp(plic_master.r_resp),
	// 	.m_axi_rvalid(plic_master.r_valid),
	// 	.m_axi_rready(plic_master.r_ready),
	// 	.m_axi_bresp(plic_master.b_resp),
	// 	.m_axi_bvalid(plic_master.b_valid),
	// 	.m_axi_bready(plic_master.b_ready),
	// 	.w_reqbuf_size(plic_master.aw_size),
	// 	.r_reqbuf_size(plic_master.ar_size)
	// );
	// assign plic_master.aw_id = 1'sb0;
	// assign plic_master.aw_len = 1'sb0;
	// assign plic_master.aw_burst = 1'sb0;
	// assign plic_master.aw_lock = 1'sb0;
	// assign plic_master.aw_cache = 1'sb0;
	// assign plic_master.aw_prot = 1'sb0;
	// assign plic_master.aw_qos = 1'sb0;
	// assign plic_master.aw_region = 1'sb0;
	// assign plic_master.aw_atop = 1'sb0;
	// assign plic_master.w_last = 1'b1;
	// assign plic_master.ar_id = 1'sb0;
	// assign plic_master.ar_len = 1'sb0;
	// assign plic_master.ar_burst = 1'sb0;
	// assign plic_master.ar_lock = 1'sb0;
	// assign plic_master.ar_cache = 1'sb0;
	// assign plic_master.ar_prot = 1'sb0;
	// assign plic_master.ar_qos = 1'sb0;
	// assign plic_master.ar_region = 1'sb0;
	wire [33:0] plic_resp;
	reg [69:0] plic_req;
	reg [2:0] state_d;
	reg [2:0] state_q;
	wire [31:0] rword_d;
	reg [31:0] rword_q;
	assign rword_d = (plic_req[0] && !plic_req[37] ? plic_resp[33-:32] : rword_q);
	// assign plic_master.r_data = {plic_resp[33-:32], rword_q};
	always @(*) begin
		`assert(1==2)
	end
	always @(posedge clk_i or negedge rst_ni) begin : p_plic_regs
		// `assert(1==2)
		if (!rst_ni) begin
			state_q <= 3'd0;
			rword_q <= 1'sb0;
		end
		else begin
			state_q <= state_d;
			rword_q <= rword_d;
		end
	end
	always @(*) begin : p_plic_if
		reg [31:0] waddr;
		reg [31:0] raddr;
		if (_sv2v_0)
			;
		// waddr = (plic_master.aw_addr[31:0] - (PlicBase)) + 32'h0c000000;
		// raddr = (plic_master.ar_addr[31:0] - (PlicBase)) + 32'h0c000000;
		// plic_master.aw_ready = plic_resp[0];
		// plic_master.w_ready = plic_resp[0];
		// plic_master.ar_ready = plic_resp[0];
		// plic_master.r_valid = 1'b0;
		// plic_master.r_resp = 1'sb0;
		// plic_master.b_valid = 1'b0;
		// plic_master.b_resp = 1'sb0;
		// plic_req[0] = 1'b0;
		// plic_req[4-:4] = 1'sb0;
		// plic_req[37] = 1'b0;
		// plic_req[36-:32] = plic_master.w_data[31:0];
		// plic_req[69-:32] = waddr;
		state_d = state_q;
		// (* full_case, parallel_case *)
		case (state_q)
			3'd0:
			  //if ((plic_master.w_valid && plic_master.aw_valid) && plic_resp[0]) begin
				if (plic_resp[0]) begin
					plic_req[0] = 1'b1;
					// plic_req[37] = plic_master.w_strb[3:0];
					plic_req[4-:4] = 1'sb1;
					// if (plic_master.aw_size == 3'b011)
					// 	state_d = 3'd1;
					// else
					// 	state_d = 3'd3;
				end
			//   else if (plic_master.ar_valid && plic_resp[0]) begin
				else if (plic_resp[0]) begin
					plic_req[0] = 1'b1;
					plic_req[69-:32] = raddr;
					// if (plic_master.ar_size == 3'b011)
					// 	state_d = 3'd2;
					// else
					// 	state_d = 3'd4;
				end
			3'd1: begin
				// plic_master.aw_ready = 1'b0;
				// plic_master.w_ready = 1'b0;
				// plic_master.ar_ready = 1'b0;
				plic_req[69-:32] = waddr + 32'h00000004;
				// plic_req[36-:32] = plic_master.w_data[63:32];
				if (plic_resp[0]) begin
				// if (plic_resp[0] && plic_master.b_ready) begin
					plic_req[0] = 1'b1;
					plic_req[37] = 1'b1;
					plic_req[4-:4] = 1'sb1;
					// plic_master.b_valid = 1'b1;
					state_d = 3'd0;
				end
			end
			3'd2: begin
				// plic_master.aw_ready = 1'b0;
				// plic_master.w_ready = 1'b0;
				// plic_master.ar_ready = 1'b0;
				plic_req[69-:32] = raddr + 32'h00000004;
				// if (plic_resp[0] && plic_master.r_ready) begin
				if (plic_resp[0]) begin
					plic_req[0] = 1'b1;
					// plic_master.r_valid = 1'b1;
					state_d = 3'd0;
				end
			end
			3'd3: begin
				// plic_master.aw_ready = 1'b0;
				// plic_master.w_ready = 1'b0;
				// plic_master.ar_ready = 1'b0;
				// if (plic_master.b_ready) begin
				// 	plic_master.b_valid = 1'b1;
				// 	state_d = 3'd0;
				// end
			end
			3'd4: begin
				// plic_master.aw_ready = 1'b0;
				// plic_master.w_ready = 1'b0;
				// plic_master.ar_ready = 1'b0;
				// if (plic_master.r_ready) begin
				// 	plic_master.r_valid = 1'b1;
				// 	state_d = 3'd0;
				// end
			end
			default: state_d = 3'd0;
		endcase
	end
	// plic_top #(
	// 	.N_SOURCE(NumSources),
	// 	.N_TARGET(2 * NumHarts),
	// 	.MAX_PRIO(PlicMaxPriority)
	// ) i_plic(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.req_i(plic_req),
	// 	.resp_o(plic_resp),
	// 	.le_i(irq_le_i),
	// 	.irq_sources_i(irq_sources_i),
	// 	.eip_targets_o(irq_o)
	// );
	wire rst_1;
	wire rst_2;
	wire rst_3;
	wire rst_4;
	wire rst_5;
	wire rst_6;
	wire rst_7;
	wire rst_8;
	wire rst_9;
	wire rst_10;
	wire rst_11;
	wire rst_13;
	wire [277:0] rst_axi_req;
	wire [81:0] rst_axi_resp;
	// rst_wrapper #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth)
	// ) i_rst_wrapper(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.reglk_ctrl_i(reglk_ctrl[103:96]),
	// 	.acct_ctrl_i(acc_ctrl_c[(priv_lvl_i * NB_PERIPHERALS) + 12]),
	// 	.debug_mode_i(debug_mode_i),
	// 	.axi_req_i(rst_axi_req),
	// 	.axi_resp_o(rst_axi_resp),
	// 	.rst_1(rst_1),
	// 	.rst_2(rst_2),
	// 	.rst_3(rst_3),
	// 	.rst_4(rst_4),
	// 	.rst_5(rst_5),
	// 	.rst_6(rst_6),
	// 	.rst_7(rst_7),
	// 	.rst_8(rst_8),
	// 	.rst_9(rst_9),
	// 	.rst_10(rst_10),
	// 	.rst_11(rst_11),
	// 	.rst_13(rst_13)
	// );
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_rst_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_rst_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_rst_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_rst_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_rst_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_rst_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_rst_noc3_ready_i),
	// 	.m_axi_awaddr(rst_axi_req[273-:64]),
	// 	.m_axi_awvalid(rst_axi_req[174]),
	// 	.m_axi_awready(rst_axi_resp[81]),
	// 	.m_axi_wdata(rst_axi_req[173-:64]),
	// 	.m_axi_wstrb(rst_axi_req[109-:8]),
	// 	.m_axi_wvalid(rst_axi_req[100]),
	// 	.m_axi_wready(rst_axi_resp[79]),
	// 	.m_axi_araddr(rst_axi_req[94-:64]),
	// 	.m_axi_arvalid(rst_axi_req[1]),
	// 	.m_axi_arready(rst_axi_resp[80]),
	// 	.m_axi_rdata(rst_axi_resp[66-:64]),
	// 	.m_axi_rresp(rst_axi_resp[2-:2]),
	// 	.m_axi_rvalid(rst_axi_resp[71]),
	// 	.m_axi_rready(rst_axi_req[0]),
	// 	.m_axi_bresp(rst_axi_resp[73-:2]),
	// 	.m_axi_bvalid(rst_axi_resp[78]),
	// 	.m_axi_bready(rst_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign rst_axi_req[277-:4] = 1'sb0;
	assign rst_axi_req[209-:8] = 1'sb0;
	assign rst_axi_req[201-:3] = 3'b011;
	assign rst_axi_req[198-:2] = 1'sb0;
	assign rst_axi_req[196] = 1'sb0;
	assign rst_axi_req[195-:4] = 1'sb0;
	assign rst_axi_req[191-:3] = 1'sb0;
	assign rst_axi_req[188-:4] = 1'sb0;
	assign rst_axi_req[184-:4] = 1'sb0;
	assign rst_axi_req[180-:6] = 1'sb0;
	assign rst_axi_req[101] = 1'b1;
	assign rst_axi_req[98-:4] = 1'sb0;
	assign rst_axi_req[30-:8] = 1'sb0;
	assign rst_axi_req[22-:3] = 3'b011;
	assign rst_axi_req[19-:2] = 1'sb0;
	assign rst_axi_req[17] = 1'sb0;
	assign rst_axi_req[16-:4] = 1'sb0;
	assign rst_axi_req[12-:3] = 1'sb0;
	assign rst_axi_req[9-:4] = 1'sb0;
	assign rst_axi_req[5-:4] = 1'sb0;
	wire [277:0] rsa_axi_req;
	wire [81:0] rsa_axi_resp;
	// rsa_wrapper #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth)
	// ) i_rsa_wrapper(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.reglk_ctrl_i(reglk_ctrl[111:104]),
	// 	.acct_ctrl_i(acc_ctrl_c[(priv_lvl_i * NB_PERIPHERALS) + 13]),
	// 	.debug_mode_i(debug_mode_i),
	// 	.axi_req_i(rsa_axi_req),
	// 	.axi_resp_o(rsa_axi_resp),
	// 	.rst_13(rst_13)
	// );
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_rsa_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_rsa_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_rsa_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_rsa_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_rsa_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_rsa_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_rsa_noc3_ready_i),
	// 	.m_axi_awaddr(rsa_axi_req[273-:64]),
	// 	.m_axi_awvalid(rsa_axi_req[174]),
	// 	.m_axi_awready(rsa_axi_resp[81]),
	// 	.m_axi_wdata(rsa_axi_req[173-:64]),
	// 	.m_axi_wstrb(rsa_axi_req[109-:8]),
	// 	.m_axi_wvalid(rsa_axi_req[100]),
	// 	.m_axi_wready(rsa_axi_resp[79]),
	// 	.m_axi_araddr(rsa_axi_req[94-:64]),
	// 	.m_axi_arvalid(rsa_axi_req[1]),
	// 	.m_axi_arready(rsa_axi_resp[80]),
	// 	.m_axi_rdata(rsa_axi_resp[66-:64]),
	// 	.m_axi_rresp(rsa_axi_resp[2-:2]),
	// 	.m_axi_rvalid(rsa_axi_resp[71]),
	// 	.m_axi_rready(rsa_axi_req[0]),
	// 	.m_axi_bresp(rsa_axi_resp[73-:2]),
	// 	.m_axi_bvalid(rsa_axi_resp[78]),
	// 	.m_axi_bready(rsa_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign rsa_axi_req[277-:4] = 1'sb0;
	assign rsa_axi_req[209-:8] = 1'sb0;
	assign rsa_axi_req[201-:3] = 3'b011;
	assign rsa_axi_req[198-:2] = 1'sb0;
	assign rsa_axi_req[196] = 1'sb0;
	assign rsa_axi_req[195-:4] = 1'sb0;
	assign rsa_axi_req[191-:3] = 1'sb0;
	assign rsa_axi_req[188-:4] = 1'sb0;
	assign rsa_axi_req[184-:4] = 1'sb0;
	assign rsa_axi_req[180-:6] = 1'sb0;
	assign rsa_axi_req[101] = 1'b1;
	assign rsa_axi_req[98-:4] = 1'sb0;
	assign rsa_axi_req[30-:8] = 1'sb0;
	assign rsa_axi_req[22-:3] = 3'b011;
	assign rsa_axi_req[19-:2] = 1'sb0;
	assign rsa_axi_req[17] = 1'sb0;
	assign rsa_axi_req[16-:4] = 1'sb0;
	assign rsa_axi_req[12-:3] = 1'sb0;
	assign rsa_axi_req[9-:4] = 1'sb0;
	assign rsa_axi_req[5-:4] = 1'sb0;
	wire [277:0] rng_axi_req;
	wire [81:0] rng_axi_resp;
	// rng_wrapper #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth)
	// ) i_rng_wrapper(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.reglk_ctrl_i(reglk_ctrl[87:80]),
	// 	.acct_ctrl_i(acc_ctrl_c[(priv_lvl_i * NB_PERIPHERALS) + 10]),
	// 	.debug_mode_i(debug_mode_i),
	// 	.axi_req_i(rng_axi_req),
	// 	.axi_resp_o(rng_axi_resp),
	// 	.rst_10(rst_10)
	// );
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_rng_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_rng_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_rng_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_rng_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_rng_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_rng_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_rng_noc3_ready_i),
	// 	.m_axi_awaddr(rng_axi_req[273-:64]),
	// 	.m_axi_awvalid(rng_axi_req[174]),
	// 	.m_axi_awready(rng_axi_resp[81]),
	// 	.m_axi_wdata(rng_axi_req[173-:64]),
	// 	.m_axi_wstrb(rng_axi_req[109-:8]),
	// 	.m_axi_wvalid(rng_axi_req[100]),
	// 	.m_axi_wready(rng_axi_resp[79]),
	// 	.m_axi_araddr(rng_axi_req[94-:64]),
	// 	.m_axi_arvalid(rng_axi_req[1]),
	// 	.m_axi_arready(rng_axi_resp[80]),
	// 	.m_axi_rdata(rng_axi_resp[66-:64]),
	// 	.m_axi_rresp(rng_axi_resp[2-:2]),
	// 	.m_axi_rvalid(rng_axi_resp[71]),
	// 	.m_axi_rready(rng_axi_req[0]),
	// 	.m_axi_bresp(rng_axi_resp[73-:2]),
	// 	.m_axi_bvalid(rng_axi_resp[78]),
	// 	.m_axi_bready(rng_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign rng_axi_req[277-:4] = 1'sb0;
	assign rng_axi_req[209-:8] = 1'sb0;
	assign rng_axi_req[201-:3] = 3'b011;
	assign rng_axi_req[198-:2] = 1'sb0;
	assign rng_axi_req[196] = 1'sb0;
	assign rng_axi_req[195-:4] = 1'sb0;
	assign rng_axi_req[191-:3] = 1'sb0;
	assign rng_axi_req[188-:4] = 1'sb0;
	assign rng_axi_req[184-:4] = 1'sb0;
	assign rng_axi_req[180-:6] = 1'sb0;
	assign rng_axi_req[101] = 1'b1;
	assign rng_axi_req[98-:4] = 1'sb0;
	assign rng_axi_req[30-:8] = 1'sb0;
	assign rng_axi_req[22-:3] = 3'b011;
	assign rng_axi_req[19-:2] = 1'sb0;
	assign rng_axi_req[17] = 1'sb0;
	assign rng_axi_req[16-:4] = 1'sb0;
	assign rng_axi_req[12-:3] = 1'sb0;
	assign rng_axi_req[9-:4] = 1'sb0;
	assign rng_axi_req[5-:4] = 1'sb0;
	wire [277:0] aes0_axi_req;
	wire [81:0] aes0_axi_resp;
	// aes0_wrapper #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth)
	// ) i_aes0_wrapper(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.reglk_ctrl_i(reglk_ctrl[15:8] | we_flag_1),
	// 	.acct_ctrl_i(acc_ctrl_c[(priv_lvl_i * NB_PERIPHERALS) + 1]),
	// 	.debug_mode_i(debug_mode_i),
	// 	.axi_req_i(aes0_axi_req),
	// 	.axi_resp_o(aes0_axi_resp),
	// 	.rst_1(rst_1)
	// );
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_aes0_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_aes0_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_aes0_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_aes0_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_aes0_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_aes0_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_aes0_noc3_ready_i),
	// 	.m_axi_awaddr(aes0_axi_req[273-:64]),
	// 	.m_axi_awvalid(aes0_axi_req[174]),
	// 	.m_axi_awready(aes0_axi_resp[81]),
	// 	.m_axi_wdata(aes0_axi_req[173-:64]),
	// 	.m_axi_wstrb(aes0_axi_req[109-:8]),
	// 	.m_axi_wvalid(aes0_axi_req[100]),
	// 	.m_axi_wready(aes0_axi_resp[79]),
	// 	.m_axi_araddr(aes0_axi_req[94-:64]),
	// 	.m_axi_arvalid(aes0_axi_req[1]),
	// 	.m_axi_arready(aes0_axi_resp[80]),
	// 	.m_axi_rdata(aes0_axi_resp[66-:64]),
	// 	.m_axi_rresp(aes0_axi_resp[2-:2]),
	// 	.m_axi_rvalid(aes0_axi_resp[71]),
	// 	.m_axi_rready(aes0_axi_req[0]),
	// 	.m_axi_bresp(aes0_axi_resp[73-:2]),
	// 	.m_axi_bvalid(aes0_axi_resp[78]),
	// 	.m_axi_bready(aes0_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign aes0_axi_req[277-:4] = 1'sb0;
	assign aes0_axi_req[209-:8] = 1'sb0;
	assign aes0_axi_req[201-:3] = 3'b011;
	assign aes0_axi_req[198-:2] = 1'sb0;
	assign aes0_axi_req[196] = 1'sb0;
	assign aes0_axi_req[195-:4] = 1'sb0;
	assign aes0_axi_req[191-:3] = 1'sb0;
	assign aes0_axi_req[188-:4] = 1'sb0;
	assign aes0_axi_req[184-:4] = 1'sb0;
	assign aes0_axi_req[180-:6] = 1'sb0;
	assign aes0_axi_req[101] = 1'b1;
	assign aes0_axi_req[98-:4] = 1'sb0;
	assign aes0_axi_req[30-:8] = 1'sb0;
	assign aes0_axi_req[22-:3] = 3'b011;
	assign aes0_axi_req[19-:2] = 1'sb0;
	assign aes0_axi_req[17] = 1'sb0;
	assign aes0_axi_req[16-:4] = 1'sb0;
	assign aes0_axi_req[12-:3] = 1'sb0;
	assign aes0_axi_req[9-:4] = 1'sb0;
	assign aes0_axi_req[5-:4] = 1'sb0;
	wire [277:0] aes1_axi_req;
	wire [81:0] aes1_axi_resp;
	// aes1_wrapper #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth)
	// ) i_aes1_wrapper(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.reglk_ctrl_i(reglk_ctrl[23:16]),
	// 	.acct_ctrl_i(acc_ctrl_c[(priv_lvl_i * NB_PERIPHERALS) + 2]),
	// 	.debug_mode_i(debug_mode_i),
	// 	.axi_req_i(aes1_axi_req),
	// 	.axi_resp_o(aes1_axi_resp),
	// 	.rst_2(rst_2)
	// );
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_aes1_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_aes1_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_aes1_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_aes1_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_aes1_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_aes1_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_aes1_noc3_ready_i),
	// 	.m_axi_awaddr(aes1_axi_req[273-:64]),
	// 	.m_axi_awvalid(aes1_axi_req[174]),
	// 	.m_axi_awready(aes1_axi_resp[81]),
	// 	.m_axi_wdata(aes1_axi_req[173-:64]),
	// 	.m_axi_wstrb(aes1_axi_req[109-:8]),
	// 	.m_axi_wvalid(aes1_axi_req[100]),
	// 	.m_axi_wready(aes1_axi_resp[79]),
	// 	.m_axi_araddr(aes1_axi_req[94-:64]),
	// 	.m_axi_arvalid(aes1_axi_req[1]),
	// 	.m_axi_arready(aes1_axi_resp[80]),
	// 	.m_axi_rdata(aes1_axi_resp[66-:64]),
	// 	.m_axi_rresp(aes1_axi_resp[2-:2]),
	// 	.m_axi_rvalid(aes1_axi_resp[71]),
	// 	.m_axi_rready(aes1_axi_req[0]),
	// 	.m_axi_bresp(aes1_axi_resp[73-:2]),
	// 	.m_axi_bvalid(aes1_axi_resp[78]),
	// 	.m_axi_bready(aes1_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign aes1_axi_req[277-:4] = 1'sb0;
	assign aes1_axi_req[209-:8] = 1'sb0;
	assign aes1_axi_req[201-:3] = 3'b011;
	assign aes1_axi_req[198-:2] = 1'sb0;
	assign aes1_axi_req[196] = 1'sb0;
	assign aes1_axi_req[195-:4] = 1'sb0;
	assign aes1_axi_req[191-:3] = 1'sb0;
	assign aes1_axi_req[188-:4] = 1'sb0;
	assign aes1_axi_req[184-:4] = 1'sb0;
	assign aes1_axi_req[180-:6] = 1'sb0;
	assign aes1_axi_req[101] = 1'b1;
	assign aes1_axi_req[98-:4] = 1'sb0;
	assign aes1_axi_req[30-:8] = 1'sb0;
	assign aes1_axi_req[22-:3] = 3'b011;
	assign aes1_axi_req[19-:2] = 1'sb0;
	assign aes1_axi_req[17] = 1'sb0;
	assign aes1_axi_req[16-:4] = 1'sb0;
	assign aes1_axi_req[12-:3] = 1'sb0;
	assign aes1_axi_req[9-:4] = 1'sb0;
	assign aes1_axi_req[5-:4] = 1'sb0;
	wire [277:0] aes2_axi_req;
	wire [81:0] aes2_axi_resp;
	// aes2_wrapper #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth)
	// ) i_aes2_wrapper(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.reglk_ctrl_i(reglk_ctrl[95:88]),
	// 	.acct_ctrl_i(acc_ctrl_c[(priv_lvl_i * NB_PERIPHERALS) + 11]),
	// 	.debug_mode_i(debug_mode_i),
	// 	.axi_req_i(aes2_axi_req),
	// 	.axi_resp_o(aes2_axi_resp),
	// 	.rst_11(rst_11)
	// );
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_aes2_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_aes2_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_aes2_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_aes2_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_aes2_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_aes2_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_aes2_noc3_ready_i),
	// 	.m_axi_awaddr(aes2_axi_req[273-:64]),
	// 	.m_axi_awvalid(aes2_axi_req[174]),
	// 	.m_axi_awready(aes2_axi_resp[81]),
	// 	.m_axi_wdata(aes2_axi_req[173-:64]),
	// 	.m_axi_wstrb(aes2_axi_req[109-:8]),
	// 	.m_axi_wvalid(aes2_axi_req[100]),
	// 	.m_axi_wready(aes2_axi_resp[79]),
	// 	.m_axi_araddr(aes2_axi_req[94-:64]),
	// 	.m_axi_arvalid(aes2_axi_req[1]),
	// 	.m_axi_arready(aes2_axi_resp[80]),
	// 	.m_axi_rdata(aes2_axi_resp[66-:64]),
	// 	.m_axi_rresp(aes2_axi_resp[2-:2]),
	// 	.m_axi_rvalid(aes2_axi_resp[71]),
	// 	.m_axi_rready(aes2_axi_req[0]),
	// 	.m_axi_bresp(aes2_axi_resp[73-:2]),
	// 	.m_axi_bvalid(aes2_axi_resp[78]),
	// 	.m_axi_bready(aes2_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign aes2_axi_req[277-:4] = 1'sb0;
	assign aes2_axi_req[209-:8] = 1'sb0;
	assign aes2_axi_req[201-:3] = 3'b011;
	assign aes2_axi_req[198-:2] = 1'sb0;
	assign aes2_axi_req[196] = 1'sb0;
	assign aes2_axi_req[195-:4] = 1'sb0;
	assign aes2_axi_req[191-:3] = 1'sb0;
	assign aes2_axi_req[188-:4] = 1'sb0;
	assign aes2_axi_req[184-:4] = 1'sb0;
	assign aes2_axi_req[180-:6] = 1'sb0;
	assign aes2_axi_req[101] = 1'b1;
	assign aes2_axi_req[98-:4] = 1'sb0;
	assign aes2_axi_req[30-:8] = 1'sb0;
	assign aes2_axi_req[22-:3] = 3'b011;
	assign aes2_axi_req[19-:2] = 1'sb0;
	assign aes2_axi_req[17] = 1'sb0;
	assign aes2_axi_req[16-:4] = 1'sb0;
	assign aes2_axi_req[12-:3] = 1'sb0;
	assign aes2_axi_req[9-:4] = 1'sb0;
	assign aes2_axi_req[5-:4] = 1'sb0;
	wire [277:0] sha256_axi_req;
	wire [81:0] sha256_axi_resp;
	// sha256_wrapper #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth)
	// ) i_sha256_wrapper(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.reglk_ctrl_i(reglk_ctrl[31:24]),
	// 	.acct_ctrl_i(acc_ctrl_c[(priv_lvl_i * NB_PERIPHERALS) + 3]),
	// 	.axi_req_i(sha256_axi_req),
	// 	.axi_resp_o(sha256_axi_resp),
	// 	.rst_3(rst_3)
	// );
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_sha256_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_sha256_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_sha256_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_sha256_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_sha256_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_sha256_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_sha256_noc3_ready_i),
	// 	.m_axi_awaddr(sha256_axi_req[273-:64]),
	// 	.m_axi_awvalid(sha256_axi_req[174]),
	// 	.m_axi_awready(sha256_axi_resp[81]),
	// 	.m_axi_wdata(sha256_axi_req[173-:64]),
	// 	.m_axi_wstrb(sha256_axi_req[109-:8]),
	// 	.m_axi_wvalid(sha256_axi_req[100]),
	// 	.m_axi_wready(sha256_axi_resp[79]),
	// 	.m_axi_araddr(sha256_axi_req[94-:64]),
	// 	.m_axi_arvalid(sha256_axi_req[1]),
	// 	.m_axi_arready(sha256_axi_resp[80]),
	// 	.m_axi_rdata(sha256_axi_resp[66-:64]),
	// 	.m_axi_rresp(sha256_axi_resp[2-:2]),
	// 	.m_axi_rvalid(sha256_axi_resp[71]),
	// 	.m_axi_rready(sha256_axi_req[0]),
	// 	.m_axi_bresp(sha256_axi_resp[73-:2]),
	// 	.m_axi_bvalid(sha256_axi_resp[78]),
	// 	.m_axi_bready(sha256_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign sha256_axi_req[277-:4] = 1'sb0;
	assign sha256_axi_req[209-:8] = 1'sb0;
	assign sha256_axi_req[201-:3] = 3'b011;
	assign sha256_axi_req[198-:2] = 1'sb0;
	assign sha256_axi_req[196] = 1'sb0;
	assign sha256_axi_req[195-:4] = 1'sb0;
	assign sha256_axi_req[191-:3] = 1'sb0;
	assign sha256_axi_req[188-:4] = 1'sb0;
	assign sha256_axi_req[184-:4] = 1'sb0;
	assign sha256_axi_req[180-:6] = 1'sb0;
	assign sha256_axi_req[101] = 1'b1;
	assign sha256_axi_req[98-:4] = 1'sb0;
	assign sha256_axi_req[30-:8] = 1'sb0;
	assign sha256_axi_req[22-:3] = 3'b011;
	assign sha256_axi_req[19-:2] = 1'sb0;
	assign sha256_axi_req[17] = 1'sb0;
	assign sha256_axi_req[16-:4] = 1'sb0;
	assign sha256_axi_req[12-:3] = 1'sb0;
	assign sha256_axi_req[9-:4] = 1'sb0;
	assign sha256_axi_req[5-:4] = 1'sb0;
	wire [277:0] hmac_axi_req;
	wire [81:0] hmac_axi_resp;
	// hmac_wrapper #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth)
	// ) i_hmac_wrapper(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.reglk_ctrl_i(reglk_ctrl[39:32]),
	// 	.acct_ctrl_i(acc_ctrl_c[(priv_lvl_i * NB_PERIPHERALS) + 4]),
	// 	.debug_mode_i(debug_mode_i),
	// 	.axi_req_i(hmac_axi_req),
	// 	.axi_resp_o(hmac_axi_resp),
	// 	.rst_4(rst_4)
	// );
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_hmac_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_hmac_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_hmac_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_hmac_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_hmac_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_hmac_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_hmac_noc3_ready_i),
	// 	.m_axi_awaddr(hmac_axi_req[273-:64]),
	// 	.m_axi_awvalid(hmac_axi_req[174]),
	// 	.m_axi_awready(hmac_axi_resp[81]),
	// 	.m_axi_wdata(hmac_axi_req[173-:64]),
	// 	.m_axi_wstrb(hmac_axi_req[109-:8]),
	// 	.m_axi_wvalid(hmac_axi_req[100]),
	// 	.m_axi_wready(hmac_axi_resp[79]),
	// 	.m_axi_araddr(hmac_axi_req[94-:64]),
	// 	.m_axi_arvalid(hmac_axi_req[1]),
	// 	.m_axi_arready(hmac_axi_resp[80]),
	// 	.m_axi_rdata(hmac_axi_resp[66-:64]),
	// 	.m_axi_rresp(hmac_axi_resp[2-:2]),
	// 	.m_axi_rvalid(hmac_axi_resp[71]),
	// 	.m_axi_rready(hmac_axi_req[0]),
	// 	.m_axi_bresp(hmac_axi_resp[73-:2]),
	// 	.m_axi_bvalid(hmac_axi_resp[78]),
	// 	.m_axi_bready(hmac_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign hmac_axi_req[277-:4] = 1'sb0;
	assign hmac_axi_req[209-:8] = 1'sb0;
	assign hmac_axi_req[201-:3] = 3'b011;
	assign hmac_axi_req[198-:2] = 1'sb0;
	assign hmac_axi_req[196] = 1'sb0;
	assign hmac_axi_req[195-:4] = 1'sb0;
	assign hmac_axi_req[191-:3] = 1'sb0;
	assign hmac_axi_req[188-:4] = 1'sb0;
	assign hmac_axi_req[184-:4] = 1'sb0;
	assign hmac_axi_req[180-:6] = 1'sb0;
	assign hmac_axi_req[101] = 1'b1;
	assign hmac_axi_req[98-:4] = 1'sb0;
	assign hmac_axi_req[30-:8] = 1'sb0;
	assign hmac_axi_req[22-:3] = 3'b011;
	assign hmac_axi_req[19-:2] = 1'sb0;
	assign hmac_axi_req[17] = 1'sb0;
	assign hmac_axi_req[16-:4] = 1'sb0;
	assign hmac_axi_req[12-:3] = 1'sb0;
	assign hmac_axi_req[9-:4] = 1'sb0;
	assign hmac_axi_req[5-:4] = 1'sb0;
	wire [277:0] pkt_axi_req;
	wire [81:0] pkt_axi_resp;
	wire fuse_req;
	wire [31:0] fuse_addr;
	wire [31:0] fuse_rdata;
	// pkt_wrapper #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth),
	// 	.FUSE_MEM_SIZE(FUSE_MEM_SIZE)
	// ) i_pkt_wrapper(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.reglk_ctrl_i(reglk_ctrl[47:40]),
	// 	.acct_ctrl_i(acc_ctrl_c[(priv_lvl_i * NB_PERIPHERALS) + 5]),
	// 	.fuse_req_o(fuse_req),
	// 	.fuse_addr_o(fuse_addr),
	// 	.fuse_rdata_i(fuse_rdata),
	// 	.axi_req_i(pkt_axi_req),
	// 	.axi_resp_o(pkt_axi_resp),
	// 	.rst_5(rst_5)
	// );
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_pkt_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_pkt_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_pkt_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_pkt_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_pkt_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_pkt_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_pkt_noc3_ready_i),
	// 	.m_axi_awaddr(pkt_axi_req[273-:64]),
	// 	.m_axi_awvalid(pkt_axi_req[174]),
	// 	.m_axi_awready(pkt_axi_resp[81]),
	// 	.m_axi_wdata(pkt_axi_req[173-:64]),
	// 	.m_axi_wstrb(pkt_axi_req[109-:8]),
	// 	.m_axi_wvalid(pkt_axi_req[100]),
	// 	.m_axi_wready(pkt_axi_resp[79]),
	// 	.m_axi_araddr(pkt_axi_req[94-:64]),
	// 	.m_axi_arvalid(pkt_axi_req[1]),
	// 	.m_axi_arready(pkt_axi_resp[80]),
	// 	.m_axi_rdata(pkt_axi_resp[66-:64]),
	// 	.m_axi_rresp(pkt_axi_resp[2-:2]),
	// 	.m_axi_rvalid(pkt_axi_resp[71]),
	// 	.m_axi_rready(pkt_axi_req[0]),
	// 	.m_axi_bresp(pkt_axi_resp[73-:2]),
	// 	.m_axi_bvalid(pkt_axi_resp[78]),
	// 	.m_axi_bready(pkt_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign pkt_axi_req[277-:4] = 1'sb0;
	assign pkt_axi_req[209-:8] = 1'sb0;
	assign pkt_axi_req[201-:3] = 3'b011;
	assign pkt_axi_req[198-:2] = 1'sb0;
	assign pkt_axi_req[196] = 1'sb0;
	assign pkt_axi_req[195-:4] = 1'sb0;
	assign pkt_axi_req[191-:3] = 1'sb0;
	assign pkt_axi_req[188-:4] = 1'sb0;
	assign pkt_axi_req[184-:4] = 1'sb0;
	assign pkt_axi_req[180-:6] = 1'sb0;
	assign pkt_axi_req[101] = 1'b1;
	assign pkt_axi_req[98-:4] = 1'sb0;
	assign pkt_axi_req[30-:8] = 1'sb0;
	assign pkt_axi_req[22-:3] = 3'b011;
	assign pkt_axi_req[19-:2] = 1'sb0;
	assign pkt_axi_req[17] = 1'sb0;
	assign pkt_axi_req[16-:4] = 1'sb0;
	assign pkt_axi_req[12-:3] = 1'sb0;
	assign pkt_axi_req[9-:4] = 1'sb0;
	assign pkt_axi_req[5-:4] = 1'sb0;
	// fuse_mem #(.MEM_SIZE(FUSE_MEM_SIZE)) i_fuse_mem(
	// 	.clk_i(clk_i),
	// 	.jtag_hash_o(jtag_hash),
	// 	.okey_hash_o(okey_hash),
	// 	.ikey_hash_o(ikey_hash),
	// 	.req_i(fuse_req),
	// 	.addr_i(fuse_addr),
	// 	.rdata_o(fuse_rdata)
	// );
	wire [277:0] acct_axi_req;
	wire [81:0] acct_axi_resp;
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_acct_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_acct_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_acct_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_acct_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_acct_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_acct_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_acct_noc3_ready_i),
	// 	.m_axi_awaddr(acct_axi_req[273-:64]),
	// 	.m_axi_awvalid(acct_axi_req[174]),
	// 	.m_axi_awready(acct_axi_resp[81]),
	// 	.m_axi_wdata(acct_axi_req[173-:64]),
	// 	.m_axi_wstrb(acct_axi_req[109-:8]),
	// 	.m_axi_wvalid(acct_axi_req[100]),
	// 	.m_axi_wready(acct_axi_resp[79]),
	// 	.m_axi_araddr(acct_axi_req[94-:64]),
	// 	.m_axi_arvalid(acct_axi_req[1]),
	// 	.m_axi_arready(acct_axi_resp[80]),
	// 	.m_axi_rdata(acct_axi_resp[66-:64]),
	// 	.m_axi_rresp(acct_axi_resp[2-:2]),
	// 	.m_axi_rvalid(acct_axi_resp[71]),
	// 	.m_axi_rready(acct_axi_req[0]),
	// 	.m_axi_bresp(acct_axi_resp[73-:2]),
	// 	.m_axi_bvalid(acct_axi_resp[78]),
	// 	.m_axi_bready(acct_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign acct_axi_req[277-:4] = 1'sb0;
	assign acct_axi_req[209-:8] = 1'sb0;
	assign acct_axi_req[201-:3] = 3'b011;
	assign acct_axi_req[198-:2] = 1'sb0;
	assign acct_axi_req[196] = 1'sb0;
	assign acct_axi_req[195-:4] = 1'sb0;
	assign acct_axi_req[191-:3] = 1'sb0;
	assign acct_axi_req[188-:4] = 1'sb0;
	assign acct_axi_req[184-:4] = 1'sb0;
	assign acct_axi_req[180-:6] = 1'sb0;
	assign acct_axi_req[101] = 1'b1;
	assign acct_axi_req[98-:4] = 1'sb0;
	assign acct_axi_req[30-:8] = 1'sb0;
	assign acct_axi_req[22-:3] = 3'b011;
	assign acct_axi_req[19-:2] = 1'sb0;
	assign acct_axi_req[17] = 1'sb0;
	assign acct_axi_req[16-:4] = 1'sb0;
	assign acct_axi_req[12-:3] = 1'sb0;
	assign acct_axi_req[9-:4] = 1'sb0;
	assign acct_axi_req[5-:4] = 1'sb0;
	wire [277:0] reglk_axi_req;
	wire [81:0] reglk_axi_resp;
	// reglk_wrapper #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth),
	// 	.NB_SLAVE(NB_SLAVE),
	// 	.NB_PERIPHERALS(NB_PERIPHERALS)
	// ) i_reglk_wrapper(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.reglk_ctrl_o(reglk_ctrl),
	// 	.reglk_ctrl_i(reglk_ctrl[79:72]),
	// 	.acct_ctrl_i(acc_ctrl_c[(priv_lvl_i * NB_PERIPHERALS) + 9]),
	// 	.jtag_unlock(jtag_unlock),
	// 	.axi_req_i(reglk_axi_req),
	// 	.axi_resp_o(reglk_axi_resp),
	// 	.rst_9(rst_9)
	// );
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_reglk_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_reglk_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_reglk_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_reglk_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_reglk_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_reglk_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_reglk_noc3_ready_i),
	// 	.m_axi_awaddr(reglk_axi_req[273-:64]),
	// 	.m_axi_awvalid(reglk_axi_req[174]),
	// 	.m_axi_awready(reglk_axi_resp[81]),
	// 	.m_axi_wdata(reglk_axi_req[173-:64]),
	// 	.m_axi_wstrb(reglk_axi_req[109-:8]),
	// 	.m_axi_wvalid(reglk_axi_req[100]),
	// 	.m_axi_wready(reglk_axi_resp[79]),
	// 	.m_axi_araddr(reglk_axi_req[94-:64]),
	// 	.m_axi_arvalid(reglk_axi_req[1]),
	// 	.m_axi_arready(reglk_axi_resp[80]),
	// 	.m_axi_rdata(reglk_axi_resp[66-:64]),
	// 	.m_axi_rresp(reglk_axi_resp[2-:2]),
	// 	.m_axi_rvalid(reglk_axi_resp[71]),
	// 	.m_axi_rready(reglk_axi_req[0]),
	// 	.m_axi_bresp(reglk_axi_resp[73-:2]),
	// 	.m_axi_bvalid(reglk_axi_resp[78]),
	// 	.m_axi_bready(reglk_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign reglk_axi_req[277-:4] = 1'sb0;
	assign reglk_axi_req[209-:8] = 1'sb0;
	assign reglk_axi_req[201-:3] = 3'b011;
	assign reglk_axi_req[198-:2] = 1'sb0;
	assign reglk_axi_req[196] = 1'sb0;
	assign reglk_axi_req[195-:4] = 1'sb0;
	assign reglk_axi_req[191-:3] = 1'sb0;
	assign reglk_axi_req[188-:4] = 1'sb0;
	assign reglk_axi_req[184-:4] = 1'sb0;
	assign reglk_axi_req[180-:6] = 1'sb0;
	assign reglk_axi_req[101] = 1'b1;
	assign reglk_axi_req[98-:4] = 1'sb0;
	assign reglk_axi_req[30-:8] = 1'sb0;
	assign reglk_axi_req[22-:3] = 3'b011;
	assign reglk_axi_req[19-:2] = 1'sb0;
	assign reglk_axi_req[17] = 1'sb0;
	assign reglk_axi_req[16-:4] = 1'sb0;
	assign reglk_axi_req[12-:3] = 1'sb0;
	assign reglk_axi_req[9-:4] = 1'sb0;
	assign reglk_axi_req[5-:4] = 1'sb0;
	wire [277:0] dma_axi_req;
	wire [81:0] dma_axi_resp;
	// dma_wrapper #(
	// 	.AXI_ADDR_WIDTH(AxiAddrWidth),
	// 	.AXI_DATA_WIDTH(AxiDataWidth),
	// 	.AXI_ID_WIDTH(AxiIdWidth)
	// ) i_dma_wrapper(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.reglk_ctrl_i(reglk_ctrl[71:64]),
	// 	.acct_ctrl_i(acc_ctrl_c[(priv_lvl_i * NB_PERIPHERALS) + 8]),
	// 	.pmpcfg_i(pmpcfg_i),
	// 	.pmpaddr_i(pmpaddr_i),
	// 	.we_flag(we_flag_3),
	// 	.axi_req_i(dma_axi_req),
	// 	.axi_resp_o(dma_axi_resp),
	// 	.rst_8(rst_8)
	// );
	// noc_axilite_bridge #(
	// 	.SLAVE_RESP_BYTEWIDTH(8),
	// 	.SWAP_ENDIANESS(SwapEndianess)
	// ) i_dma_axilite_bridge(
	// 	.clk(clk_i),
	// 	.rst(~rst_ni),
	// 	.splitter_bridge_val(buf_ariane_dma_noc2_valid_i),
	// 	.splitter_bridge_data(buf_ariane_dma_noc2_data_i),
	// 	.bridge_splitter_rdy(ariane_dma_buf_noc2_ready_o),
	// 	.bridge_splitter_val(ariane_dma_buf_noc3_valid_o),
	// 	.bridge_splitter_data(ariane_dma_buf_noc3_data_o),
	// 	.splitter_bridge_rdy(buf_ariane_dma_noc3_ready_i),
	// 	.m_axi_awaddr(dma_axi_req[273-:64]),
	// 	.m_axi_awvalid(dma_axi_req[174]),
	// 	.m_axi_awready(dma_axi_resp[81]),
	// 	.m_axi_wdata(dma_axi_req[173-:64]),
	// 	.m_axi_wstrb(dma_axi_req[109-:8]),
	// 	.m_axi_wvalid(dma_axi_req[100]),
	// 	.m_axi_wready(dma_axi_resp[79]),
	// 	.m_axi_araddr(dma_axi_req[94-:64]),
	// 	.m_axi_arvalid(dma_axi_req[1]),
	// 	.m_axi_arready(dma_axi_resp[80]),
	// 	.m_axi_rdata(dma_axi_resp[66-:64]),
	// 	.m_axi_rresp(dma_axi_resp[2-:2]),
	// 	.m_axi_rvalid(dma_axi_resp[71]),
	// 	.m_axi_rready(dma_axi_req[0]),
	// 	.m_axi_bresp(dma_axi_resp[73-:2]),
	// 	.m_axi_bvalid(dma_axi_resp[78]),
	// 	.m_axi_bready(dma_axi_req[99]),
	// 	.w_reqbuf_size(),
	// 	.r_reqbuf_size()
	// );
	assign dma_axi_req[277-:4] = 1'sb0;
	assign dma_axi_req[209-:8] = 1'sb0;
	assign dma_axi_req[201-:3] = 3'b011;
	assign dma_axi_req[198-:2] = 1'sb0;
	assign dma_axi_req[196] = 1'sb0;
	assign dma_axi_req[195-:4] = 1'sb0;
	assign dma_axi_req[191-:3] = 1'sb0;
	assign dma_axi_req[188-:4] = 1'sb0;
	assign dma_axi_req[184-:4] = 1'sb0;
	assign dma_axi_req[180-:6] = 1'sb0;
	assign dma_axi_req[101] = 1'b1;
	assign dma_axi_req[98-:4] = 1'sb0;
	assign dma_axi_req[30-:8] = 1'sb0;
	assign dma_axi_req[22-:3] = 3'b011;
	assign dma_axi_req[19-:2] = 1'sb0;
	assign dma_axi_req[17] = 1'sb0;
	assign dma_axi_req[16-:4] = 1'sb0;
	assign dma_axi_req[12-:3] = 1'sb0;
	assign dma_axi_req[9-:4] = 1'sb0;
	assign dma_axi_req[5-:4] = 1'sb0;
	initial _sv2v_0 = 0;
	// always @(*) begin
	// 	`assert(1==2)
	// end
endmodule