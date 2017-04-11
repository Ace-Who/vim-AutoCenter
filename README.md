# vim-AutoCenter

When enabled, center the current line automatically.

## Dependency

[`SaveLoadMapping`](https://github.com/Ace-Who/vim-SaveLoadMapping) plugin. This
is not necessary but recommended, which can restore the mappings overriden by
`AutoCenter` when you turn it off.

## Usage

- `:AutoCenterOn`: enable AutoCenter.
- `:AutoCenterOff`: disable AutoCenter.

When enabled,
     
- center current line whenever the text is changed except by an undo or redo
operation, so it doesn't affect them.
- `=` key acts like its default behavior except that it centers lines instead of
indenting them.

