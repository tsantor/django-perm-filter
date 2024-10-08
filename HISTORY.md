# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.4] - 2024-08-07

- Set proper UserAdmin `ordering` field to `username` or `email`.

## [0.2.3] - 2024-04-02

- Update to use `ruff` and added more tests.

## [0.2.2] - 2023-06-22

- Update packaging method to use `pyproject.toml`.

## [0.2.1] - 2022-09-19

- Fixed issue if `UserAdmin` or `GroupAdmin` were already registered.

## [0.2.0] - 2022-08-11

- Merged `HIDE_APPS` and `HIDE_PERMS` to make more clear that we're hiding perms only.
- Added ability to extend your own custom `UserAdmin` and `GroupAdmin` if need be.

## [0.1.1] - 2022-04-19

- Sorry, pushed copy/pasted changelog on first release!

## [0.1.0] - 2022-04-19

- First release on PyPI.
