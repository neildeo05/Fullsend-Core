.PHONY: core
core: 
	verilator -I../src/ -Wall -Wno-fatal --trace --cc --exe --build IMemTest.cpp IMem.sv
	./obj_dir/VIMem
