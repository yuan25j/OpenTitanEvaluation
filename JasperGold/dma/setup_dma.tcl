clear -all
analyze -v2k dma.v
elaborate -top dma -bbox_m {pmp}
clock clk_i -factor 1 -phase 1
reset -expression ~rst_ni;
get_reset_info -save_reset_vcd dma.vcd