clear -all
analyze -v2k acct_wrapper.v
elaborate -top acct_wrapper -bbox_m {axi_lite_interface}
clock clk_i -factor 1 -phase 1
reset -expression ~rst_ni;
get_reset_info -save_reset_vcd acct_wrapper.vcd