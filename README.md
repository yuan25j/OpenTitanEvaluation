# OpenTitanEvaluation

This paper presents the results of running symbolic
execution on an open-source hardware design, OpenPiton, and
reports its findings. Its hallmark is making use of a modern
symbolic execution tool, Sylvia, which uses piecewise composition
- allowing it to avoid exploring every path and allowing it to
reuse the exploration of independent modules or always-blocks in
the hardware design, improving overall efficiency. The benefit is
that this allows us to verify security of hardware design without
having to worry about the typical exhaustive enumeration of
state space that usually comes along as a downside when
making use of a symbolic execution machine. In this paper,
we apply Sylvia to OpenPiton’s csr_regfile, aes_192, and
dmi_jtag modules and check for violations against written set
of properties in SVA. The results presented in this paper suggests
that piecewise compositional symbolic execution is a powerful tool
for verification of hardware designs.