module aes0_wrapper (
	clk_i,
	rst_ni,
	reglk_ctrl_i,
	acct_ctrl_i,
	debug_mode_i,
	axi_req_i,
	axi_resp_o,
	rst_1
);
	parameter [31:0] AXI_ADDR_WIDTH = 64;
	parameter [31:0] AXI_DATA_WIDTH = 64;
	parameter [31:0] AXI_ID_WIDTH = 10;
	input wire clk_i;
	input wire rst_ni;
	input wire [7:0] reglk_ctrl_i;
	input wire acct_ctrl_i;
	input wire debug_mode_i;
	localparam ariane_axi_AddrWidth = 64;
	localparam ariane_soc_IdWidth = 4;
	localparam ariane_axi_DataWidth = 64;
	localparam ariane_axi_StrbWidth = 8;
	input wire [277:0] axi_req_i;
	output wire [81:0] axi_resp_o;
	input wire rst_1;
	reg start;
	reg [31:0] p_c [0:3];
	reg [31:0] state [0:3];
	reg [31:0] key0 [0:5];
	reg [31:0] key1 [0:5];
	reg [31:0] key2 [0:5];
	reg [1:0] key_sel;
	wire [127:0] p_c_big;
	wire [127:0] state_big;
	wire [191:0] key_big;
	wire [191:0] key_big0;
	wire [191:0] key_big1;
	wire [191:0] key_big2;
	wire [127:0] ct;
	wire ct_valid;
	wire [AXI_ADDR_WIDTH - 1:0] address;
	wire en;
	wire en_acct;
	wire we;
	wire [63:0] wdata;
	reg [63:0] rdata;
	assign p_c_big = {p_c[0], p_c[1], p_c[2], p_c[3]};
	assign state_big = {state[0], state[1], state[2], state[3]};
	assign key_big0 = (debug_mode_i ? 192'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : {key0[0], key0[1], key0[2], key0[3], key0[4], key0[5]});
	assign key_big1 = (debug_mode_i ? 192'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 : {key1[0], key1[1], key1[2], key1[3], key1[4], key1[5]});
	assign key_big2 = {key2[0], key2[1], key2[2], key2[3], key2[4], key2[5]};
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
	always @(posedge clk_i)
		if (~(rst_ni && ~rst_1)) begin
			start <= 0;
			p_c[0] <= 0;
			p_c[1] <= 0;
			p_c[2] <= 0;
			p_c[3] <= 0;
			state[0] <= 0;
			state[1] <= 0;
			state[2] <= 0;
			state[3] <= 0;
		end
		else if (en && we)
			case (address[8:3])
				0: start <= (reglk_ctrl_i[1] ? start : wdata[0]);
				1: p_c[3] <= (reglk_ctrl_i[3] ? p_c[3] : wdata[31:0]);
				2: p_c[2] <= (reglk_ctrl_i[3] ? p_c[2] : wdata[31:0]);
				3: p_c[1] <= (reglk_ctrl_i[3] ? p_c[1] : wdata[31:0]);
				4: p_c[0] <= (reglk_ctrl_i[3] ? p_c[0] : wdata[31:0]);
				5: key0[5] <= (reglk_ctrl_i[5] ? key0[5] : wdata[31:0]);
				6: key0[4] <= (reglk_ctrl_i[5] ? key0[4] : wdata[31:0]);
				7: key0[3] <= (reglk_ctrl_i[5] ? key0[3] : wdata[31:0]);
				8: key0[2] <= (reglk_ctrl_i[5] ? key0[2] : wdata[31:0]);
				9: key0[1] <= (reglk_ctrl_i[5] ? key0[1] : wdata[31:0]);
				10: key0[0] <= (reglk_ctrl_i[5] ? key0[0] : wdata[31:0]);
				16: state[3] <= (reglk_ctrl_i[7] ? state[3] : wdata[31:0]);
				17: state[2] <= (reglk_ctrl_i[7] ? state[2] : wdata[31:0]);
				18: state[1] <= (reglk_ctrl_i[7] ? state[1] : wdata[31:0]);
				19: state[0] <= (reglk_ctrl_i[7] ? state[0] : wdata[31:0]);
				20: key1[5] <= (reglk_ctrl_i[5] ? key1[5] : wdata[31:0]);
				21: key1[4] <= (reglk_ctrl_i[5] ? key1[4] : wdata[31:0]);
				22: key1[3] <= (reglk_ctrl_i[5] ? key1[3] : wdata[31:0]);
				23: key1[2] <= (reglk_ctrl_i[5] ? key1[2] : wdata[31:0]);
				24: key1[1] <= (reglk_ctrl_i[5] ? key1[1] : wdata[31:0]);
				25: key1[0] <= (reglk_ctrl_i[5] ? key1[0] : wdata[31:0]);
				26: key2[5] <= (reglk_ctrl_i[5] ? key2[5] : wdata[31:0]);
				27: key2[4] <= (reglk_ctrl_i[5] ? key2[4] : wdata[31:0]);
				28: key2[3] <= (reglk_ctrl_i[5] ? key2[3] : wdata[31:0]);
				29: key2[2] <= (reglk_ctrl_i[5] ? key2[2] : wdata[31:0]);
				30: key2[1] <= (reglk_ctrl_i[5] ? key2[1] : wdata[31:0]);
				31: key2[0] <= (reglk_ctrl_i[5] ? key2[0] : wdata[31:0]);
				32: key_sel <= (reglk_ctrl_i[1] ? key_sel : wdata[31:0]);
				default:
					;
			endcase
	always @(*) begin
		rdata = 64'b0000000000000000000000000000000000000000000000000000000000000000;
		if (en) begin
			rdata = key0[address[8:3]];
			case (address[8:3])
				0: rdata = (reglk_ctrl_i[0] ? 'b0 : {31'b0000000000000000000000000000000, start});
				1: rdata = (reglk_ctrl_i[2] ? 'b0 : p_c[3]);
				2: rdata = (reglk_ctrl_i[2] ? 'b0 : p_c[2]);
				3: rdata = (reglk_ctrl_i[2] ? 'b0 : p_c[1]);
				4: rdata = (reglk_ctrl_i[2] ? 'b0 : p_c[0]);
				11: rdata = (reglk_ctrl_i[6] ? 'b0 : {31'b0000000000000000000000000000000, ct_valid});
				12: rdata = (reglk_ctrl_i[4] ? 'b0 : ct[31:0]);
				13: rdata = (reglk_ctrl_i[4] ? 'b0 : ct[63:32]);
				14: rdata = (reglk_ctrl_i[4] ? 'b0 : ct[95:64]);
				15: rdata = (reglk_ctrl_i[4] ? 'b0 : ct[127:96]);
				default:
					if (ct_valid)
						rdata = 32'b00000000000000000000000000000000;
			endcase
		end
	end
	assign key_big = (key_sel[1] ? key_big2 : (key_sel[0] ? key_big1 : key_big0));
	aes_192_sed aes(
		.clk(clk_i),
		.state(state_big),
		.p_c_text(p_c_big),
		.key(key_big),
		.start(start),
		.out(ct),
		.out_valid(ct_valid)
	);
endmodule