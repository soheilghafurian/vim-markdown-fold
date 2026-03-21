# vim-markdown-fold

Stateless markdown folding by header level for Vim and Neovim.

Each `#` header starts a new fold at the corresponding level. All other lines inherit the fold level of the preceding header. The fold expression is stateless — it only inspects the current line — so it avoids the issues that arise from stateful fold expressions that break on `InsertEnter`/`InsertLeave` recalculation.

## Installation

### Vundle

```vim
Plugin 'soheilghafurian/vim-markdown-fold'
```

### vim-plug

```vim
Plug 'soheilghafurian/vim-markdown-fold'
```

### Pathogen

```bash
cd ~/.vim/bundle
git clone https://github.com/soheilghafurian/vim-markdown-fold.git
```

### Manual

Copy `autoload/markdownfold.vim` and `ftplugin/markdown/folding.vim` into the corresponding directories under `~/.vim/`.

## Usage

The plugin activates automatically for markdown files. No configuration is needed.

If you use [vim-markdown](https://github.com/preservim/vim-markdown), disable its built-in folding to avoid conflicts:

```vim
let g:vim_markdown_folding_disabled = 1
```

## License

MIT
