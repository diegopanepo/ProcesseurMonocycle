vlib work

vcom -93 alu.vhd
vcom -93 banc_registr.vhd
vcom -93 multip2v1.vhd
vcom -93 ext_signe.vhd
vcom -93 data_memory.vhd
vcom -93 Unit_trait.vhd
vcom -93 pc.vhd
vcom -93 instruction_memory.vhd
vcom -93 Unit_gest.vhd
vcom -93 psr.vhd
vcom -93 decod.vhd
vcom -93 Unit_contr.vhd
vcom -93 Monocycle.vhd
vcom -93 Mono_testb.vhd

vsim -novopt Mono_testb(test_bench)

add wave clk rst PC
add wave \
MTB/MC1/UT1/Banc(2) \
MTB/MC1/UT1/Banc(1) \
MTB/MC1/UT1/Banc(0) \
MTB/MC1/UT5/mem(42) \
MTB/MC3/UC1/instr_courante
run -all