//! BSP console facilities.

use crate::console;

//----------------------------------------------------------------------------
// Public Code
//----------------------------------------------------------------------------

pub fn console() -> &'static dyn console::interface::All {
    &super::driver::PL011_UART
}
