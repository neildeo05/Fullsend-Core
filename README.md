# Fullsend - A RISC-V Core


# Features

1. Implements RV32IMF
2. Pipelined
3. Built initially w/ chipyard, and then moved out to Orchestra
  - This means no memory subsystem (in the beginning). But when we move to orchestra, create a memory subsystem
4. Potentially OoO and Superscalar (because more instructions the better honestly)


# Future Features

1. Vector unit that implements V extension
2. Superscalar (dual-issue)
3. Speculative Execution


# Future FUTURE features
1. OoO execution
2. SoC integration
