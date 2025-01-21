//! Architectural processor code.
//!
//! # Orientation
//!
//! Since arch modules are imported into generic modules using the path attribute, the path of this
//! file is:
//!
//! crate::cpu::arch_cpu

use aarch64_cpu::asm;

//----------------------------------------------------------------------------
// Public code
//----------------------------------------------------------------------------

pub use asm::nop;

/// Spin for `n` cycles.
#[cfg(feature = "bsp_rpi3")]
#[inline(always)]
pub fn spin_for_cycles(n: usize) {
    for _ in 0..n {
        asm::nop();
    }
}

/// Pause execution on the core
#[inline(always)]
pub fn wait_forever() -> ! {
    loop {
        asm::wfe()
    }
}
