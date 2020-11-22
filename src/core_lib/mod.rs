/// # SemVer Version
///
/// This is the semantic versioning version string
/// with added release candidate, maturity grade and
/// stability identifier.
const VERSION: &str = "v0.1.0-rc1 alpha1 unstable";

/// # Miscellaneous Helper
///
/// This module provides various helper functions.
pub mod helper;

/// # Provides the API for Panicking
///
/// This module provides the implementation
/// for the panic macro and panic behavior.
pub mod panic;

/// # Providing Test Infrastructure
///
/// As testing usually relies on the standard
/// library, we will need to write our own simple
/// testing framework.
pub mod testing;

/// # A Serial Device
///
/// The `write` module makes heavy use of this module
/// as it `serial` provides the ability to write to
/// a serial device which is "forwarded" to `stdout`
/// via QEMU.
pub mod serial;

/// # Printing Information
///
/// This module enabled the printing of information
/// to a screen. Here, a VGA buffer is used, which
/// is displayed in `stdout` in the terminal through
/// a serial device in `QEMU`.
///
/// ## Future
///
/// This module will be re-written soon. Therefore, the
/// documentation is not of good quality.
pub mod write;
