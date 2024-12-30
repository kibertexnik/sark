//! Conditional reexporting of Board Support Packages

#[cfg(any(feature = "bsp_rpi3", feature = "bsp_rpi4", feature = "bsp_rpi5"))]
mod raspberrypi;

#[cfg(any(feature = "bsp_rpi3", feature = "bsp_rpi4", feature = "bsp_rpi5"))]
pub use raspberrypi::*;
