# vim-marksign

Minimal plugin to visualize vim marks as signs.

mark機能を可視化するminimalなプラグインです。

# Installation

## Using vim-plug

```vim
Plug 'oky-123/marksign.vim'
```

## Using Vundle

```vim
Plugin 'oky-123/marksign.vim'
```

## Using NeoBundle

```vim
NeoBundle 'oky-123/marksign.vim'
```

# Feature

- このプラグインはあなたのvimにマークを表示させるだけです。
- 表示させるマークをカスタマイズできます。
- 表示させるマークの個数・優先順位を設定できます。
- 自動リフレッシュ機能を無効にして、あなたの好きなタイミングでリフレッシュすることができます。

## 表示させるマークをカスタマイズする

`g:marksign_marks_to_show`に表示させるマークのホワイトリストをセットすることで、表示を限定できます。
また、同じ行に複数マークが設定された場合、`g:marksign_marks_to_show`に設定したマークの左から順に優先して`g:marksign_sign_num`個だけ表示します。

```vim
" HighPriority <- AB..Zab..z -> LowPriority
let g:marksign_marks_to_show = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
```

## 表示させるマーク数設定する

`g:marksign_marks_to_show`に表示させるマーク数を設定できます。

NOTE: vimオプションの`signcolumn`を設定することを推奨します。

```vim
" 常に3つのサインカラムを表示する場合
set signcolumn=yes:3

" 自動でサインカラムを表示する場合
set signcolumn=auto
```

## 自動リフレッシュを無効に

```vim
let g:marksign_enable_periodical_refresh = 0

" API function to manual refresh
:MarksignRefreshSigns
```

# Options

```vim
" Mark list to show in signcolumn
let g:marksign_marks_to_show = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz^.'[]{}0123456789"
" 自動リフレッシュを有効にするかのフラグ
let g:marksign_enable_periodical_refresh = 1
" 表示させるマーク数
let g:marksign_sign_num = 1
" 表示させるマークのハイライトグループ
let g:marksign_sign_texthl = 'Label'
" 表示するサインの優先度
let g:marksign_sign_priority = 0
```

# Commands

|Command                              |                           |
|------------------------------------ |---------------------------|
| `:MarksignEnablePeriodicalRefresh`  | Enable auto sign refresh  |
| `:MarksignDisablePeriodicalRefresh` | Disable auto sign refresh |
| `:MarksignRefreshSigns`             | Refresh signs             |

# マーク操作を便利にするプラグイン

- [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim) ... `:Marks` command enables us to navigate marks fuzzy.
- [lotabout/skim.vim](https://github.com/lotabout/skim.vim) ... a fork of fzf.vim but for skim.
- [kshenoy/vim-signature](https://github.com/kshenoy/vim-signature) ... plugin for to display marks, but it can also navigate to placed signs, and place custom signs.
