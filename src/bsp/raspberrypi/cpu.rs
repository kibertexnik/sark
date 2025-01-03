//! BSP Processor code.

//----------------------------------------------------------------------------
// Public Definition
//----------------------------------------------------------------------------

///Used by `arch` code to find the early boot core.
#[no_mangle]
#[link_section = ".text._start_arguments"]
pub static BOOT_CORE_ID: u64 = 0;
