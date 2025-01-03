//! Processor code.

#[cfg(target_arch = "aarch64")]
#[path = "_arch/aarch64/cpu.rs"]
mod arch_cpu;

mod boot;

//----------------------------------------------------------------------------
// Architectural Public Reexports
//----------------------------------------------------------------------------
pub use arch_cpu::wait_forever;
