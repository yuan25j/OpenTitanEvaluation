clear -all
analyze -verilog aes_192.v
elaborate -top aes_192 -bbox_m {S4 one_round final_round}
clock clk -factor 1 -phase 1
reset -expression ~rst_i;
get_reset_info -save_reset_vcd aes_192.vcd