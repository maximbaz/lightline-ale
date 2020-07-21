# lightline-lsp

This plugin provides [vim-lsp](https://github.com/prabirshrestha/vim-lsp) indicator for the [lightline](https://github.com/itchyny/lightline.vim) vim plugin.

Forked from [lightline-ale](https://github.com/maximbaz/lightline-ale).

## Current project status

- [ ] diagnostics : not work
- [x] server      : work

## Table Of Contents

- [Installation](#installation)
- [Integration](#integration)
- [Configuration](#configuration)
- [License](#license)

## Installation

Install using a plugin manager of your choice, for example:

```viml
call dein#add('prabirshrestha/async.vim') " Dependency: linter async lib
call dein#add('vim-lsp')                  " Dependency: linter
call dein#add('itchyny/lightline.vim')    " Dependency: status line
call dein#add('tsuyoshicho/lightline-lsp')
```

## Integration

### 1. Register the components

```viml
" init
" let g:lightline = {}

" diagnostics
" already previous setting exists, you would be using expand() function to  dictionary expand.
let g:lightline.component_expand = {
      \  'linter_checking' : 'lightline#lsp#checking',
      \  'linter_error'    : 'lightline#lsp#error',
      \  'linter_warning'  : 'lightline#lsp#warning',
      \  'linter_info'     : 'lightline#lsp#information',
      \  'linter_error'    : 'lightline#lsp#hint',
      \  'linter_ok'       : 'lightline#lsp#ok',
      \}

" server
" same above.
let g:lightline.component_expand = {
      \  'lsp_status_error'     : 'lightline#lsp#status_error',
      \  'lsp_status_warning'   : 'lightline#lsp#status_warning',
      \  'lsp_status_ok'        : 'lightline#lsp#status_ok',
      \}

" count indicator
let g:lightline.component_function = {
      \   'lsp_count':    'lightline#lsp#count',
      \}
```

### 2. Set color to the components

```viml
" diagnostics
" already previous setting exists, you would be using expand() function to  dictionary expand.
let g:lightline.component_type = {
      \  'linter_checking': 'left',
      \  'linter_warnings': 'warning',
      \  'linter_errors': 'error',
      \  'linter_ok': 'left',
      \}

" server
" same above.
let g:lightline.component_type = {
      \  'lsp_status_error'     : 'error',
      \  'lsp_status_warning'   : 'warning',
      \  'lsp_status_ok'        : 'ok',
      \}
```

### 3. Add the components to the lightline, for example to the right side

```viml
" diagnostics and server
" already previous setting exists, you would be using expand() function to  dictionary expand.
let g:lightline.active = { 'right': [
      \  ['lsp_status_error', 'lsp_status_warning', 'lsp_status_ok'],
      \  ['lsp_count'],
      \  [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
      \]}
```

## Configuration

### `g:lightline#lsp#indicator_checking`

The indicator to use when vim-lsp is in progress. Default is `Linting...`.

### `g:lightline#lsp#indicator_warnings`

The indicator to use when there are warnings. Default is `W:`.

### `g:lightline#lsp#indicator_errors`

The indicator to use when there are errors. Default is `E:`.

### `g:lightline#lsp#indicator_ok`

The indicator to use when there are no warnings or errors. Default is `OK`.

### `g:lightline#lsp#server_interval`

This interval as servers cycle status indicatation(sec).

### Using icons as indicators

If you would like to replace the default indicators with symbols like lightline-ale, then you'll need to ensure you have some "iconic fonts" installed, such as [Font Awesome](https://fontawesome.com). A common alternative is to replace your primary font with one of the [Patched Nerd Fonts](https://github.com/ryanoasis/nerd-fonts), which saves you from having to install multiple fonts.

The following icons from the Font Awesome font are used in the lightline-ale:

- Checking: [f110](https://fontawesome.com/icons/spinner)
- Warnings: [f071](https://fontawesome.com/icons/exclamation-triangle)
- Errors: [f05e](https://fontawesome.com/icons/ban)
- OK: [f00c](https://fontawesome.com/icons/check) (although I prefer to disable this component)

To specify icons in the configuration, use their unicode codes as `"\uXXXX"` (make sure to wrap them in double quotes). Alternatively copy the icons from a font website, or type <kbd>\<C-v\>u\<4-digit-unicode\></kbd> or <kbd>\<C-v\>U\<8-digit-unicode\></kbd> to insert the literal characters.

See the code points here:

- [Font Awesome](https://fontawesome.com/icons)
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts#glyph-sets)

Here's the configuration snippet used in the lightline-ale:

```viml
let g:lightline#lsp#indicator_checking = "\uf110"
let g:lightline#lsp#indicator_warnings = "\uf071"
let g:lightline#lsp#indicator_errors = "\uf05e"
let g:lightline#lsp#indicator_ok = "\uf00c"
```

## License

Released under the [MIT License](LICENSE).

Based lightline-ale released under the [MIT License](LICENSE-lightline-ale).
