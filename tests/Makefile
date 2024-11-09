.PHONY: top

top:
	verilator -I../src/ -Wall -Wno-fatal --trace --cc --exe --build Fullsend.cpp top.sv
	./obj_dir/Vtop

bpfsm:
	verilator -I../src/ -Wall -Wno-fatal --trace --cc --exe --build BPFSM.cpp BranchPredictionFSM.sv
	./obj_dir/VBranchPredictionFSM
  
