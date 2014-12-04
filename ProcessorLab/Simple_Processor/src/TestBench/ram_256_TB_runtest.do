SetActiveLib -work
comp -include "$dsn\src\ram_256.vhd" 
comp -include "$dsn\src\TestBench\ram_256_TB.vhd" 
asim +access +r TESTBENCH_FOR_ram_256 
wave 
wave -noreg clock
wave -noreg rw
wave -noreg cs
wave -noreg address
wave -noreg DataIn
wave -noreg DataOut
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\ram_256_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_ram_256 
