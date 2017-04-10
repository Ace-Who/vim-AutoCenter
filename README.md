# vim-AutoCenter

Center the current line automatically. You can also diable this.

## Dependency

My [`vim-SaveLoadMapping`](https://github.com/Ace-Who/vim-SaveLoadMapping)
plugin.

## Usage

Run `:AutoCenterOn` to enable AutoCenter and `:AutoCenterOff` to disable it.

When enabled, pressing `<Esc>` or `<CR>` in insert mode centers the current line
automatically.

**Note**: This is accomplished by global mappings, which can be made not taking
effect by a local mapping for the same key sequence.

Any old global mapping for `<Esc>` or `<CR>`, if existing, is saved and restored
automatically when switch the status of AutoCenter. This is performed by the
`vim-SaveLoadMapping` plugin.

