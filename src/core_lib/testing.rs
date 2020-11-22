use crate::{
	serial_print,
	serial_println,
};
use super::helper::qemu;

/// # A Simple Test Runner Implementation
///
/// This function is registered as the test
/// runner when executing cargo test's unit tests.
///
/// It will just execute all functions marked with `#[test_case]`
/// one by one.
pub fn test_runner(tests: &[&dyn Testable])
{
	serial_println!("Running {} tests.\n", tests.len());

	for test in tests {
		test.run();
	}

	qemu::exit_qemu(qemu::QemuExitCode::Success);
}

/// # Makes Testing Streamlined
///
/// This trait provides the test runner with the ability to
/// `.run` tests. This is done for all functions in the
/// `impl` block, so they can be "parsed" to reduce boilerplate
/// code.
pub trait Testable
{
	fn run(&self);
}

impl<T> Testable for T
where
	T: Fn(),
{
	fn run(&self)
	{
		use core::any::type_name;

		serial_print!("{}  ", type_name::<T>());
		self();
		serial_println!("[ok]");
	}
}

/// This test is just here for sanity's sake to make
/// sure tests behave correctly at the most basic level.
#[test_case]
fn trivial_assertion()
{
	const ONE: u8 = 1;
	assert_eq!(1, ONE);
	assert_eq!(ONE, 1);
}
