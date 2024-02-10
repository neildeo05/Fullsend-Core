// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VIMem__Syms.h"


VL_ATTR_COLD void VIMem___024root__trace_init_sub__TOP__0(VIMem___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBus(c+1,"address", false,-1, 5,0);
    tracep->declBus(c+2,"read_out", false,-1, 31,0);
    tracep->pushNamePrefix("IMem ");
    tracep->declBus(c+1,"address", false,-1, 5,0);
    tracep->declBus(c+2,"read_out", false,-1, 31,0);
    tracep->popNamePrefix(1);
}

VL_ATTR_COLD void VIMem___024root__trace_init_top(VIMem___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root__trace_init_top\n"); );
    // Body
    VIMem___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void VIMem___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VIMem___024root__trace_chg_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VIMem___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void VIMem___024root__trace_register(VIMem___024root* vlSelf, VerilatedVcd* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root__trace_register\n"); );
    // Body
    tracep->addFullCb(&VIMem___024root__trace_full_top_0, vlSelf);
    tracep->addChgCb(&VIMem___024root__trace_chg_top_0, vlSelf);
    tracep->addCleanupCb(&VIMem___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void VIMem___024root__trace_full_sub_0(VIMem___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void VIMem___024root__trace_full_top_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root__trace_full_top_0\n"); );
    // Init
    VIMem___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VIMem___024root*>(voidSelf);
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    VIMem___024root__trace_full_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void VIMem___024root__trace_full_sub_0(VIMem___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    VIMem___024root__trace_full_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullCData(oldp+1,(vlSelf->address),6);
    bufp->fullIData(oldp+2,(vlSelf->read_out),32);
}
