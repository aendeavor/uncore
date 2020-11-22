#![no_std]
#![cfg_attr(test, no_main)]
#![feature(custom_test_frameworks)]
#![test_runner(core_lib::testing::test_runner)]
#![reexport_test_harness_main = "_start_for_tests"]

/// # The Library Part
///
/// As `src/lib.rs` is automatically detected by `cargo`
/// as a (freestanding) library, we need to define some
/// definition twice, here as well as an in `src/main.rs`.
///
/// This file can then be used in integration tests as well.

/// # The Core Library Path
///
/// This module has been created to give the kernel source
/// code as good structure and layout. The `core_lib` module
/// is a child of the `src/lib.rs` "crate", not of `src/main.rs`.
/// This is important, and we are not allowed to mix them up.
pub mod core_lib;

/// # Entrypoint
///
/// The `_start` function is the entrypoint which is directly "called"
/// after booting. The bootloader will set up a stack and call this
/// function.
#[cfg(test)]
#[no_mangle]
pub extern "C" fn _start() -> !
{
	_start_for_tests();
	core_lib::helper::__never_return()
}

/// # Panic Handler
///
/// This function uses a conditionally compiled function
/// depending on whether running the kernel or the test
/// suite.
#[cfg(test)]
#[panic_handler]
fn panic(info: &core::panic::PanicInfo) -> ! { core_lib::panic::panic(info) }
