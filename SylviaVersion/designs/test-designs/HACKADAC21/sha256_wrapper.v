`define assert(expression) \
        if (!(expression)) begin \
            $display("ASSERTION FAILED"); \
            $finish; \
        end
module sha256_wrapper (
	clk_i,
	rst_ni,
	reglk_ctrl_i,
	acct_ctrl_i,
	axi_req_i,
	axi_resp_o,
	rst_3
);
	parameter [31:0] AXI_ADDR_WIDTH = 64;
	parameter [31:0] AXI_DATA_WIDTH = 64;
	parameter [31:0] AXI_ID_WIDTH = 10;
	input wire clk_i;
	input wire rst_ni;
	input wire [7:0] reglk_ctrl_i;
	input wire acct_ctrl_i;
	localparam ariane_axi_AddrWidth = 64;
	localparam ariane_soc_IdWidth = 4;
	localparam ariane_axi_DataWidth = 64;
	localparam ariane_axi_StrbWidth = 8;
	input wire [277:0] axi_req_i;
	output wire [81:0] axi_resp_o;
	input wire rst_3;
	reg newMessage_r;
	reg startHash_r;
	reg startHash;
	reg newMessage;
	reg [31:0] data [0:15];
	wire [511:0] bigData;
	wire [255:0] hash;
	wire ready;
	wire hashValid;
	wire [255:0] h_block;
	wire h_block_update;
	wire [AXI_ADDR_WIDTH - 1:0] address;
	wire en;
	wire en_acct;
	wire we;
	wire [63:0] wdata;
	reg [63:0] rdata;
	assign h_block_update = 0;
	assign h_block = 0;
	assign bigData = {data[15], data[14], data[13], data[12], data[11], data[10], data[9], data[8], data[7], data[6], data[5], data[4], data[3], data[2], data[1], data[0]};
	// axi_lite_interface #(
	// 	.AXI_ADDR_WIDTH(AXI_ADDR_WIDTH),
	// 	.AXI_DATA_WIDTH(AXI_DATA_WIDTH),
	// 	.AXI_ID_WIDTH(AXI_ID_WIDTH)
	// ) axi_lite_interface_i(
	// 	.clk_i(clk_i),
	// 	.rst_ni(rst_ni),
	// 	.axi_req_i(axi_req_i),
	// 	.axi_resp_o(axi_resp_o),
	// 	.address_o(address),
	// 	.en_o(en_acct),
	// 	.we_o(we),
	// 	.data_i(rdata),
	// 	.data_o(wdata)
	// );
	assign en = en_acct && acct_ctrl_i;
	always @(posedge clk_i)
		if (~rst_ni || rst_3) begin
			startHash_r <= 1'b0;
			newMessage_r <= 1'b0;
		end
		else begin
			startHash_r <= startHash;
			newMessage_r <= newMessage;
		end
	always @(posedge clk_i)
		if (~(rst_ni && ~rst_3)) begin
			startHash <= 0;
			newMessage <= 0;
			data[0] <= 0;
			data[1] <= 0;
			data[2] <= 0;
			data[3] <= 0;
			data[4] <= 0;
			data[5] <= 0;
			data[6] <= 0;
			data[7] <= 0;
			data[8] <= 0;
			data[9] <= 0;
			data[10] <= 0;
			data[11] <= 0;
			data[12] <= 0;
			data[13] <= 0;
			data[14] <= 0;
			data[15] <= 0;
		end
		else if (en && we)
			case (address[7:3])
				0: begin
					startHash <= (reglk_ctrl_i[1] ? startHash : wdata[0]);
					newMessage <= (reglk_ctrl_i[1] ? newMessage : wdata[1]);
				end
				1: data[0] <= (reglk_ctrl_i[3] ? data[0] : wdata);
				2: data[1] <= (reglk_ctrl_i[3] ? data[1] : wdata);
				3: data[2] <= (reglk_ctrl_i[3] ? data[2] : wdata);
				4: data[3] <= (reglk_ctrl_i[3] ? data[3] : wdata);
				5: data[4] <= (reglk_ctrl_i[3] ? data[4] : wdata);
				6: data[5] <= (reglk_ctrl_i[3] ? data[5] : wdata);
				7: data[6] <= (reglk_ctrl_i[3] ? data[6] : wdata);
				8: data[7] <= (reglk_ctrl_i[3] ? data[7] : wdata);
				9: data[8] <= (reglk_ctrl_i[3] ? data[8] : wdata);
				10: data[9] <= (reglk_ctrl_i[3] ? data[9] : wdata);
				11: data[10] <= (reglk_ctrl_i[3] ? data[10] : wdata);
				12: data[11] <= (reglk_ctrl_i[3] ? data[11] : wdata);
				13: data[12] <= (reglk_ctrl_i[3] ? data[12] : wdata);
				14: data[13] <= (reglk_ctrl_i[3] ? data[13] : wdata);
				15: data[14] <= (reglk_ctrl_i[3] ? data[14] : wdata);
				16: data[15] <= (reglk_ctrl_i[3] ? data[15] : wdata);
				default:
					;
			endcase
	always @(*) begin
		rdata = 64'b0000000000000000000000000000000000000000000000000000000000000000;
		if (en)
			case (address[7:3])
				0: rdata = (reglk_ctrl_i[0] ? 'b0 : {31'b0000000000000000000000000000000, ready});
				1: rdata = (reglk_ctrl_i[2] ? 'b0 : data[0]);
				2: rdata = (reglk_ctrl_i[2] ? 'b0 : data[1]);
				3: rdata = (reglk_ctrl_i[2] ? 'b0 : data[2]);
				4: rdata = (reglk_ctrl_i[2] ? 'b0 : data[3]);
				5: rdata = (reglk_ctrl_i[2] ? 'b0 : data[4]);
				6: rdata = (reglk_ctrl_i[2] ? 'b0 : data[5]);
				7: rdata = (reglk_ctrl_i[2] ? 'b0 : data[6]);
				8: rdata = (reglk_ctrl_i[2] ? 'b0 : data[7]);
				9: rdata = (reglk_ctrl_i[2] ? 'b0 : data[8]);
				10: rdata = (reglk_ctrl_i[2] ? 'b0 : data[9]);
				11: rdata = (reglk_ctrl_i[2] ? 'b0 : data[10]);
				12: rdata = (reglk_ctrl_i[2] ? 'b0 : data[11]);
				13: rdata = (reglk_ctrl_i[2] ? 'b0 : data[12]);
				14: rdata = (reglk_ctrl_i[2] ? 'b0 : data[13]);
				15: rdata = (reglk_ctrl_i[2] ? 'b0 : data[14]);
				16: rdata = (reglk_ctrl_i[2] ? 'b0 : data[15]);
				17: rdata = (reglk_ctrl_i[0] ? 'b0 : {31'b0000000000000000000000000000000, hashValid});
				18: rdata = (reglk_ctrl_i[4] ? 'b0 : hash[31:0]);
				19: rdata = (reglk_ctrl_i[4] ? 'b0 : hash[63:32]);
				20: rdata = (reglk_ctrl_i[4] ? 'b0 : hash[95:64]);
				21: rdata = (reglk_ctrl_i[4] ? 'b0 : hash[127:96]);
				22: rdata = (reglk_ctrl_i[4] ? 'b0 : hash[159:128]);
				23: rdata = (reglk_ctrl_i[4] ? 'b0 : hash[191:160]);
				24: rdata = (reglk_ctrl_i[4] ? 'b0 : hash[223:192]);
				25: rdata = (reglk_ctrl_i[4] ? 'b0 : hash[255:224]);
				default: rdata = 32'b00000000000000000000000000000000;
			endcase
	end
	// sha256 sha256(
	// 	.clk(clk_i),
	// 	.rst(rst_ni && ~rst_3),
	// 	.init(startHash && ~startHash_r),
	// 	.next(newMessage && ~newMessage_r),
	// 	.block(bigData),
	// 	.h_block(h_block),
	// 	.h_block_update(h_block_update),
	// 	.digest(hash),
	// 	.digest_valid(hashValid),
	// 	.ready(ready)
	// );
	always @(*) begin
		`assert(1==2)
	end
endmodule