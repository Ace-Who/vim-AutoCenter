# vim-AutoCenter

When enabled, center the current line automatically.

## Usage

- `:AutoCenterOn`: enable AutoCenter.
- `:AutoCenterOff`: disable AutoCenter.

When enabled,
     
- center current line whenever the text is changed except by an undo or redo
operation, so it doesn't affect them.
- `=` key acts like its default behavior except that it centers lines instead of
indenting them.
- `<CR>` is unmapped for Insert mode in case some existing mapping may affect
the centering function.

## Dependency

- [MappingMem](https://github.com/Ace-Who/vim-MappingMem) plugin. Optional but
recommended. Used to restore the mappings overriden or deleted by `AutoCenter`
when you turn it off.
