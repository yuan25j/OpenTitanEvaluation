clear -all
analyze -v2k riscv_peripherals.v
elaborate -top riscv_peripherals -bbox_m {dmi_jtag dm_top AXI_BUS bootrom bootrom_linux clint noc_axilite_bridge plic_top rst_wrapper rsa_wrapper rng_wrapper aes0_wrapper aes1_wrapper aes2_wrapper hmac_wrapper pkt_wrapper fuse_mem reglk_wrapper dma_wrapper sha256_wrapper}
clock clk_i -factor 1 -phase 1
reset -expression ~rst_ni;
get_reset_info -save_reset_vcd riscv_peripherals.vcd