.PHONY: top

top:
	verilator -I../src/ -Wall -Wno-fatal --trace --cc --exe --build Fullsend.cpp top.sv
	./obj_dir/Vtop
.PHONY: core

core:
	verilator -I../src/ -Wall -Wno-fatal --trace --cc --exe --build CoreTest.cpp Core.sv
	./obj_dir/VCore

.PHONY: regfile

regfile:
	verilator -I../src/ -Wall -Wno-fatal --trace --cc --exe --build RegfileTest.cpp Regfile.sv
	./obj_dir/VRegfile
.PHONY: datapath

datapath:
	verilator -I../src/ -Wall -Wno-fatal --trace --cc --exe --build DatapathTest.cpp Datapath.sv
	./obj_dir/VDatapath

.PHONY: stage1

stage1:
	verilator -I../src/ -Wall -Wno-fatal --trace --cc --exe --build Stage1Test.cpp Stage1.sv
	./obj_dir/VStage1


.PHONY: mem

mem:
	verilator -I../src/ -Wall -Wno-fatal --trace --cc --exe --build RAMTest.cpp Mem.sv
	./obj_dir/VMem



