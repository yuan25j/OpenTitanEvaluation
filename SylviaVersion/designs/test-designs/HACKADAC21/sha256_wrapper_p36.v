`define assert(expression) \
        if (!(expression)) begin \
            $display("ASSERTION FAILED"); \
            $finish; \
        end
module sha256(
           input wire            clk,
           input wire            rst,

           input wire            init,
           input wire            next,

           input wire [511 : 0]  block,

           input wire [255 : 0]  h_block,
           input wire            h_block_update,

           output wire           ready,
           output wire [255 : 0] digest,
           output wire           digest_valid
       );


//----------------------------------------------------------------
// Internal constant and parameter definitions.
//----------------------------------------------------------------
parameter SHA256_H0_0 = 32'h6a09e667;
parameter SHA256_H0_1 = 32'hbb67ae85;
parameter SHA256_H0_2 = 32'h3c6ef372;
parameter SHA256_H0_3 = 32'ha54ff53a;
parameter SHA256_H0_4 = 32'h510e527f;
parameter SHA256_H0_5 = 32'h9b05688c;
parameter SHA256_H0_6 = 32'h1f83d9ab;
parameter SHA256_H0_7 = 32'h5be0cd19;

parameter SHA256_ROUNDS = 63;

parameter CTRL_IDLE   = 0;
parameter CTRL_ROUNDS = 1;
parameter CTRL_DONE   = 2;
parameter CTRL_IGNORE = 3;


//----------------------------------------------------------------
// Registers including update variables and write enable.
//----------------------------------------------------------------
reg [31 : 0] a_reg;
reg [31 : 0] a_new;
reg [31 : 0] b_reg;
reg [31 : 0] b_new;
reg [31 : 0] c_reg;
reg [31 : 0] c_new;
reg [31 : 0] d_reg;
reg [31 : 0] d_new;
reg [31 : 0] e_reg;
reg [31 : 0] e_new;
reg [31 : 0] f_reg;
reg [31 : 0] f_new;
reg [31 : 0] g_reg;
reg [31 : 0] g_new;
reg [31 : 0] h_reg;
reg [31 : 0] h_new;
reg          a_h_we;

reg [31 : 0] H0_reg;
reg [31 : 0] H0_new;
reg [31 : 0] H1_reg;
reg [31 : 0] H1_new;
reg [31 : 0] H2_reg;
reg [31 : 0] H2_new;
reg [31 : 0] H3_reg;
reg [31 : 0] H3_new;
reg [31 : 0] H4_reg;
reg [31 : 0] H4_new;
reg [31 : 0] H5_reg;
reg [31 : 0] H5_new;
reg [31 : 0] H6_reg;
reg [31 : 0] H6_new;
reg [31 : 0] H7_reg;
reg [31 : 0] H7_new;
reg          H_we;

reg [5 : 0] t_ctr_reg;
reg [5 : 0] t_ctr_new;
reg         t_ctr_we;
reg         t_ctr_inc;
reg         t_ctr_rst;

reg digest_valid_reg;
reg digest_valid_new;
reg digest_valid_we;

reg ignore_input_reg; 
reg ignore_input_new; 
reg ignore_input_en; 

reg [1 : 0] sha256_ctrl_reg;
reg [1 : 0] sha256_ctrl_new;
reg         sha256_ctrl_we;


//----------------------------------------------------------------
// Wires.
//----------------------------------------------------------------
reg digest_init;
reg digest_update;

reg state_init;
reg state_update;

reg first_block;

reg ready_flag;

reg [31 : 0] t1;
reg [31 : 0] t2;

wire [31 : 0] k_data;

reg           w_init;
reg           w_next;
wire [31 : 0] w_data;


//----------------------------------------------------------------
// Module instantiantions.
//----------------------------------------------------------------
sha256_k_constants k_constants_inst(
                       .addr(t_ctr_reg),
                       .K(k_data)
                   );


sha256_w_mem w_mem_inst(
                 .clk(clk),
                 .rst(rst),

                 .block(block),

                 .init(w_init),
                 .next(w_next),
                 .w(w_data)
             );


//----------------------------------------------------------------
// Concurrent connectivity for ports etc.
//----------------------------------------------------------------
assign ready = ready_flag;

assign digest = {H0_reg, H1_reg, H2_reg, H3_reg,
                 H4_reg, H5_reg, H6_reg, H7_reg};

assign digest_valid = digest_valid_reg;


//----------------------------------------------------------------
// reg_update
// Update functionality for all registers in the core.
// All registers are positive edge triggered with synchronous
// reset. All registers have write enable.
//----------------------------------------------------------------
always @ (posedge clk)
    begin : reg_update
        if (!rst)
            begin
                a_reg            <= 32'h0;
                b_reg            <= 32'h0;
                c_reg            <= 32'h0;
                d_reg            <= 32'h0;
                e_reg            <= 32'h0;
                f_reg            <= 32'h0;
                g_reg            <= 32'h0;
                h_reg            <= 32'h0;
                H0_reg           <= 32'h0;
                H1_reg           <= 32'h0;
                H2_reg           <= 32'h0;
                H3_reg           <= 32'h0;
                H4_reg           <= 32'h0;
                H5_reg           <= 32'h0;
                H6_reg           <= 32'h0;
                H7_reg           <= 32'h0;
                digest_valid_reg <= 0;
                t_ctr_reg        <= 6'h0;
                sha256_ctrl_reg  <= CTRL_IDLE;
            end
        else
            begin

                if (a_h_we)
                    begin
                        a_reg <= a_new;
                        b_reg <= b_new;
                        c_reg <= c_new;
                        d_reg <= d_new;
                        e_reg <= e_new;
                        f_reg <= f_new;
                        g_reg <= g_new;
                        h_reg <= h_new;
                    end

                if (H_we)
                    begin
                        H0_reg <= H0_new;
                        H1_reg <= H1_new;
                        H2_reg <= H2_new;
                        H3_reg <= H3_new;
                        H4_reg <= H4_new;
                        H5_reg <= H5_new;
                        H6_reg <= H6_new;
                        H7_reg <= H7_new;
                    end

                if (t_ctr_we)
                    t_ctr_reg <= t_ctr_new;

                if (digest_valid_we)
                    digest_valid_reg <= digest_valid_new;

                if (sha256_ctrl_we)
                    sha256_ctrl_reg <= sha256_ctrl_new;

                if (ignore_input_en)
                    ignore_input_reg <= ignore_input_new; 
            end
    end // reg_update


//----------------------------------------------------------------
// digest_logic
//
// The logic needed to init as well as update the digest.
//----------------------------------------------------------------
always @*
    begin : digest_logic
        H0_new = 32'h0;
        H1_new = 32'h0;
        H2_new = 32'h0;
        H3_new = 32'h0;
        H4_new = 32'h0;
        H5_new = 32'h0;
        H6_new = 32'h0;
        H7_new = 32'h0;
        H_we = 0;

        if (digest_init)
            begin
                H_we = 1;
                H0_new = SHA256_H0_0;
                H1_new = SHA256_H0_1;
                H2_new = SHA256_H0_2;
                H3_new = SHA256_H0_3;
                H4_new = SHA256_H0_4;
                H5_new = SHA256_H0_5;
                H6_new = SHA256_H0_6;
                H7_new = SHA256_H0_7;
            end

        if (digest_update)
            begin
                H0_new = H0_reg + a_reg;
                H1_new = H1_reg + b_reg;
                H2_new = H2_reg + c_reg;
                H3_new = H3_reg + d_reg;
                H4_new = H4_reg + e_reg;
                H5_new = H5_reg + f_reg;
                H6_new = H6_reg + g_reg;
                H7_new = H7_reg + h_reg;
                H_we = 1;
            end

        if (h_block_update)
            begin
                H_we = 1;
                H0_new = h_block[7*32 +: 32];
                H1_new = h_block[6*32 +: 32];
                H2_new = h_block[5*32 +: 32];
                H3_new = h_block[4*32 +: 32];
                H4_new = h_block[3*32 +: 32];
                H5_new = h_block[2*32 +: 32];
                H6_new = h_block[1*32 +: 32];
                H7_new = h_block[0*32 +: 32];
            end 
    end // digest_logic


//----------------------------------------------------------------
// t1_logic
//
// The logic for the T1 function.
//----------------------------------------------------------------
always @*
    begin : t1_logic
        reg [31 : 0] sum1;
        reg [31 : 0] ch;

        sum1 = {e_reg[5  : 0], e_reg[31 :  6]} ^
             {e_reg[10 : 0], e_reg[31 : 11]} ^
             {e_reg[24 : 0], e_reg[31 : 25]};

        ch = (e_reg & f_reg) ^ ((~e_reg) & g_reg);

        t1 = h_reg + sum1 + ch + w_data + k_data;
    end // t1_logic


//----------------------------------------------------------------
// t2_logic
//
// The logic for the T2 function
//----------------------------------------------------------------
always @*
    begin : t2_logic
        reg [31 : 0] sum0;
        reg [31 : 0] maj;

        sum0 = {a_reg[1  : 0], a_reg[31 :  2]} ^
             {a_reg[12 : 0], a_reg[31 : 13]} ^
             {a_reg[21 : 0], a_reg[31 : 22]};

        maj = (a_reg & b_reg) ^ (a_reg & c_reg) ^ (b_reg & c_reg);

        t2 = sum0 + maj;
    end // t2_logic


//----------------------------------------------------------------
// state_logic
//
// The logic needed to init as well as update the state during
// round processing.
//----------------------------------------------------------------
always @*
    begin : state_logic
        a_new  = 32'h0;
        b_new  = 32'h0;
        c_new  = 32'h0;
        d_new  = 32'h0;
        e_new  = 32'h0;
        f_new  = 32'h0;
        g_new  = 32'h0;
        h_new  = 32'h0;
        a_h_we = 0;

        if (state_init)
            begin
                a_h_we = 1;
                if (first_block)
                    begin
                        a_new  = SHA256_H0_0;
                        b_new  = SHA256_H0_1;
                        c_new  = SHA256_H0_2;
                        d_new  = SHA256_H0_3;
                        e_new  = SHA256_H0_4;
                        f_new  = SHA256_H0_5;
                        g_new  = SHA256_H0_6;
                        h_new  = SHA256_H0_7;
                    end
                else
                    begin
                        a_new  = H0_reg;
                        b_new  = H1_reg;
                        c_new  = H2_reg;
                        d_new  = H3_reg;
                        e_new  = H4_reg;
                        f_new  = H5_reg;
                        g_new  = H6_reg;
                        h_new  = H7_reg;
                    end
            end

        if (state_update)
            begin
                a_new  = t1 + t2;
                b_new  = a_reg;
                c_new  = b_reg;
                d_new  = c_reg;
                e_new  = d_reg + t1;
                f_new  = e_reg;
                g_new  = f_reg;
                h_new  = g_reg;
                a_h_we = 1;
            end
    end // state_logic


//----------------------------------------------------------------
// t_ctr
//
// Update logic for the round counter, a monotonically
// increasing counter with reset.
//----------------------------------------------------------------
always @*
    begin : t_ctr
        t_ctr_new = 0;
        t_ctr_we  = 0;

        if (t_ctr_rst)
            begin
                t_ctr_new = 0;
                t_ctr_we  = 1;
            end

        if (t_ctr_inc)
            begin
                t_ctr_new = t_ctr_reg + 1'b1;
                t_ctr_we  = 1;
            end
    end // t_ctr


//----------------------------------------------------------------
// sha256_ctrl_fsm
//
// Logic for the state machine controlling the core behaviour.
//----------------------------------------------------------------
always @*
    begin : sha256_ctrl_fsm
        digest_init      = 0;
        digest_update    = 0;

        state_init       = 0;
        state_update     = 0;

        first_block      = 0;
        ready_flag       = 0;

        w_init           = 0;
        w_next           = 0;

        t_ctr_inc        = 0;
        t_ctr_rst        = 0;

        digest_valid_new = 0;
        digest_valid_we  = 0;

        sha256_ctrl_new  = CTRL_IDLE;
        sha256_ctrl_we   = 0;


        case (sha256_ctrl_reg)
            CTRL_IDLE:
                begin
                    ready_flag = 1;

                    if (init && next)
                        begin
                            ignore_input_new = 1; 
                            ignore_input_en = 1; 
                            sha256_ctrl_new = CTRL_IGNORE; 
                            sha256_ctrl_we   = 1;
                        end
                    else begin
                        if (init)
                            begin
                                digest_init      = 1;
                                w_init           = 1;
                                state_init       = 1;
                                first_block      = 1;
                                t_ctr_rst        = 1;
                                digest_valid_new = 0;
                                digest_valid_we  = 1;
                                sha256_ctrl_new  = CTRL_ROUNDS;
                                sha256_ctrl_we   = 1;
                            end

                        if (next)
                            begin
                                t_ctr_rst        = 1;
                                w_init           = 1;
                                state_init       = 1;
                                digest_valid_new = 0;
                                digest_valid_we  = 1;
                                sha256_ctrl_new  = CTRL_ROUNDS;
                                sha256_ctrl_we   = 1;
                            end
                    end
                end


            CTRL_ROUNDS:
                begin
                    w_next       = 1;
                    state_update = 1;
                    t_ctr_inc    = 1;

                    if (t_ctr_reg == SHA256_ROUNDS)
                        begin
                            sha256_ctrl_new = CTRL_DONE;
                            sha256_ctrl_we  = 1;
                        end
                end


            CTRL_DONE:
                begin
                    digest_update    = 1;
                    digest_valid_new = 1;
                    digest_valid_we  = 1;

                    sha256_ctrl_new  = CTRL_IDLE;
                    sha256_ctrl_we   = 1;
                end
            CTRL_IGNORE:
                begin
                    if (ignore_input_reg)
                        begin
                            sha256_ctrl_new  = CTRL_IGNORE;
                            sha256_ctrl_we   = 1;
                        end
                    else
                        begin
                            sha256_ctrl_new  = CTRL_IDLE;
                            sha256_ctrl_we   = 1;
                        end
                end
        endcase // case (sha256_ctrl_reg)
    end // sha256_ctrl_fsm

endmodule // sha256_core
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
	always @(*) begin
		//Tranlsate this SVA: assert -name HACK@DAC21_p36 {((sha256_wrapper_i.sha256.sha256_ctrl_reg == sha256_wrapper_i.sha256.CTRL_IGNORE && sha256_wrapper_i.sha256.ignore_input_reg) |-> (sha256_wrapper_i.data == 0))}
        //Direct translation:
		// if(sha256.sha256_ctrl_reg==sha256.CTRL_IGNORE && sha256.ignore_input_reg) begin
        //     `assert(data==0)
        // end
        //Compressed translation:
        `assert(!(sha256.sha256_ctrl_reg==sha256.CTRL_IGNORE && sha256.ignore_input_reg) || (data==0))
	end
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
	sha256 sha256(
		.clk(clk_i),
		.rst(rst_ni && ~rst_3),
		.init(startHash && ~startHash_r),
		.next(newMessage && ~newMessage_r),
		.block(bigData),
		.h_block(h_block),
		.h_block_update(h_block_update),
		.digest(hash),
		.digest_valid(hashValid),
		.ready(ready)
	);
	// always @(*) begin
	// 	`assert(1==2)
	// end
endmodule