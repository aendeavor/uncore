use super::helper::qemu;
use core::panic::PanicInfo;

/// # Panic Handler when not Running Tests
///
/// This function is marked for conditional compilation, and is used
/// when running the binary natively, i.e. not the tests.
#[cfg(not(test))]
pub fn panic(info: &PanicInfo) -> !
{
	crate::println!("{}", info);
	super::helper::__never_return()
}

/// # Panic Handler when Running Tests
///
/// This function is marked for conditional compilation, and is used
/// when running the custom test suite.
#[cfg(test)]
pub fn panic(info: &PanicInfo) -> ! { test_panic_handler(info) }

/// # Publicly Available Panic Handler
///
/// This function makes sure we have a publicly
/// available panic handler function which we could
/// call from integration tests.
pub fn test_panic_handler(info: &PanicInfo) -> !
{
	crate::serial_println!("[Failed]\n");
	crate::serial_println!("Error: {}\n", info);
	qemu::exit_qemu(qemu::QemuExitCode::Failed);

	super::helper::__never_return()
}
