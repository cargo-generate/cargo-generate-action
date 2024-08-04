# cargo-generate GitHub Action

This action runs `cargo-generate` to expand a template.

## Inputs

### `name`

**Required**

This is the name of the project being expanded.
 
### `template`

This is the path to the repository holding the template. Defaults to `.`

### `arguments`

All other arguments that cargo-generate accepts

> NOTE: `cargo-generate` runs with the `--silent` option, so it will fail if any values are undefined during expansion.

Example:

```yml
arguments: "--branch x --define=foo=\"value\" --define=bar=42"
```

## Example

```yml
name: Try to expand local template using cargo-generate
on:
  push:

jobs:
  build:
    runs-on: ubuntu-latest
    env:
      PROJECT_NAME: project-foo 
    steps:
      - uses: actions/checkout@v4
      - uses: cargo-generate/cargo-generate-action@latest
        with:
          name: ${{ env.PROJECT_NAME }}
      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      # we need to move the generated project to a temp folder, away from the template project
      # otherwise `cargo` runs would fail 
      # see https://github.com/rust-lang/cargo/issues/9922
      - run: |
          mv $PROJECT_NAME ${{ runner.temp }}/
          cd ${{ runner.temp }}/$PROJECT_NAME
          cargo check
```

There is also a full example in this repo under [.github/workflows/example-run.yml](https://github.com/cargo-generate/cargo-generate-action/blob/main/.github/workflows/example-run.yml)
