clear -all
analyze -v2k sha256_wrapper.v
elaborate -top sha256_wrapper -bbox_m {axi_lite_interface sha256}
clock clk_i -factor 1 -phase 1
reset -expression ~rst_ni;
get_reset_info -save_reset_vcd sha256_wrapper.vcd