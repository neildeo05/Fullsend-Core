// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VIMem.h for the primary calling header

#ifndef VERILATED_VIMEM___024ROOT_H_
#define VERILATED_VIMEM___024ROOT_H_  // guard

#include "verilated.h"


class VIMem__Syms;

class alignas(VL_CACHE_LINE_BYTES) VIMem___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(address,5,0);
    CData/*0:0*/ __VactContinue;
    VL_OUT(read_out,31,0);
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VicoIterCount;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<IData/*31:0*/, 129> IMem__DOT__imem;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<0> __VactTriggered;
    VlTriggerVec<0> __VnbaTriggered;

    // INTERNAL VARIABLES
    VIMem__Syms* const vlSymsp;

    // CONSTRUCTORS
    VIMem___024root(VIMem__Syms* symsp, const char* v__name);
    ~VIMem___024root();
    VL_UNCOPYABLE(VIMem___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
