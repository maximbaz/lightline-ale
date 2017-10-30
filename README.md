# lightline-ale

This plugin provides [ALE](https://github.com/w0rp/ale) indicator for the [lightline](https://github.com/itchyny/lightline.vim) vim plugin.

![screenshot](./screenshot.png)

## Table Of Contents

- [Installation](#installation)
- [Integration](#integration)
- [Configuration](#configuration)
- [License](#license)

## Installation

Install using a plugin manager of your choice, for example:

```viml
call dein#add('maximbaz/lightline-ale')
```

## Integration

1. Register the component:

```viml
let g:lightline.component_expand = {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
```

2. Set color to the component (use `warning` or `error`):

```viml
let g:lightline.component_type = {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ }
```

3. Add the component to the lightline, for example to the right side:

```viml
let g:lightline.active = { 'right': [[ 'linter_errors', 'linter_warnings', 'linter_ok' ]] }
```

## Configuration

##### `g:lightline#ale#indicator_warnings`

The indicator to use when there are warnings. Default is `W:`.

##### `g:lightline#ale#indicator_errors`

The indicator to use when there are errors. Default is `E:`.

##### `g:lightline#ale#indicator_ok`

The indicator to use when there are no warnings or errors. Default is `OK`.

## License

Released under the [MIT License](LICENSE)
