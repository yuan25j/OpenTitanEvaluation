/*
 * Copyright 2012, Homer Hsing <homer.hsing@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
`define assert(expression) \
        if (!(expression)) begin \
            $display("ASSERTION FAILED"); \
            $finish; \
        end
module aes_192 (clk,rst_i, start, state, key, out, out_valid);
input          clk;
input          rst_i;
input          start;
input  [127:0] state;
input  [191:0] key;
output [127:0] out;
output         out_valid;
reg    [127:0] s0;
reg    [191:0] k0;
wire   [127:0] s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11;
wire   [191:0] k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11;
wire   [127:0] k0b, k1b, k2b, k3b, k4b, k5b, k6b, k7b, k8b, k9b, k10b, k11b;

reg start_r;
reg [4:0] prev_validCounter;
always @(posedge clk)
    begin
        prev_validCounter <= validCounter;
        start_r <= start;
        `assert(out_valid || (validCounter == (prev_validCounter - 1)))
    end

wire start_posedge = start & ~start_r;
reg [4:0] validCounter;

always @ (posedge clk)
    begin
        if(start_posedge)
            begin
                s0 <= state ^ key[191:64];
                k0 <= key;
                validCounter <= 25;
            end
        else if(~out_valid)
            begin
                validCounter <= validCounter - 1;
            end
    end

assign out_valid = (validCounter == 0);

// expand_key_type_D_192  a0 (clk, k0, 8'h1,   k1,  k0b);
// expand_key_type_B_192  a1 (clk, k1,         k2,  k1b);
// expand_key_type_A_192  a2 (clk, k2, 8'h2,   k3,  k2b);
// expand_key_type_C_192  a3 (clk, k3, 8'h4,   k4,  k3b);
// expand_key_type_B_192  a4 (clk, k4,         k5,  k4b);
// expand_key_type_A_192  a5 (clk, k5, 8'h8,   k6,  k5b);
// expand_key_type_C_192  a6 (clk, k6, 8'h10,  k7,  k6b);
// expand_key_type_B_192  a7 (clk, k7,         k8,  k7b);
// expand_key_type_A_192  a8 (clk, k8, 8'h20,  k9,  k8b);
// expand_key_type_C_192  a9 (clk, k9, 8'h40, k10,  k9b);
// expand_key_type_B_192 a10 (clk,k10,        k11, k10b);
// one_round
//     r1 (clk, s0, k0b, s1),
//     r2 (clk, s1, k1b, s2),
//     r3 (clk, s2, k2b, s3),
//     r4 (clk, s3, k3b, s4),
//     r5 (clk, s4, k4b, s5),
//     r6 (clk, s5, k5b, s6),
//     r7 (clk, s6, k6b, s7),
//     r8 (clk, s7, k7b, s8),
//     r9 (clk, s8, k8b, s9),
//     r10 (clk, s9, k9b, s10),
//     r11 (clk, s10, k10b, s11);
// final_round
//     rf (clk, s11, k11b, out);

endmodule