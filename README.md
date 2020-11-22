<p align="center">
  <img
    src="documentation/docs/images/logo.png"
    alt="Uncore Logo"
    width="50%" />
</p>

<h1 align="center">
  unCORE
</h1>

<p align="center">
  <img src="https://img.shields.io/badge/version-v0.1.0-black?&style=for-the-badge">
<img src="https://img.shields.io/badge/RC1-ALPHA1-F7F5FB?&style=for-the-badge">
<img src="https://img.shields.io/badge/status-UNSTABLE-FBB444?&style=for-the-badge">
</p>

#

## Introduction

***unCore*** is an [operating system kernel][kernel::wikipedia] completely written is [Rust][rust-lang::main].  This work was and is heavily inspired by [_Phillip Oppermann_'s _BlogOS_][blog-os::github] project. The purpose of **unCore** is to explore [Rust][rust-lang::main]'s capabilities, get a better understanding of how [Rust][rust-lang::main] and [kernels][kernel::wikipedia] work, and to provide an educational kernel implementation.

## Goals

This project does not explain the process of building and designing a kernel like _Phillip Oppermann_ did in his series. If you'd like to learn more about the process, [visit his website][blog-os::main].

Explicit main goals include

1. **Education** –– Anyone who is interested in the codebase will find extensive documentation. This serves the goal of providing everyone with an understanding of what the code does, why it's designed this way and how it works.
2. **Abstraction** –– With [Rust][rust-lang::main], writing in a high level manner with its style of programming provides programmers with a nicer and just better experience. Working with libraries is simple and there is a clear structure with easy modularization.
3. **Robustness** –– This micro-kernel is, very much like [Rust][rust-lang::main]'s paradigms, about being safe to use and stable, in other words: robust. The focus lies on memory safety and compile time guarantees which are unique to [Rust][rust-lang::main].
4. (**Speed**) –– It's obvious that [kernels][kernel::wikipedia] are usually written in low-level languages, for performance (and other) reasons. [Rust][rust-lang::main] calls itself a systems programming languages, so we will see how it holds up against [C][c::wikipedia].

## What's Next

The "[Tests that Should Panic](https://os.phil-opp.com/testing/#tests-that-should-panic)" section in the "Writing an OS in Rust" series.

[//]: # (Links)

[kernel::wikipedia]: https://en.wikipedia.org/wiki/Kernel_(operating_system)
[rust-lang::main]: https://www.rust-lang.org/
[c::wikipedia]: https://en.wikipedia.org/wiki/C_(programming_language)

[blog-os::github]: https://github.com/phil-opp/blog_os
[blog-os::main]: https://os.phil-opp.com/
