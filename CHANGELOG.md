<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Contents

  - [1.4.1 (2023-06-16)](#141-2023-06-16)
    - [Bug Fixes](#bug-fixes)
- [1.4.0 (2023-06-16)](#140-2023-06-16)
    - [Bug Fixes](#bug-fixes-1)
    - [Features](#features)
  - [1.3.2 (2023-05-19)](#132-2023-05-19)
    - [Bug Fixes](#bug-fixes-2)
  - [1.3.1 (2023-05-19)](#131-2023-05-19)
    - [Bug Fixes](#bug-fixes-3)
- [1.3.0 (2023-05-02)](#130-2023-05-02)
    - [Features](#features-1)
  - [1.2.2 (2023-05-01)](#122-2023-05-01)
    - [Bug Fixes](#bug-fixes-4)
  - [1.2.1 (2023-05-01)](#121-2023-05-01)
    - [Bug Fixes](#bug-fixes-5)
- [1.2.0 (2022-12-21)](#120-2022-12-21)
    - [Features](#features-2)
- [1.1.0 (2022-12-18)](#110-2022-12-18)
    - [Features](#features-3)
  - [1.0.2 (2022-12-14)](#102-2022-12-14)
    - [Bug Fixes](#bug-fixes-6)
  - [1.0.1 (2022-10-31)](#101-2022-10-31)
    - [Bug Fixes](#bug-fixes-7)
- [1.0.0 (2022-08-12)](#100-2022-08-12)
    - [Bug Fixes](#bug-fixes-8)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## [1.4.1](https://github.com/kolvin/kloud/compare/v1.4.0...v1.4.1) (2023-06-16)


### Bug Fixes

* **terragrunt, provider:** skip bucket policy check ([36dc7a6](https://github.com/kolvin/kloud/commit/36dc7a67ab2514bc0491ed583e722cf294b3a570))

# [1.4.0](https://github.com/kolvin/kloud/compare/v1.3.2...v1.4.0) (2023-06-16)


### Bug Fixes

* **ci, release:** refactor towards automated release workflow from kloud-cnf org ([6bfbb8d](https://github.com/kolvin/kloud/commit/6bfbb8dc8aec7894f3243defc22207a3e84ad972))


### Features

* **remote-state:** deploy state bucket + lock table to all AWS accounts ([e1f87ff](https://github.com/kolvin/kloud/commit/e1f87ff1c2302981c53bc64273d47627002bc5d9))

## [1.3.2](https://github.com/kolvin/kloud/compare/v1.3.1...v1.3.2) (2023-05-19)


### Bug Fixes

* **org:** remove dummy service prinipals ([9574bdb](https://github.com/kolvin/kloud/commit/9574bdb6694eb24c19a68379ea45726744dacfc9))

## [1.3.1](https://github.com/kolvin/kloud/compare/v1.3.0...v1.3.1) (2023-05-19)


### Bug Fixes

* **org:** switch module source ([745d67b](https://github.com/kolvin/kloud/commit/745d67b5c79a40a19fd4d0787afb55822d11d5d4))

# [1.3.0](https://github.com/kolvin/kloud/compare/v1.2.2...v1.3.0) (2023-05-02)


### Features

* **vpc:** adopt default vpc in prod ([#5](https://github.com/kolvin/kloud/issues/5)) ([83ab88e](https://github.com/kolvin/kloud/commit/83ab88ed16480bfcde392e7aa8c8a7f38ee24585))

## [1.2.2](https://github.com/kolvin/kloud/compare/v1.2.1...v1.2.2) (2023-05-01)


### Bug Fixes

* **ci:** set git ref to main for automated release + set release token perms ([d9d5a96](https://github.com/kolvin/kloud/commit/d9d5a96f96c52e3874491692c672a6a24eb8b89b))

## [1.2.1](https://github.com/kolvin/kloud/compare/v1.2.0...v1.2.1) (2023-05-01)


### Bug Fixes

* **ci:** set git ref to main for automated release + set release token perms ([d706a00](https://github.com/kolvin/kloud/commit/d706a004487b6ce76245bccf62a123fd15c2cb0d))

# [1.2.0](https://github.com/kolvin/kloud/compare/v1.1.0...v1.2.0) (2022-12-21)


### Features

* **route53:** set DNS records for personal domain ([#4](https://github.com/kolvin/kloud/issues/4)) ([5495792](https://github.com/kolvin/kloud/commit/549579207d2216eb7d86055cc5aec20731a0300f))

# [1.1.0](https://github.com/kolvin/kloud/compare/v1.0.2...v1.1.0) (2022-12-18)


### Features

* mvp for route53 hosted zone ([#3](https://github.com/kolvin/kloud/issues/3)) ([2fbdb79](https://github.com/kolvin/kloud/commit/2fbdb79f096f49c5895520ac8c45518e685212f9))

## [1.0.2](https://github.com/kolvin/kloud/compare/v1.0.1...v1.0.2) (2022-12-14)


### Bug Fixes

* lint ([e3c4704](https://github.com/kolvin/kloud/commit/e3c470463763ce6545fb01ddc3a39acd566c2764))

## [1.0.1](https://github.com/kolvin/kloud/compare/v1.0.0...v1.0.1) (2022-10-31)


### Bug Fixes

* EOF newline ([de96494](https://github.com/kolvin/kloud/commit/de9649494f81b14dcb18aa02c7429c93f3391bce))
* EOF newline inline ([5c99e0a](https://github.com/kolvin/kloud/commit/5c99e0ac950a1e851fc030008db61a004e450a00))

# 1.0.0 (2022-08-12)


### Bug Fixes

* **ci:** use correct namespace ([d249f3a](https://github.com/kolvin/kloud-aws/commit/d249f3ac7dd44826d3ec9617e71fc46c3b20e3db))
