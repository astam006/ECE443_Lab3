SetActiveLib -work
comp -include "$dsn\src\register_file_16x8.vhd" 
comp -include "$dsn\src\TestBench\register_file_16x8_TB.vhd" 
asim +access +r TESTBENCH_FOR_register_file_16x8 
wave 
wave -noreg RegWrite
wave -noreg Clk
wave -noreg WriteRegNum
wave -noreg WriteData
wave -noreg ReadRegNumA
wave -noreg ReadRegNumB
wave -noreg PortA
wave -noreg PortB
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\register_file_16x8_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_register_file_16x8 
