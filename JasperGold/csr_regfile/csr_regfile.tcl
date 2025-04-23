clear -all
analyze -v2k csr_regfile.v
elaborate -top csr_regfile
clock clk_i -factor 1 -phase 1
reset -expression ~rst_ni;
get_reset_info -save_reset_vcd csr_regfile.vcd