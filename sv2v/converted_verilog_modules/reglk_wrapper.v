module reglk_wrapper (
	clk_i,
	rst_ni,
	jtag_unlock,
	reglk_ctrl_i,
	acct_ctrl_i,
	reglk_ctrl_o,
	axi_req_i,
	axi_resp_o,
	rst_9
);
	parameter [31:0] AXI_ADDR_WIDTH = 64;
	parameter [31:0] AXI_DATA_WIDTH = 64;
	parameter [31:0] AXI_ID_WIDTH = 10;
	parameter NB_SLAVE = 1;
	parameter NB_PERIPHERALS = 14;
	input wire clk_i;
	input wire rst_ni;
	input wire jtag_unlock;
	input wire [7:0] reglk_ctrl_i;
	input wire acct_ctrl_i;
	localparam ariane_axi_AddrWidth = 64;
	localparam ariane_soc_IdWidth = 4;
	localparam ariane_axi_DataWidth = 64;
	localparam ariane_axi_StrbWidth = 8;
	input wire [277:0] axi_req_i;
	output wire [81:0] axi_resp_o;
	output wire [(8 * NB_PERIPHERALS) - 1:0] reglk_ctrl_o;
	input wire rst_9;
	wire [15:0] reglk_ctrl;
	reg [191:0] reglk_mem;
	wire [AXI_ADDR_WIDTH - 1:0] address;
	wire en;
	wire en_acct;
	wire we;
	wire [63:0] wdata;
	reg [63:0] rdata;
	assign reglk_ctrl_o = {reglk_mem[160+:32], reglk_mem[128+:32], reglk_mem[96+:32], reglk_mem[64+:32], reglk_mem[32+:32], reglk_mem[0+:32]};
	assign reglk_ctrl = reglk_ctrl_i;
	axi_lite_interface #(
		.AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
		.AXI_DATA_WIDTH(AXI_DATA_WIDTH),
		.AXI_ID_WIDTH(AXI_ID_WIDTH)
	) axi_lite_interface_i(
		.clk_i(clk_i),
		.rst_ni(rst_ni),
		.axi_req_i(axi_req_i),
		.axi_resp_o(axi_resp_o),
		.address_o(address),
		.en_o(en_acct),
		.we_o(we),
		.data_i(rdata),
		.data_o(wdata)
	);
	assign en = en_acct && acct_ctrl_i;
	integer j;
	always @(posedge clk_i)
		if (~((rst_ni && ~jtag_unlock) && ~rst_9))
			for (j = 0; j < 6; j = j + 1)
				reglk_mem[j * 32+:32] <= 'h0;
		else if (en && we)
			case (address[7:3])
				0: reglk_mem[0+:32] <= (reglk_ctrl[3] ? reglk_mem[0+:32] : wdata);
				1: reglk_mem[32+:32] <= (reglk_ctrl[1] ? reglk_mem[32+:32] : wdata);
				2: reglk_mem[64+:32] <= (reglk_ctrl[1] ? reglk_mem[96+:32] : wdata);
				3: reglk_mem[96+:32] <= (reglk_ctrl[1] ? reglk_mem[96+:32] : wdata);
				4: reglk_mem[128+:32] <= (reglk_ctrl[1] ? reglk_mem[128+:32] : wdata);
				5: reglk_mem[160+:32] <= (reglk_ctrl[1] ? reglk_mem[160+:32] : wdata);
				default:
					;
			endcase
	always @(*) begin
		rdata = 64'b0000000000000000000000000000000000000000000000000000000000000000;
		if (en)
			case (address[7:3])
				0: rdata = (reglk_ctrl[0] ? 'b0 : reglk_mem[0+:32]);
				1: rdata = (reglk_ctrl[0] ? 'b0 : reglk_mem[32+:32]);
				2: rdata = (reglk_ctrl[0] ? 'b0 : reglk_mem[64+:32]);
				3: rdata = (reglk_ctrl[0] ? 'b0 : reglk_mem[96+:32]);
				4: rdata = (reglk_ctrl[0] ? 'b0 : reglk_mem[128+:32]);
				5: rdata = (reglk_ctrl[0] ? 'b0 : reglk_mem[160+:32]);
				default: rdata = 32'b00000000000000000000000000000000;
			endcase
	end
endmodule