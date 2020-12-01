# _unCore_ Documentation

![version](https://img.shields.io/badge/version-v0.1.0-black?&style=for-the-badge)
![rc](https://img.shields.io/badge/RC1-ALPHA1-F7F5FB?&style=for-the-badge)
![status](https://img.shields.io/badge/status-UNSTABLE-FBB444?&style=for-the-badge)

Welcome to the official **_unCore_** documentation. Everything you need to know about the development can be found under [Development](./development.md). This file exists to provide an overview of all aspects of this project. Here you will find information regarding

1. [Directory Structure](#directory-structure)
2. [Working with All of the Documentation](#working-with-all-of-the-documentation)
3. [Licensing](#licensing)

!!! danger "Developer Instructions"
    Make sure you read the [**Development Guidelines**](./development.md) _carefully_. Adhering to a consistent style and conventions allows everyone to work efficiently. By working on this projects and with other participants you agree to the **code of conduct** and the **contributing guidelines** set by this project.

!!! important "Licensing"
    This project is licensed under the [GNU General Public License 3][license::test], **except** for those parts (lines of code and information directly taken) [already licensed under other licenses by _Phillip Oppermann_ in his _BlogOS_ project][license::phil-op-blog-os].

[license::test]: https://www.gnu.org/licenses/gpl-3.0.txt
[license::phil-op-blog-os]: https://github.com/phil-opp/blog_os#license

## Directory Structure

The following diagram will provide you with an overview of and information about all files in the root directory of this project as well as files and directories located under `src`.

``` BASH
/
# DIRECTORIES
├── .cargo/
│   └── config.toml      # compiler configuration
├── .github/             # GitHub's issue and pull request templates
├── .gitlab/             # GitLab's issue and merge request templates
├── documentation/       # this documentation resides here
├── lints/               # holds all scripts for linting the code
├── scripts/             # holds all generic shell / Bash scripts
├── src/                 # the source code is located here
│   ├── core_lib/        # the module holding all major modules
│   │   ├── hw           # the major module for hardware
│   │   ├── mem          # the major module for memory management
│   │   ├── misc         # the major module for miscellaneous functions
│   │   ├── tests        # the major module for testing functionality
│   │   └── mod.rs       # the module description file for core_lib
│   ├── lib.rs           # Cargo's library crate file
│   └── main.rs          # Cargo's binary crate file
├── tests/               # integration tests are located here
# FILES
├── .ecrc.json           # configuration for the EditorConfig linting
├── .editorconfig        # general code formatting information
├── .env                 # holds versioning and other information
├── .gitignore           # Git's ignore list
├── .gitlab-ci.yml       # GitLab's CI/CD configuration
├── .rustfmt.toml        # code formatting configuration
├── Cargo.toml           # Cargo dependencies and crate configuration
├── CHANGELOG.md         # the changelog
├── CODE_OF_CONDUCT.md   # the code of conduct for all participants
├── CONTRIBUTING.md      # contributing guidelines for all participants
├── Justfile             # command runner configuration
├── LICENSE              # GPL3
├── Makefile             # generic build system configuration
├── README.md            # welcome page
├── rust-toolchain       # teh toolchain for rustc to use
└── x86_64-uncore.json   # build target rules
```

## Working with All of the Documentation

This documentation is only one half of what **_unCore_** has to offer. The other part is the code documentation. It can be used with `#!bash cargo doc --open`. You will find an extensive code documentation there - make use of it.
