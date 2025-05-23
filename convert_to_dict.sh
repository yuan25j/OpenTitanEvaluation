#!/usr/bin/env bash

python3 convert_to_dict.py vcdParse/acct_wrapper/acct_wrapper_reset_states_view.txt SylviaVersion/reset_states_hardcoded_automated/acct_wrapper_reset_states.txt
python3 convert_to_dict.py vcdParse/aes_192/aes_192_vcdParseOutput.txt SylviaVersion/reset_states_hardcoded_automated/aes_192_reset_states.txt
python3 convert_to_dict.py vcdParse/aes0_wrapper/aes0_wrapper_reset_states_view.txt SylviaVersion/reset_states_hardcoded_automated/aes0_wrapper_reset_states.txt
python3 convert_to_dict.py vcdParse/csr_regfile/csr_regfile_reset_states_view.txt SylviaVersion/reset_states_hardcoded_automated/csr_regfile_reset_states.txt
python3 convert_to_dict.py vcdParse/dma/dma_reset_states_view.txt SylviaVersion/reset_states_hardcoded_automated/dma_reset_states.txt
python3 convert_to_dict.py vcdParse/dmi_jtag/dmi_jtag_reset_states_view.txt SylviaVersion/reset_states_hardcoded_automated/dmi_jtag_reset_states.txt
python3 convert_to_dict.py vcdParse/reglk_wrapper/reglk_wrapper_reset_states_view.txt SylviaVersion/reset_states_hardcoded_automated/reglk_wrapper_reset_states.txt
python3 convert_to_dict.py vcdParse/riscv_peripherals/riscv_peripherals_reset_states_view.txt SylviaVersion/reset_states_hardcoded_automated/riscv_peripherals_reset_states.txt
python3 convert_to_dict.py vcdParse/rsa_wrapper/rsa_wrapper_reset_states_view.txt SylviaVersion/reset_states_hardcoded_automated/rsa_wrapper_reset_states.txt
python3 convert_to_dict.py vcdParse/sha256_wrapper/sha256_wrapper_reset_states_view.txt SylviaVersion/reset_states_hardcoded_automated/sha256_wrapper_reset_states.txt