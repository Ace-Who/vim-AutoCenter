# vim-AutoCenter

Center the current line automatically. You can also diable this.

## Dependency

[`vim-SaveLoadMapping`](https://github.com/Ace-Who/vim-SaveLoadMapping)

## Usage

Run `:AutoCenterOn` to enable AutoCenter and `:AutoCenterOff` to disable it.

When enabled, pressing `<Esc>` or `<CR>` in insert mode results in centering the
current line automatically.

The old global mappings for `<Esc>` and `<CR>`, if existing, are saved and
restored automatically when switch the status of AutoCenter.

