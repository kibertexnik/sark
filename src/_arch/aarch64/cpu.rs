//! Architectural processor code.
//!
//! # Orientation
//!
//! Since arch modules are imported into generic modules using the path attribute, the path of this
//! file is:
//!
//! crate::cpu::arch_cpu

//----------------------------------------------------------------------------
// Public code
//----------------------------------------------------------------------------

use aarch64_cpu::asm;

/// Pause execution on the core
#[inline(always)]
pub fn wait_forever() -> ! {
  loop {
    asm::wfe()
  }
}
