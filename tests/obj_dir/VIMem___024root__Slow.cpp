// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VIMem.h for the primary calling header

#include "verilated.h"

#include "VIMem__Syms.h"
#include "VIMem__Syms.h"
#include "VIMem___024root.h"

void VIMem___024root___ctor_var_reset(VIMem___024root* vlSelf);

VIMem___024root::VIMem___024root(VIMem__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    VIMem___024root___ctor_var_reset(this);
}

void VIMem___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

VIMem___024root::~VIMem___024root() {
}
