// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VIMem.h for the primary calling header

#include "verilated.h"

#include "VIMem__Syms.h"
#include "VIMem___024root.h"

VL_ATTR_COLD void VIMem___024root___eval_static(VIMem___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root___eval_static\n"); );
}

VL_ATTR_COLD void VIMem___024root___eval_initial__TOP(VIMem___024root* vlSelf);

VL_ATTR_COLD void VIMem___024root___eval_initial(VIMem___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root___eval_initial\n"); );
    // Body
    VIMem___024root___eval_initial__TOP(vlSelf);
}

VL_ATTR_COLD void VIMem___024root___eval_initial__TOP(VIMem___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root___eval_initial__TOP\n"); );
    // Init
    VlWide<5>/*159:0*/ __Vtemp_1;
    // Body
    __Vtemp_1[0U] = 0x2e686578U;
    __Vtemp_1[1U] = 0x6d61696eU;
    __Vtemp_1[2U] = 0x6172652fU;
    __Vtemp_1[3U] = 0x6f667477U;
    __Vtemp_1[4U] = 0x2e2e2f73U;
    VL_READMEM_N(true, 32, 129, 0, VL_CVT_PACK_STR_NW(5, __Vtemp_1)
                 ,  &(vlSelf->IMem__DOT__imem), 0, ~0ULL);
}

VL_ATTR_COLD void VIMem___024root___eval_final(VIMem___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root___eval_final\n"); );
}

VL_ATTR_COLD void VIMem___024root___eval_triggers__stl(VIMem___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void VIMem___024root___dump_triggers__stl(VIMem___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD void VIMem___024root___eval_stl(VIMem___024root* vlSelf);

VL_ATTR_COLD void VIMem___024root___eval_settle(VIMem___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root___eval_settle\n"); );
    // Init
    CData/*0:0*/ __VstlContinue;
    // Body
    vlSelf->__VstlIterCount = 0U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        __VstlContinue = 0U;
        VIMem___024root___eval_triggers__stl(vlSelf);
        if (vlSelf->__VstlTriggered.any()) {
            __VstlContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VstlIterCount))) {
#ifdef VL_DEBUG
                VIMem___024root___dump_triggers__stl(vlSelf);
#endif
                VL_FATAL_MT("../src//IMem.sv", 4, "", "Settle region did not converge.");
            }
            vlSelf->__VstlIterCount = ((IData)(1U) 
                                       + vlSelf->__VstlIterCount);
            VIMem___024root___eval_stl(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VIMem___024root___dump_triggers__stl(VIMem___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

void VIMem___024root___ico_sequent__TOP__0(VIMem___024root* vlSelf);

VL_ATTR_COLD void VIMem___024root___eval_stl(VIMem___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VIMem___024root___ico_sequent__TOP__0(vlSelf);
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VIMem___024root___dump_triggers__ico(VIMem___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root___dump_triggers__ico\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VicoTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VicoTriggered.word(0U))) {
        VL_DBG_MSGF("         'ico' region trigger index 0 is active: Internal 'ico' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void VIMem___024root___dump_triggers__act(VIMem___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void VIMem___024root___dump_triggers__nba(VIMem___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void VIMem___024root___ctor_var_reset(VIMem___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->address = VL_RAND_RESET_I(6);
    vlSelf->read_out = VL_RAND_RESET_I(32);
    for (int __Vi0 = 0; __Vi0 < 129; ++__Vi0) {
        vlSelf->IMem__DOT__imem[__Vi0] = VL_RAND_RESET_I(32);
    }
}
