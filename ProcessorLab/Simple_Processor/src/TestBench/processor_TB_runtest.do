SetActiveLib -work
comp -include "$dsn\src\half_adder.vhd" 
comp -include "$dsn\src\FullAdder.vhd" 
comp -include "$dsn\src\adder16.vhd" 
comp -include "$dsn\src\mux16.vhd" 
comp -include "$dsn\src\multiplier16.vhd" 
comp -include "$dsn\src\subtractor16.vhd" 
comp -include "$dsn\src\mux2.vhd" 
comp -include "$dsn\src\ram_256.vhd" 
comp -include "$dsn\src\ALU.vhd" 
comp -include "$dsn\src\register_file_16x8.vhd" 
comp -include "$dsn\src\instruction_decoder.vhd" 
comp -include "$dsn\src\processor.vhd" 
comp -include "$dsn\src\TestBench\processor_TB.vhd" 
asim +access +r TESTBENCH_FOR_processor 
wave 
wave -noreg instruction
wave -noreg clk
wave -noreg R0
wave -noreg R1
wave -noreg R2
wave -noreg R3
wave -noreg R4
wave -noreg R5
wave -noreg R6
wave -noreg R7
wave -noreg RA
wave -noreg RB
wave -noreg RC
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\processor_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_processor 
