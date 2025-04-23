clear -all
analyze -v2k dmi_jtag.v
elaborate -top dmi_jtag -bbox_m {dmi_jtag_tap dmi_cdc hmac}
clock tck_i -factor 1 -phase 1
reset -expression ~trst_ni;