// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VIMem.h"
#include "VIMem__Syms.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

VIMem::VIMem(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new VIMem__Syms(contextp(), _vcname__, this)}
    , address{vlSymsp->TOP.address}
    , read_out{vlSymsp->TOP.read_out}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

VIMem::VIMem(const char* _vcname__)
    : VIMem(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

VIMem::~VIMem() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void VIMem___024root___eval_debug_assertions(VIMem___024root* vlSelf);
#endif  // VL_DEBUG
void VIMem___024root___eval_static(VIMem___024root* vlSelf);
void VIMem___024root___eval_initial(VIMem___024root* vlSelf);
void VIMem___024root___eval_settle(VIMem___024root* vlSelf);
void VIMem___024root___eval(VIMem___024root* vlSelf);

void VIMem::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VIMem::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VIMem___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_activity = true;
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        VIMem___024root___eval_static(&(vlSymsp->TOP));
        VIMem___024root___eval_initial(&(vlSymsp->TOP));
        VIMem___024root___eval_settle(&(vlSymsp->TOP));
    }
    // MTask 0 start
    VL_DEBUG_IF(VL_DBG_MSGF("MTask0 starting\n"););
    Verilated::mtaskId(0);
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    VIMem___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool VIMem::eventsPending() { return false; }

uint64_t VIMem::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* VIMem::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void VIMem___024root___eval_final(VIMem___024root* vlSelf);

VL_ATTR_COLD void VIMem::final() {
    VIMem___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* VIMem::hierName() const { return vlSymsp->name(); }
const char* VIMem::modelName() const { return "VIMem"; }
unsigned VIMem::threads() const { return 1; }
void VIMem::prepareClone() const { contextp()->prepareClone(); }
void VIMem::atClone() const {
    contextp()->threadPoolpOnClone();
}
std::unique_ptr<VerilatedTraceConfig> VIMem::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void VIMem___024root__trace_init_top(VIMem___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    VIMem___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VIMem___024root*>(voidSelf);
    VIMem__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->scopeEscape(' ');
    tracep->pushNamePrefix(std::string{vlSymsp->name()} + ' ');
    VIMem___024root__trace_init_top(vlSelf, tracep);
    tracep->popNamePrefix();
    tracep->scopeEscape('.');
}

VL_ATTR_COLD void VIMem___024root__trace_register(VIMem___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void VIMem::trace(VerilatedVcdC* tfp, int levels, int options) {
    if (tfp->isOpen()) {
        vl_fatal(__FILE__, __LINE__, __FILE__,"'VIMem::trace()' shall not be called after 'VerilatedVcdC::open()'.");
    }
    if (false && levels && options) {}  // Prevent unused
    tfp->spTrace()->addModel(this);
    tfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    VIMem___024root__trace_register(&(vlSymsp->TOP), tfp->spTrace());
}
