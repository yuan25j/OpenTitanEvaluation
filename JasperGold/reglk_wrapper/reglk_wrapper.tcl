clear -all
analyze -v2k reglk_wrapper.v
elaborate -top reglk_wrapper -bbox_m {axi_lite_interface}
clock clk_i -factor 1 -phase 1
reset -expression ~rst_ni;
get_reset_info -save_reset_vcd reglk_wrapper.vcd