# cargo-generate GitHub Action

This action is used to run the `cargo-generate` tool in order to expand a template.

This is pushed to [docker hub cargogenerate/cargo-generate-action](https://hub.docker.com/r/cargogenerate/cargo-generate-action).

## Inputs

### `name`

**Required**

This is the name of the project being expanded.
 
### `template`

This is the URL/path to the repository holding the template. Defaults to `.`

### `branch`

Branch for cloning the template.

### `subfolder`

Subfolder within the template repository that'll be used as the template.

### `template_values_file`

Specifies a file holding the values required for template expansion.

> NOTE: `cargo-generate` is being run with the `--silent` option, so it will fail if any values are undefined during expansion.

### `other`

This can be used to specify any other option for `cargo-generate`.

Example:

```yml
other: "--define foo=\"value\" --define bar=42"
```

## Example

```yml
name: Try to expand local template using cargo-template
on:
  push:

jobs:
  check-bats-version:
    runs-on: ubuntu-latest
    env:
      EXPANDED: mytemplate
    steps:
      - uses: actions/checkout@v2

      - uses: cargo-generate/cargo-generate-action@v0
        with:
          template: '.'
          subfolder: template
          name: ${{ env.EXPANDED }}
      - run: sudo chown -R runner:docker .

      - uses: actions-rs/toolchain@v1
        with:
          toolchain: stable
      - run: cd $EXPANDED && cargo build --release
```
