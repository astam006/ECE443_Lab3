SetActiveLib -work
comp -include "$dsn\src\instruction_decoder.vhd" 
comp -include "$dsn\src\TestBench\inst_decoder_TB.vhd" 
asim +access +r TESTBENCH_FOR_inst_decoder 
wave 
wave -noreg instruction
wave -noreg A
wave -noreg B
wave -noreg D
wave -noreg V
wave -noreg aluSrc
wave -noreg regWrite
wave -noreg memToReg
wave -noreg cs
wave -noreg rw
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\inst_decoder_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_inst_decoder 
