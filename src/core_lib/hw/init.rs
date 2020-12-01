use super::{
	cpu,
	io,
};

/// # Hardware Initialization
///
/// This method wraps all initialization in the `hw` (hardware) module.
///
/// ## Caller
///
/// It is called in the main `init()` function found in `crate::lib.rs`.
///
/// ## Callees
///
/// 1. The Global Descriptor Table (GDT) is initialized here.
/// 2. The Interrupt Descriptor Table (IDT) is initialized here.
pub fn run()
{
	cpu::gdt::init();
	cpu::idt::init();

	io::interrupts::init_pics();
}
