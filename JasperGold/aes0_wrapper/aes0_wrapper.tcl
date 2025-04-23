clear -all
analyze -v2k aes0_wrapper.v
elaborate -top aes0_wrapper -bbox_m {axi_lite_interface aes_192_sed}
clock clk_i -factor 1 -phase 1
reset -expression ~rst_ni;
get_reset_info -save_reset_vcd aes0_wrapper.vcd