# marksign.vim

Minimal plugin to visualize vim marks as signs.

## Installation

### Using vim-plug

```vim
Plug 'oky-123/marksign.vim'
```

### Using Vundle

```vim
Plugin 'oky-123/marksign.vim'
```

### Using NeoBundle

```vim
NeoBundle 'oky-123/marksign.vim'
```

## Feature

- This plugin will just show the marks in your vim.
- You can customize the marks to be displayed.
- You can set the number and priority of marks to show in the same line.
- You can disable the auto refresh to display marks at your leisure.

### Customize the marks to be displayed

You can set a whitelist for `g:marksign_marks_to_show` to limit the marks that are displayed as signs.
Also, when multiple marks are set in the same line, only `g:marksign_sign_num` marks will be shown, with priority given to the marks set in `g:marksign_marks_to_show` from left to right.

```vim
" HighPriority <- ABC..Zabc..z -> LowPriority
let g:marksign_marks_to_show = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
```

### Set the number of marks in the same line

You can set the number of marks to be shown in `g:marksign_marks_to_show`.
Note that it is recommended to set the vim option `signcolumn`.

```vim
" always display three sign columns
set signcolumn=yes:3

" automatically display the sign column
set signcolumn=auto
```

### Disable auto refresh

This plugin will keep updating the signature refresh automatically.
If you want to disable it, you can set as follows.

```vim
let g:marksign_enable_periodical_refresh = 0

" API function to manual refresh
:MarksignRefreshSigns
```

## Options

Options and their default values.

```vim
" mark list to show in signcolumn
let g:marksign_marks_to_show = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz^.'[]{}0123456789"
" flag to enable auto refresh
let g:marksign_enable_periodical_refresh = 1
" number of marks to be desplayed in the same line
let g:marksign_sign_num = 1
" highlight groups of signs
let g:marksign_sign_texthl = 'Label'
" priority of signs
let g:marksign_sign_priority = 0
```

## Commands

| Command                             |                           |
|------------------------------------ |---------------------------|
| `:MarksignEnablePeriodicalRefresh`  | Enable auto sign refresh  |
| `:MarksignDisablePeriodicalRefresh` | Disable auto sign refresh, and clear mark signs |
| `:MarksignRefreshSigns`             | Refresh signs             |

## Other plugins for marks

- [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim) ... `:Marks` command enables us to navigate placed marks fuzzy.
- [lotabout/skim.vim](https://github.com/lotabout/skim.vim) ... a fork of fzf.vim but for skim.
- [kshenoy/vim-signature](https://github.com/kshenoy/vim-signature) ... plugin for to display marks, but it can also navigate signs, and place custom signs.
