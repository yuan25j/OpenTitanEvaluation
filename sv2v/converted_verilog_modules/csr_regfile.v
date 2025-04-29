module csr_regfile (
	clk_i,
	rst_ni,
	time_irq_i,
	flush_o,
	halt_csr_o,
	commit_instr_i,
	commit_ack_i,
	boot_addr_i,
	hart_id_i,
	ex_i,
	csr_op_i,
	csr_addr_i,
	csr_wdata_i,
	csr_rdata_o,
	dirty_fp_state_i,
	csr_write_fflags_i,
	pc_i,
	csr_exception_o,
	epc_o,
	eret_o,
	trap_vector_base_o,
	priv_lvl_o,
	fs_o,
	fflags_o,
	frm_o,
	fprec_o,
	irq_ctrl_o,
	en_translation_o,
	en_ld_st_translation_o,
	ld_st_priv_lvl_o,
	sum_o,
	mxr_o,
	satp_ppn_o,
	asid_o,
	irq_i,
	ipi_i,
	debug_req_i,
	set_debug_pc_o,
	tvm_o,
	tw_o,
	tsr_o,
	debug_mode_o,
	single_step_o,
	icache_en_o,
	dcache_en_o,
	perf_addr_o,
	perf_data_o,
	perf_data_i,
	perf_we_o,
	pmpcfg_o,
	pmpaddr_o,
	we_flag_0_o,
	uie_o,
	utvec_o,
	utval_o,
	uip_o
);
	reg _sv2v_0;
	parameter [63:0] DmBaseAddress = 64'h0000000000000000;
	parameter signed [31:0] AsidWidth = 1;
	parameter [31:0] NrCommitPorts = 2;
	parameter [31:0] NrPMPEntries = 8;
	input wire clk_i;
	input wire rst_ni;
	input wire time_irq_i;
	output reg flush_o;
	output wire halt_csr_o;
	localparam ariane_pkg_REG_ADDR_SIZE = 6;
	localparam ariane_pkg_NR_SB_ENTRIES = 8;
	localparam ariane_pkg_TRANS_ID_BITS = 3;
	localparam riscv_VLEN = 64;
	input wire [(NrCommitPorts * 361) - 1:0] commit_instr_i;
	input wire [NrCommitPorts - 1:0] commit_ack_i;
	input wire [63:0] boot_addr_i;
	input wire [63:0] hart_id_i;
	input wire [128:0] ex_i;
	input wire [6:0] csr_op_i;
	input wire [11:0] csr_addr_i;
	input wire [63:0] csr_wdata_i;
	output reg [63:0] csr_rdata_o;
	input wire dirty_fp_state_i;
	input wire csr_write_fflags_i;
	input wire [63:0] pc_i;
	output reg [128:0] csr_exception_o;
	output reg [63:0] epc_o;
	output reg eret_o;
	output reg [63:0] trap_vector_base_o;
	output wire [1:0] priv_lvl_o;
	output wire [1:0] fs_o;
	output wire [4:0] fflags_o;
	output wire [2:0] frm_o;
	output wire [6:0] fprec_o;
	output wire [193:0] irq_ctrl_o;
	output wire en_translation_o;
	output reg en_ld_st_translation_o;
	output reg [1:0] ld_st_priv_lvl_o;
	output wire sum_o;
	output wire mxr_o;
	output wire [43:0] satp_ppn_o;
	output wire [AsidWidth - 1:0] asid_o;
	input wire [1:0] irq_i;
	input wire ipi_i;
	input wire debug_req_i;
	output reg set_debug_pc_o;
	output wire tvm_o;
	output wire tw_o;
	output wire tsr_o;
	output wire debug_mode_o;
	output wire single_step_o;
	output wire icache_en_o;
	output wire dcache_en_o;
	output reg [4:0] perf_addr_o;
	output reg [63:0] perf_data_o;
	input wire [63:0] perf_data_i;
	output reg perf_we_o;
	output wire [(NrPMPEntries * 8) - 1:0] pmpcfg_o;
	output wire [(NrPMPEntries * 54) - 1:0] pmpaddr_o;
	output wire we_flag_0_o;
	output wire uie_o;
	output wire utvec_o;
	output wire utval_o;
	output wire uip_o;
	reg read_access_exception;
	reg update_access_exception;
	reg privilege_violation;
	reg csr_we;
	reg csr_read;
	reg [63:0] csr_wdata;
	reg [63:0] csr_rdata;
	reg [1:0] trap_to_priv_lvl;
	reg en_ld_st_translation_d;
	reg en_ld_st_translation_q;
	wire mprv;
	reg mret;
	reg sret;
	reg dret;
	reg dirty_fp_state_csr;
	reg [63:0] mstatus_q;
	reg [63:0] mstatus_d;
	reg [63:0] satp_q;
	reg [63:0] satp_d;
	reg [31:0] dcsr_q;
	reg [31:0] dcsr_d;
	wire [11:0] csr_addr;
	reg [1:0] priv_lvl_d;
	reg [1:0] priv_lvl_q;
	reg debug_mode_q;
	reg debug_mode_d;
	reg mtvec_rst_load_q;
	reg [63:0] uscratch_q;
	reg [63:0] uscratch_d;
	reg [63:0] uie_q;
	reg [63:0] uie_d;
	reg [63:0] utvec_q;
	reg [63:0] utvec_d;
	reg [63:0] utval_q;
	reg [63:0] utval_d;
	reg [63:0] uip_q;
	reg [63:0] uip_d;
	reg [63:0] dpc_q;
	reg [63:0] dpc_d;
	reg [63:0] dscratch0_q;
	reg [63:0] dscratch0_d;
	reg [63:0] dscratch1_q;
	reg [63:0] dscratch1_d;
	reg [63:0] mtvec_q;
	reg [63:0] mtvec_d;
	reg [63:0] medeleg_q;
	reg [63:0] medeleg_d;
	reg [63:0] mideleg_q;
	reg [63:0] mideleg_d;
	reg [63:0] mip_q;
	reg [63:0] mip_d;
	reg [63:0] mie_q;
	reg [63:0] mie_d;
	reg [63:0] mcounteren_q;
	reg [63:0] mcounteren_d;
	reg [63:0] mscratch_q;
	reg [63:0] mscratch_d;
	reg [63:0] mepc_q;
	reg [63:0] mepc_d;
	reg [63:0] mcause_q;
	reg [63:0] mcause_d;
	reg [63:0] mtval_q;
	reg [63:0] mtval_d;
	reg [63:0] stvec_q;
	reg [63:0] stvec_d;
	reg [63:0] scounteren_q;
	reg [63:0] scounteren_d;
	reg [63:0] sscratch_q;
	reg [63:0] sscratch_d;
	reg [63:0] sepc_q;
	reg [63:0] sepc_d;
	reg [63:0] scause_q;
	reg [63:0] scause_d;
	reg [63:0] stval_q;
	reg [63:0] stval_d;
	reg [63:0] dcache_q;
	reg [63:0] dcache_d;
	reg [63:0] icache_q;
	reg [63:0] icache_d;
	reg wfi_d;
	reg wfi_q;
	reg [63:0] cycle_q;
	reg [63:0] cycle_d;
	reg [63:0] instret_q;
	reg [63:0] instret_d;
	reg [127:0] pmpcfg_q;
	reg [127:0] pmpcfg_d;
	reg [863:0] pmpaddr_q;
	reg [863:0] pmpaddr_d;
	wire [63:0] uscratch_o;
	assign pmpcfg_o = pmpcfg_q[8 * ((NrPMPEntries - 1) - (NrPMPEntries - 1))+:8 * NrPMPEntries];
	assign pmpaddr_o = pmpaddr_q;
	assign we_flag_0_o = uscratch_o[7:0] == 8'hea;
	reg [31:0] fcsr_q;
	reg [31:0] fcsr_d;
	assign csr_addr = csr_addr_i;
	assign fs_o = mstatus_q[14-:2];
	assign uscratch_o = uscratch_q;
	assign uie_o = uie_q;
	assign utvec_o = utvec_q;
	assign utval_o = utval_q;
	assign uip_o = uip_q;
	localparam [63:0] ariane_pkg_ARIANE_MARCHID = 64'd3;
	localparam [0:0] ariane_pkg_XF16 = 1'b0;
	localparam [0:0] ariane_pkg_XF16ALT = 1'b0;
	localparam [0:0] ariane_pkg_XF8 = 1'b0;
	localparam [0:0] ariane_pkg_XFVEC = 1'b0;
	localparam [0:0] ariane_pkg_NSX = ((ariane_pkg_XF16 | ariane_pkg_XF16ALT) | ariane_pkg_XF8) | ariane_pkg_XFVEC;
	localparam [0:0] ariane_pkg_RVA = 1'b1;
	localparam [0:0] ariane_pkg_RVD = 1'b1;
	localparam [0:0] ariane_pkg_RVF = 1'b1;
	localparam [63:0] ariane_pkg_ISA_CODE = ((((((((((ariane_pkg_RVA << 0) | 4) | (ariane_pkg_RVD << 3)) | (ariane_pkg_RVF << 5)) | 256) | 4096) | 0) | 262144) | 1048576) | (ariane_pkg_NSX << 23)) | 65'sd9223372036854775808;
	localparam [63:0] riscv_SSTATUS64_SD = 64'h8000000000000000;
	localparam [63:0] riscv_SSTATUS_FS = 64'h0000000000006000;
	localparam [63:0] riscv_SSTATUS_MXR = 64'h0000000000080000;
	localparam [63:0] riscv_SSTATUS_SIE = 64'h0000000000000002;
	localparam [63:0] riscv_SSTATUS_SPIE = 64'h0000000000000020;
	localparam [63:0] riscv_SSTATUS_SPP = 64'h0000000000000100;
	localparam [63:0] riscv_SSTATUS_SUM = 64'h0000000000040000;
	localparam [63:0] riscv_SSTATUS_UIE = 64'h0000000000000001;
	localparam [63:0] riscv_SSTATUS_UPIE = 64'h0000000000000010;
	localparam [63:0] riscv_SSTATUS_UXL = 64'h0000000300000000;
	localparam [63:0] riscv_SSTATUS_XS = 64'h0000000000018000;
	localparam [63:0] ariane_pkg_SMODE_STATUS_READ_MASK = ((((((((((riscv_SSTATUS_UIE | riscv_SSTATUS_SIE) | riscv_SSTATUS_SPIE) | riscv_SSTATUS_SPP) | riscv_SSTATUS_FS) | riscv_SSTATUS_XS) | riscv_SSTATUS_SUM) | riscv_SSTATUS_MXR) | riscv_SSTATUS_UPIE) | riscv_SSTATUS_SPIE) | riscv_SSTATUS_UXL) | riscv_SSTATUS64_SD;
	always @(*) begin : csr_read_process
		if (_sv2v_0)
			;
		read_access_exception = 1'b0;
		csr_rdata = 64'b0000000000000000000000000000000000000000000000000000000000000000;
		perf_addr_o = csr_addr[4:0];
		if (csr_read)
			(* full_case, parallel_case *)
			case (csr_addr[11-:12])
				12'h001:
					if (mstatus_q[14-:2] == 2'b00)
						read_access_exception = 1'b1;
					else
						csr_rdata = {59'b00000000000000000000000000000000000000000000000000000000000, fcsr_q[4-:5]};
				12'h002:
					if (mstatus_q[14-:2] == 2'b00)
						read_access_exception = 1'b1;
					else
						csr_rdata = {61'b0000000000000000000000000000000000000000000000000000000000000, fcsr_q[7-:3]};
				12'h003:
					if (mstatus_q[14-:2] == 2'b00)
						read_access_exception = 1'b1;
					else
						csr_rdata = {56'b00000000000000000000000000000000000000000000000000000000, fcsr_q[7-:3], fcsr_q[4-:5]};
				12'h800:
					if (mstatus_q[14-:2] == 2'b00)
						read_access_exception = 1'b1;
					else
						csr_rdata = {57'b000000000000000000000000000000000000000000000000000000000, fcsr_q[14-:7]};
				12'h7b0: csr_rdata = {32'b00000000000000000000000000000000, dcsr_q};
				12'h7b1: csr_rdata = dpc_q;
				12'h7b2: csr_rdata = dscratch0_q;
				12'h7b3: csr_rdata = dscratch1_q;
				12'h7a0:
					;
				12'h7a1:
					;
				12'h7a2:
					;
				12'h7a3:
					;
				12'h040: csr_rdata = uscratch_q;
				12'h004: csr_rdata = uie_q;
				12'h005: csr_rdata = utvec_q;
				12'h043: csr_rdata = utval_q;
				12'h044: csr_rdata = uip_q;
				12'h100: csr_rdata = mstatus_q & ariane_pkg_SMODE_STATUS_READ_MASK;
				12'h104: csr_rdata = mie_q & mideleg_q;
				12'h144: csr_rdata = mip_q & mideleg_q;
				12'h105: csr_rdata = stvec_q;
				12'h106: csr_rdata = scounteren_q;
				12'h140: csr_rdata = sscratch_q;
				12'h141: csr_rdata = sepc_q;
				12'h142: csr_rdata = scause_q;
				12'h143: csr_rdata = stval_q;
				12'h180:
					if ((priv_lvl_o == 2'b01) && mstatus_q[20])
						read_access_exception = 1'b1;
					else
						csr_rdata = satp_q;
				12'h300: csr_rdata = mstatus_q;
				12'h301: csr_rdata = ariane_pkg_ISA_CODE;
				12'h302: csr_rdata = medeleg_q;
				12'h303: csr_rdata = mideleg_q;
				12'h304: csr_rdata = mie_q;
				12'h305: csr_rdata = mtvec_q;
				12'h306: csr_rdata = mcounteren_q;
				12'h340: csr_rdata = mscratch_q;
				12'h341: csr_rdata = mepc_q;
				12'h342: csr_rdata = mcause_q;
				12'h343: csr_rdata = mtval_q;
				12'h344: csr_rdata = mip_q;
				12'hf11: csr_rdata = 64'b0000000000000000000000000000000000000000000000000000000000000000;
				12'hf12: csr_rdata = ariane_pkg_ARIANE_MARCHID;
				12'hf13: csr_rdata = 64'b0000000000000000000000000000000000000000000000000000000000000000;
				12'hf14: csr_rdata = hart_id_i;
				12'hb00: csr_rdata = cycle_q;
				12'hb02: csr_rdata = instret_q;
				12'hc00: csr_rdata = cycle_q;
				12'hc02: csr_rdata = instret_q;
				12'hb03, 12'hb04, 12'hb05, 12'hb06, 12'hb07, 12'hb08, 12'hb09, 12'hb0a, 12'hb0b, 12'hb0c, 12'hb0d, 12'hb0e, 12'hb0f, 12'hb10, 12'hb11, 12'hb12, 12'hb13, 12'hb14, 12'hb15, 12'hb16, 12'hb17, 12'hb18, 12'hb19, 12'hb1a, 12'hb1b, 12'hb1c, 12'hb1d, 12'hb1e, 12'hb1f: csr_rdata = perf_data_i;
				12'h701: csr_rdata = dcache_q;
				12'h700: csr_rdata = icache_q;
				12'h3a0: csr_rdata = pmpcfg_q[0+:64];
				12'h3a2: csr_rdata = pmpcfg_q[64+:64];
				12'h3b0: csr_rdata = {10'b0000000000, pmpaddr_q[53-:53], (pmpcfg_q[4] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3b1: csr_rdata = {10'b0000000000, pmpaddr_q[107-:53], (pmpcfg_q[12] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3b2: csr_rdata = {10'b0000000000, pmpaddr_q[161-:53], (pmpcfg_q[20] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3b3: csr_rdata = {10'b0000000000, pmpaddr_q[215-:53], (pmpcfg_q[28] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3b4: csr_rdata = {10'b0000000000, pmpaddr_q[269-:53], (pmpcfg_q[36] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3b5: csr_rdata = {10'b0000000000, pmpaddr_q[323-:53], (pmpcfg_q[44] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3b6: csr_rdata = {10'b0000000000, pmpaddr_q[377-:53], (pmpcfg_q[52] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3b7: csr_rdata = {10'b0000000000, pmpaddr_q[431-:53], (pmpcfg_q[60] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3b8: csr_rdata = {10'b0000000000, pmpaddr_q[485-:53], (pmpcfg_q[68] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3b9: csr_rdata = {10'b0000000000, pmpaddr_q[539-:53], (pmpcfg_q[76] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3ba: csr_rdata = {10'b0000000000, pmpaddr_q[593-:53], (pmpcfg_q[84] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3bb: csr_rdata = {10'b0000000000, pmpaddr_q[647-:53], (pmpcfg_q[92] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3bc: csr_rdata = {10'b0000000000, pmpaddr_q[701-:53], (pmpcfg_q[100] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3bd: csr_rdata = {10'b0000000000, pmpaddr_q[755-:53], (pmpcfg_q[108] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3be: csr_rdata = {10'b0000000000, pmpaddr_q[809-:53], (pmpcfg_q[116] == 1'b1 ? 1'b1 : 1'b0)};
				12'h3bf: csr_rdata = {10'b0000000000, pmpaddr_q[863-:53], (pmpcfg_q[124] == 1'b1 ? 1'b1 : 1'b0)};
				default: read_access_exception = 1'b1;
			endcase
	end
	reg [63:0] mask;
	localparam [0:0] ariane_pkg_ENABLE_CYCLE_COUNT = 1'b1;
	localparam [0:0] ariane_pkg_FP_PRESENT = (((ariane_pkg_RVF | ariane_pkg_RVD) | ariane_pkg_XF16) | ariane_pkg_XF16ALT) | ariane_pkg_XF8;
	localparam [3:0] ariane_pkg_MODE_OFF = 4'h0;
	localparam [3:0] ariane_pkg_MODE_SV39 = 4'h8;
	localparam [63:0] ariane_pkg_SMODE_STATUS_WRITE_MASK = ((((riscv_SSTATUS_SIE | riscv_SSTATUS_SPIE) | riscv_SSTATUS_SPP) | riscv_SSTATUS_FS) | riscv_SSTATUS_SUM) | riscv_SSTATUS_MXR;
	localparam [0:0] ariane_pkg_ZERO_TVAL = 1'b0;
	localparam [2:0] dm_CauseBreakpoint = 3'h1;
	localparam [2:0] dm_CauseRequest = 3'h3;
	localparam [2:0] dm_CauseSingleStep = 3'h4;
	localparam [63:0] riscv_BREAKPOINT = 3;
	localparam [63:0] riscv_DEBUG_REQUEST = 24;
	localparam [63:0] riscv_ENV_CALL_MMODE = 11;
	localparam [63:0] riscv_ENV_CALL_SMODE = 9;
	localparam [63:0] riscv_ENV_CALL_UMODE = 8;
	localparam [63:0] riscv_ILLEGAL_INSTR = 2;
	localparam [63:0] riscv_INSTR_ADDR_MISALIGNED = 0;
	localparam [63:0] riscv_INSTR_PAGE_FAULT = 12;
	localparam [31:0] riscv_IRQ_M_EXT = 11;
	localparam [31:0] riscv_IRQ_M_SOFT = 3;
	localparam [31:0] riscv_IRQ_M_TIMER = 7;
	localparam [63:0] riscv_LOAD_PAGE_FAULT = 13;
	localparam [63:0] riscv_MIP_MEIP = 2048;
	localparam [63:0] riscv_MIP_MSIP = 8;
	localparam [63:0] riscv_MIP_MTIP = 128;
	localparam [31:0] riscv_IRQ_S_EXT = 9;
	localparam [63:0] riscv_MIP_SEIP = 512;
	localparam [31:0] riscv_IRQ_S_SOFT = 1;
	localparam [63:0] riscv_MIP_SSIP = 2;
	localparam [31:0] riscv_IRQ_S_TIMER = 5;
	localparam [63:0] riscv_MIP_STIP = 32;
	localparam [63:0] riscv_STORE_PAGE_FAULT = 15;
	always @(*) begin : csr_update
		reg [63:0] sapt;
		reg [63:0] instret;
		if (_sv2v_0)
			;
		sapt = satp_q;
		instret = instret_q;
		cycle_d = cycle_q;
		instret_d = instret_q;
		if (!debug_mode_q) begin
			begin : sv2v_autoblock_1
				reg signed [31:0] i;
				for (i = 0; i < NrCommitPorts; i = i + 1)
					if (commit_ack_i[i] && !ex_i[0])
						instret = instret + 1;
			end
			instret_d = instret;
			if (ariane_pkg_ENABLE_CYCLE_COUNT)
				cycle_d = cycle_q + 1'b1;
			else
				cycle_d = instret;
		end
		eret_o = 1'b0;
		flush_o = 1'b0;
		update_access_exception = 1'b0;
		set_debug_pc_o = 1'b0;
		perf_we_o = 1'b0;
		perf_data_o = 'b0;
		fcsr_d = fcsr_q;
		priv_lvl_d = priv_lvl_q;
		debug_mode_d = debug_mode_q;
		dcsr_d = dcsr_q;
		dpc_d = dpc_q;
		dscratch0_d = dscratch0_q;
		dscratch1_d = dscratch1_q;
		mstatus_d = mstatus_q;
		if (mtvec_rst_load_q)
			mtvec_d = boot_addr_i + 'h40;
		else
			mtvec_d = mtvec_q;
		medeleg_d = medeleg_q;
		mideleg_d = mideleg_q;
		mip_d = mip_q;
		mie_d = mie_q;
		mepc_d = mepc_q;
		mcause_d = mcause_q;
		mcounteren_d = mcounteren_q;
		mscratch_d = mscratch_q;
		mtval_d = mtval_q;
		dcache_d = dcache_q;
		icache_d = icache_q;
		sepc_d = sepc_q;
		scause_d = scause_q;
		stvec_d = stvec_q;
		scounteren_d = scounteren_q;
		sscratch_d = sscratch_q;
		stval_d = stval_q;
		satp_d = satp_q;
		uscratch_d = uscratch_q;
		uie_d = uie_q;
		utvec_d = utvec_q;
		utval_d = utval_q;
		uip_d = uip_q;
		en_ld_st_translation_d = en_ld_st_translation_q;
		dirty_fp_state_csr = 1'b0;
		pmpcfg_d = pmpcfg_q;
		pmpaddr_d = pmpaddr_q;
		if (csr_we)
			(* full_case, parallel_case *)
			case (csr_addr[11-:12])
				12'h001:
					if (mstatus_q[14-:2] == 2'b00)
						update_access_exception = 1'b1;
					else begin
						dirty_fp_state_csr = 1'b1;
						fcsr_d[4-:5] = csr_wdata[4:0];
						flush_o = 1'b1;
					end
				12'h002:
					if (mstatus_q[14-:2] == 2'b00)
						update_access_exception = 1'b1;
					else begin
						dirty_fp_state_csr = 1'b1;
						fcsr_d[7-:3] = csr_wdata[2:0];
						flush_o = 1'b1;
					end
				12'h003:
					if (mstatus_q[14-:2] == 2'b00)
						update_access_exception = 1'b1;
					else begin
						dirty_fp_state_csr = 1'b1;
						fcsr_d[7:0] = csr_wdata[7:0];
						flush_o = 1'b1;
					end
				12'h800:
					if (mstatus_q[14-:2] == 2'b00)
						update_access_exception = 1'b1;
					else begin
						dirty_fp_state_csr = 1'b1;
						fcsr_d[14-:7] = csr_wdata[6:0];
						flush_o = 1'b1;
					end
				12'h7b0: begin
					dcsr_d = csr_wdata[31:0];
					dcsr_d[31-:4] = 4'h4;
					dcsr_d[1-:2] = priv_lvl_q;
					dcsr_d[3] = 1'b0;
					dcsr_d[10] = 1'b0;
					dcsr_d[9] = 1'b0;
				end
				12'h040: uscratch_d = csr_wdata;
				12'h004: uie_d = csr_wdata;
				12'h005: utvec_d = csr_wdata;
				12'h043: utval_d = csr_wdata;
				12'h044: uip_d = csr_wdata;
				12'h7b1: dpc_d = csr_wdata;
				12'h7b2: dscratch0_d = csr_wdata;
				12'h7b3: dscratch1_d = csr_wdata;
				12'h7a0:
					;
				12'h7a1:
					;
				12'h7a2:
					;
				12'h7a3:
					;
				12'h100: begin
					mask = ariane_pkg_SMODE_STATUS_WRITE_MASK;
					mstatus_d = (mstatus_q & ~mask) | (csr_wdata & mask);
					if (!ariane_pkg_FP_PRESENT)
						mstatus_d[14-:2] = 2'b00;
					flush_o = 1'b1;
				end
				12'h104: mie_d = ((mie_q & ~mideleg_q) | (csr_wdata & mideleg_q)) | utval_q;
				12'h144: begin
					mask = riscv_MIP_SSIP & mideleg_q;
					mip_d = (mip_q & ~mask) | (csr_wdata & mask);
				end
				12'h105: stvec_d = {csr_wdata[63:2], 1'b0, csr_wdata[0]};
				12'h106: scounteren_d = {32'b00000000000000000000000000000000, csr_wdata[31:0]};
				12'h140: sscratch_d = csr_wdata;
				12'h141: sepc_d = {csr_wdata[63:1], 1'b0};
				12'h142: scause_d = csr_wdata;
				12'h143: stval_d = csr_wdata;
				12'h180: begin
					if ((priv_lvl_o == 2'b01) && mstatus_q[20])
						update_access_exception = 1'b1;
					else begin
						sapt = csr_wdata;
						sapt[59-:16] = sapt[59-:16] & {{16 - AsidWidth {1'b0}}, {AsidWidth {1'b1}}};
						if ((sapt[63-:4] == ariane_pkg_MODE_OFF) || (sapt[63-:4] == ariane_pkg_MODE_SV39))
							satp_d = sapt;
					end
					flush_o = 1'b1;
				end
				12'h300: begin
					mstatus_d = csr_wdata;
					mstatus_d[16-:2] = 2'b00;
					if (!ariane_pkg_FP_PRESENT)
						mstatus_d[14-:2] = 2'b00;
					mstatus_d[4] = 1'b0;
					mstatus_d[0] = 1'b0;
					flush_o = 1'b1;
				end
				12'h301:
					;
				12'h302: begin
					mask = 45321;
					medeleg_d = (medeleg_q & ~mask) | (csr_wdata & mask);
				end
				12'h303: begin
					mask = (riscv_MIP_SSIP | riscv_MIP_STIP) | riscv_MIP_SEIP;
					mideleg_d = (mideleg_q & ~mask) | (csr_wdata & mask);
				end
				12'h304: begin
					mask = ((((riscv_MIP_SSIP | riscv_MIP_STIP) | riscv_MIP_SEIP) | riscv_MIP_MSIP) | riscv_MIP_MTIP) | riscv_MIP_MEIP;
					mie_d = (mie_q & ~mask) | (csr_wdata & mask);
				end
				12'h305: begin
					mtvec_d = {csr_wdata[63:2], 1'b0, csr_wdata[0]};
					if (csr_wdata[0])
						mtvec_d = {csr_wdata[63:8], 7'b0000000, csr_wdata[0]};
				end
				12'h306: mcounteren_d = {32'b00000000000000000000000000000000, csr_wdata[31:0]};
				12'h340: mscratch_d = csr_wdata;
				12'h341: mepc_d = {csr_wdata[63:1], 1'b0};
				12'h342: mcause_d = csr_wdata;
				12'h343: mtval_d = csr_wdata;
				12'h344: begin
					mask = (riscv_MIP_SSIP | riscv_MIP_STIP) | riscv_MIP_SEIP;
					mip_d = (mip_q & ~mask) | (csr_wdata & mask);
				end
				12'hb00: cycle_d = csr_wdata;
				12'hb02: instret = csr_wdata;
				12'hb03, 12'hb04, 12'hb05, 12'hb06, 12'hb07, 12'hb08, 12'hb09, 12'hb0a, 12'hb0b, 12'hb0c, 12'hb0d, 12'hb0e, 12'hb0f, 12'hb10, 12'hb11, 12'hb12, 12'hb13, 12'hb14, 12'hb15, 12'hb16, 12'hb17, 12'hb18, 12'hb19, 12'hb1a, 12'hb1b, 12'hb1c, 12'hb1d, 12'hb1e, 12'hb1f: begin
					perf_data_o = csr_wdata;
					perf_we_o = 1'b1;
				end
				12'h701: dcache_d = csr_wdata[0];
				12'h700: icache_d = csr_wdata[0];
				12'h3a0: begin : sv2v_autoblock_2
					reg signed [31:0] i;
					for (i = 0; i < 8; i = i + 1)
						if (!pmpcfg_q[(i * 8) + 7])
							pmpcfg_d[i * 8+:8] = csr_wdata[i * 8+:8];
				end
				12'h3a2: begin : sv2v_autoblock_3
					reg signed [31:0] i;
					for (i = 0; i < 8; i = i + 1)
						if (!pmpcfg_q[((i + 8) * 8) + 7])
							pmpcfg_d[(i + 8) * 8+:8] = csr_wdata[i * 8+:8];
				end
				12'h3b0:
					if (!pmpcfg_q[7] && !(pmpcfg_q[15] && (pmpcfg_q[12-:2] == 2'b01)))
						pmpaddr_d[0+:54] = csr_wdata[53:0];
				12'h3b1:
					if (!pmpcfg_q[15] && !(pmpcfg_q[23] && (pmpcfg_q[20-:2] == 2'b01)))
						pmpaddr_d[54+:54] = csr_wdata[53:0];
				12'h3b2:
					if (!pmpcfg_q[23] && !(pmpcfg_q[31] && (pmpcfg_q[28-:2] == 2'b01)))
						pmpaddr_d[108+:54] = csr_wdata[53:0];
				12'h3b3:
					if (!pmpcfg_q[31] && !(pmpcfg_q[39] && (pmpcfg_q[36-:2] == 2'b01)))
						pmpaddr_d[162+:54] = csr_wdata[53:0];
				12'h3b4:
					if (!pmpcfg_q[39] && !(pmpcfg_q[47] && (pmpcfg_q[44-:2] == 2'b01)))
						pmpaddr_d[216+:54] = csr_wdata[53:0];
				12'h3b5:
					if (!pmpcfg_q[47] && !(pmpcfg_q[55] && (pmpcfg_q[52-:2] == 2'b01)))
						pmpaddr_d[270+:54] = csr_wdata[53:0];
				12'h3b6:
					if (!pmpcfg_q[55] && !(pmpcfg_q[63] && (pmpcfg_q[60-:2] == 2'b01)))
						pmpaddr_d[324+:54] = csr_wdata[53:0];
				12'h3b7:
					if (!pmpcfg_q[63] && !(pmpcfg_q[71] && (pmpcfg_q[68-:2] == 2'b01)))
						pmpaddr_d[378+:54] = csr_wdata[53:0];
				12'h3b8:
					if (!pmpcfg_q[71] && !(pmpcfg_q[79] && (pmpcfg_q[76-:2] == 2'b01)))
						pmpaddr_d[432+:54] = csr_wdata[53:0];
				12'h3b9:
					if (!pmpcfg_q[79] && !(pmpcfg_q[87] && (pmpcfg_q[84-:2] == 2'b01)))
						pmpaddr_d[486+:54] = csr_wdata[53:0];
				12'h3ba:
					if (!pmpcfg_q[87] && !(pmpcfg_q[95] && (pmpcfg_q[92-:2] == 2'b01)))
						pmpaddr_d[540+:54] = csr_wdata[53:0];
				12'h3bb:
					if (!pmpcfg_q[95] && !(pmpcfg_q[103] && (pmpcfg_q[100-:2] == 2'b01)))
						pmpaddr_d[594+:54] = csr_wdata[53:0];
				12'h3bc:
					if (!pmpcfg_q[103] && !(pmpcfg_q[111] && (pmpcfg_q[108-:2] == 2'b01)))
						pmpaddr_d[648+:54] = csr_wdata[53:0];
				12'h3bd:
					if (!pmpcfg_q[111] && !(pmpcfg_q[119] && (pmpcfg_q[116-:2] == 2'b01)))
						pmpaddr_d[702+:54] = csr_wdata[53:0];
				12'h3be:
					if (!pmpcfg_q[119] && !(pmpcfg_q[127] && (pmpcfg_q[124-:2] == 2'b01)))
						pmpaddr_d[756+:54] = csr_wdata[53:0];
				12'h3bf:
					if (!pmpcfg_q[127])
						pmpaddr_d[810+:54] = csr_wdata[53:0];
				default: update_access_exception = 1'b1;
			endcase
		mstatus_d[35-:2] = 2'b10;
		mstatus_d[33-:2] = 2'b10;
		if (ariane_pkg_FP_PRESENT && (dirty_fp_state_csr || dirty_fp_state_i))
			mstatus_d[14-:2] = 2'b11;
		mstatus_d[63] = (mstatus_q[16-:2] == 2'b11) | (mstatus_q[14-:2] == 2'b11);
		if (csr_write_fflags_i)
			fcsr_d[4-:5] = csr_wdata_i[4:0] | fcsr_q[4-:5];
		mip_d[riscv_IRQ_M_EXT] = irq_i[0];
		mip_d[riscv_IRQ_M_SOFT] = ipi_i;
		mip_d[riscv_IRQ_M_TIMER] = time_irq_i;
		trap_to_priv_lvl = 2'b11;
		if ((!debug_mode_q && (ex_i[128-:64] != riscv_DEBUG_REQUEST)) && ex_i[0]) begin
			flush_o = 1'b0;
			if ((ex_i[128] && mideleg_q[ex_i[70:65]]) || (~ex_i[128] && medeleg_q[ex_i[70:65]]))
				trap_to_priv_lvl = (priv_lvl_o == 2'b11 ? 2'b11 : 2'b01);
			if (trap_to_priv_lvl == 2'b01) begin
				mstatus_d[1] = 1'b0;
				mstatus_d[5] = mstatus_q[1];
				mstatus_d[8] = priv_lvl_q[0];
				scause_d = ex_i[128-:64];
				sepc_d = {pc_i};
				stval_d = ex_i[64-:64];
			end
			else begin
				mstatus_d[3] = 1'b0;
				mstatus_d[7] = mstatus_q[3];
				mstatus_d[12-:2] = priv_lvl_q;
				mcause_d = ex_i[128-:64];
				mepc_d = {pc_i};
				mtval_d = ex_i[64-:64];
			end
			priv_lvl_d = trap_to_priv_lvl;
		end
		if (!debug_mode_q) begin
			dcsr_d[1-:2] = priv_lvl_o;
			if (ex_i[0] && (ex_i[128-:64] == riscv_BREAKPOINT)) begin
				(* full_case, parallel_case *)
				case (priv_lvl_o)
					2'b11: begin
						debug_mode_d = dcsr_q[15];
						set_debug_pc_o = dcsr_q[15];
					end
					2'b01: begin
						debug_mode_d = dcsr_q[13];
						set_debug_pc_o = dcsr_q[13];
					end
					2'b00: begin
						debug_mode_d = dcsr_q[12];
						set_debug_pc_o = dcsr_q[12];
					end
					default:
						;
				endcase
				dpc_d = {pc_i};
				dcsr_d[8-:3] = dm_CauseBreakpoint;
			end
			if (ex_i[0] && (ex_i[128-:64] == riscv_DEBUG_REQUEST)) begin
				dpc_d = {pc_i};
				debug_mode_d = 1'b1;
				set_debug_pc_o = 1'b1;
				dcsr_d[8-:3] = dm_CauseRequest;
			end
			if (dcsr_q[2] && commit_ack_i[0]) begin
				if (commit_instr_i[293-:4] == 4'd4)
					dpc_d = {commit_instr_i[64-:riscv_VLEN]};
				else if (ex_i[0])
					dpc_d = {trap_vector_base_o};
				else if (eret_o)
					dpc_d = {epc_o};
				else
					dpc_d = {commit_instr_i[360-:64] + (commit_instr_i[0] ? 'h2 : 'h4)};
				debug_mode_d = 1'b1;
				set_debug_pc_o = 1'b1;
				dcsr_d[8-:3] = dm_CauseSingleStep;
			end
		end
		if ((debug_mode_q && ex_i[0]) && (ex_i[128-:64] == riscv_BREAKPOINT))
			set_debug_pc_o = 1'b1;
		if ((mprv && (satp_q[63-:4] == ariane_pkg_MODE_SV39)) && (mstatus_q[12-:2] != 2'b11))
			en_ld_st_translation_d = 1'b1;
		else
			en_ld_st_translation_d = en_translation_o;
		ld_st_priv_lvl_o = (mprv ? mstatus_q[12-:2] : priv_lvl_o);
		en_ld_st_translation_o = en_ld_st_translation_q;
		if (mret) begin
			eret_o = 1'b1;
			mstatus_d[3] = mstatus_q[7];
			priv_lvl_d = mstatus_q[12-:2];
			mstatus_d[12-:2] = 2'b00;
			mstatus_d[7] = 1'b1;
		end
		if (sret) begin
			eret_o = 1'b1;
			mstatus_d[1] = mstatus_q[5];
			priv_lvl_d = ({1'b0, mstatus_q[8]});
			mstatus_d[8] = 1'b0;
			mstatus_d[5] = 1'b1;
		end
		if (dret) begin
			eret_o = 1'b1;
			priv_lvl_d = (dcsr_q[1-:2]);
			debug_mode_d = 1'b0;
		end
	end
	always @(*) begin : csr_op_logic
		if (_sv2v_0)
			;
		csr_wdata = csr_wdata_i;
		csr_we = 1'b1;
		csr_read = 1'b1;
		mret = 1'b0;
		sret = 1'b0;
		dret = 1'b0;
		(* full_case, parallel_case *)
		case (csr_op_i)
			7'd31: csr_wdata = csr_wdata_i;
			7'd33: csr_wdata = csr_wdata_i | csr_rdata;
			7'd34: csr_wdata = ~csr_wdata_i & csr_rdata;
			7'd32: csr_we = 1'b0;
			7'd24: begin
				csr_we = 1'b0;
				csr_read = 1'b0;
				sret = 1'b1;
			end
			7'd23: begin
				csr_we = 1'b0;
				csr_read = 1'b0;
				mret = 1'b1;
			end
			7'd25: begin
				csr_we = 1'b0;
				csr_read = 1'b0;
				dret = 1'b1;
			end
			default: begin
				csr_we = 1'b0;
				csr_read = 1'b0;
			end
		endcase
		if (privilege_violation) begin
			csr_we = 1'b0;
			csr_read = 1'b0;
		end
	end
	assign irq_ctrl_o[193-:64] = mie_q;
	assign irq_ctrl_o[129-:64] = mip_q;
	assign irq_ctrl_o[1] = mstatus_q[1];
	assign irq_ctrl_o[65-:64] = mideleg_q;
	assign irq_ctrl_o[0] = (~debug_mode_q & (~dcsr_q[2] | dcsr_q[11])) & ((mstatus_q[3] & (priv_lvl_o == 2'b11)) | (priv_lvl_o != 2'b11));
	always @(*) begin : privilege_check
		if (_sv2v_0)
			;
		privilege_violation = 1'b0;
		if (|{csr_op_i == 7'd31, csr_op_i == 7'd33, csr_op_i == 7'd34, csr_op_i == 7'd32}) begin
			if (((priv_lvl_o & csr_addr[9-:2]) != csr_addr[9-:2]) && (csr_addr[11-:12] != 12'h342))
				privilege_violation = 1'b1;
			if ((csr_addr_i[11:4] == 8'h7b) && !debug_mode_q)
				privilege_violation = 1'b1;
			if ((12'hc00 <= csr_addr_i) && (12'hc1f >= csr_addr_i))
				(* full_case, parallel_case *)
				case (csr_addr[9-:2])
					2'b11: privilege_violation = 1'b0;
					2'b01: privilege_violation = ~mcounteren_q[csr_addr_i[4:0]];
					2'b00: privilege_violation = ~mcounteren_q[csr_addr_i[4:0]] & ~scounteren_q[csr_addr_i[4:0]];
				endcase
		end
	end
	always @(*) begin : exception_ctrl
		if (_sv2v_0)
			;
		csr_exception_o = 129'b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
		if (update_access_exception || read_access_exception) begin
			csr_exception_o[128-:64] = riscv_ILLEGAL_INSTR;
			csr_exception_o[0] = 1'b1;
		end
		if (privilege_violation) begin
			csr_exception_o[128-:64] = riscv_ILLEGAL_INSTR;
			csr_exception_o[0] = 1'b1;
		end
	end
	always @(*) begin : wfi_ctrl
		if (_sv2v_0)
			;
		wfi_d = wfi_q;
		if ((|mip_q || debug_req_i) || irq_i[1])
			wfi_d = 1'b0;
		else if ((!debug_mode_q && (csr_op_i == 7'd27)) && !ex_i[0])
			wfi_d = 1'b1;
	end
	localparam [63:0] dm_HaltAddress = 64'h0000000000000800;
	localparam [63:0] dm_ExceptionAddress = 2056;
	always @(*) begin : priv_output
		if (_sv2v_0)
			;
		trap_vector_base_o = {mtvec_q[63:2], 2'b00};
		if (trap_to_priv_lvl == 2'b01)
			trap_vector_base_o = {stvec_q[63:2], 2'b00};
		if (debug_mode_q)
			trap_vector_base_o = DmBaseAddress[63:0] + dm_ExceptionAddress[63:0];
		if ((mtvec_q[0] || stvec_q[0]) && ex_i[128])
			trap_vector_base_o[7:2] = ex_i[70:65];
		epc_o = mepc_q[63:0];
		if (sret)
			epc_o = sepc_q[63:0];
		if (dret)
			epc_o = dpc_q[63:0];
	end
	always @(*) begin
		if (_sv2v_0)
			;
		csr_rdata_o = csr_rdata;
		(* full_case, parallel_case *)
		case (csr_addr[11-:12])
			12'h344: csr_rdata_o = csr_rdata | (irq_i[1] << riscv_IRQ_S_EXT);
			12'h144: csr_rdata_o = csr_rdata | ((irq_i[1] & mideleg_q[riscv_IRQ_S_EXT]) << riscv_IRQ_S_EXT);
			default:
				;
		endcase
	end
	assign priv_lvl_o = (debug_mode_q ? 2'b11 : priv_lvl_q);
	assign fflags_o = fcsr_q[4-:5];
	assign frm_o = fcsr_q[7-:3];
	assign fprec_o = fcsr_q[14-:7];
	assign satp_ppn_o = satp_q[43-:44];
	assign asid_o = satp_q[43 + AsidWidth:44];
	assign sum_o = mstatus_q[18];
	assign en_translation_o = ((satp_q[63-:4] == 4'h8) && (priv_lvl_o != 2'b11) ? 1'b1 : 1'b0);
	assign mxr_o = mstatus_q[19];
	assign tvm_o = mstatus_q[20];
	assign tw_o = mstatus_q[21];
	assign tsr_o = mstatus_q[22];
	assign halt_csr_o = wfi_q;
	assign icache_en_o = icache_q[0] & ~debug_mode_q;
	assign dcache_en_o = dcache_q[0];
	assign mprv = (debug_mode_q && !dcsr_q[4] ? 1'b0 : mstatus_q[17]);
	assign debug_mode_o = debug_mode_q;
	assign single_step_o = dcsr_q[2];
	always @(posedge clk_i or negedge rst_ni)
		if (~rst_ni) begin
			priv_lvl_q <= 2'b11;
			fcsr_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			debug_mode_q <= 1'b0;
			dcsr_q <= 1'sb0;
			dcsr_q[1-:2] <= 2'b11;
			uscratch_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			uie_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			utvec_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			utval_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			uip_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			dpc_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			dscratch0_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			dscratch1_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			mstatus_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			mtvec_rst_load_q <= 1'b1;
			mtvec_q <= 1'sb0;
			medeleg_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			mideleg_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			mip_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			mie_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			mepc_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			mcause_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			mcounteren_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			mscratch_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			mtval_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			dcache_q <= 64'b0000000000000000000000000000000000000000000000000000000000000001;
			icache_q <= 64'b0000000000000000000000000000000000000000000000000000000000000001;
			sepc_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			scause_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			stvec_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			scounteren_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			sscratch_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			stval_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			satp_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			cycle_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			instret_q <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
			en_ld_st_translation_q <= 1'b0;
			wfi_q <= 1'b0;
			pmpcfg_q <= 1'sb0;
			pmpaddr_q <= 1'sb0;
		end
		else begin
			priv_lvl_q <= priv_lvl_d;
			fcsr_q <= fcsr_d;
			debug_mode_q <= debug_mode_d;
			dcsr_q <= dcsr_d;
			uscratch_q <= uscratch_d;
			uie_q <= uie_d;
			utvec_q <= utvec_d;
			utval_q <= utval_d;
			uip_q <= uip_d;
			dpc_q <= dpc_d;
			dscratch0_q <= dscratch0_d;
			dscratch1_q <= dscratch1_d;
			mstatus_q <= mstatus_d;
			mtvec_rst_load_q <= 1'b0;
			mtvec_q <= mtvec_d;
			medeleg_q <= medeleg_d;
			mideleg_q <= mideleg_d;
			mip_q <= mip_d;
			mie_q <= mie_d;
			mepc_q <= mepc_d;
			mcause_q <= mcause_d;
			mcounteren_q <= mcounteren_d;
			mscratch_q <= mscratch_d;
			mtval_q <= mtval_d;
			dcache_q <= dcache_d;
			icache_q <= icache_d;
			sepc_q <= sepc_d;
			scause_q <= scause_d;
			stvec_q <= stvec_d;
			scounteren_q <= scounteren_d;
			sscratch_q <= sscratch_d;
			stval_q <= stval_d;
			satp_q <= satp_d;
			cycle_q <= cycle_d;
			instret_q <= instret_d;
			en_ld_st_translation_q <= en_ld_st_translation_d;
			wfi_q <= wfi_d;
			if (NrPMPEntries > 0) begin
				pmpcfg_q[8 * ((NrPMPEntries - 1) - (NrPMPEntries - 1))+:8 * NrPMPEntries] <= pmpcfg_d[8 * ((NrPMPEntries - 1) - (NrPMPEntries - 1))+:8 * NrPMPEntries];
				pmpaddr_q[54 * ((NrPMPEntries - 1) - (NrPMPEntries - 1))+:54 * NrPMPEntries] <= pmpaddr_d[54 * ((NrPMPEntries - 1) - (NrPMPEntries - 1))+:54 * NrPMPEntries];
			end
			else begin
				pmpcfg_q <= 1'sb0;
				pmpaddr_q <= 1'sb0;
			end
		end
	initial _sv2v_0 = 0;
endmodule