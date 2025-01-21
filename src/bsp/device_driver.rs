//! Device driver.

#[cfg(any(feature = "bsp_rpi3", feature = "bsp_rpi4", feature = "bsp_rpi5"))]
mod bcm;
mod common;

#[cfg(any(feature = "bsp_rpi3", feature = "bsp_rpi4", feature = "bsp_rpi5"))]
pub use bcm::*;
