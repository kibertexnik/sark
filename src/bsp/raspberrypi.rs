//! Top-level BSP file for the Rapsberry 3, 4 and 5.

#![allow(unreachable_code)]

pub mod cpu;
pub mod driver;
pub mod memory;

//--------------------------------------------------------------------------------------------------
// Public Code
//--------------------------------------------------------------------------------------------------

/// Board identification.
pub fn board_name() -> &'static str {
    #[cfg(feature = "bsp_rpi3")]
    {
        "Raspberry Pi 3"
    }

    #[cfg(feature = "bsp_rpi4")]
    {
        "Raspberry Pi 4"
    }

    #[cfg(feature = "bsp_rpi5")]
    {
        "Raspberry Pi 5"
    }
}
