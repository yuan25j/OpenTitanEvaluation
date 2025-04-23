clear -all
analyze -v2k rsa_wrapper.v
elaborate -top rsa_wrapper -bbox_m {axi_lite_interface rsa_top}
clock clk_i -factor 1 -phase 1
reset -expression ~rst_ni;
get_reset_info -save_reset_vcd rsa_wrapper.vcd