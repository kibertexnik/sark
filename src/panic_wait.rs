//! A panic handler that infinitely waits

use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
  unimplemented!()
}
