# Dependencies
## External 
}
- git
- ripgrep


# Installation

## Everything
### MacOS
```bash
brew install neovim && git clone git@github.com:mihaiflorentin88/neovim.git ~/.config/nvim
```

### Linux
```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz; \
    sudo rm -rf /opt/nvim; \
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz;\
    git clone git@github.com:mihaiflorentin88/neovim.git ~/.config/nvim
```

## Plugins
```bash
git clone git@github.com:mihaiflorentin88/neovim.git ~/.config/nvim
```
# Keybinds

If the keybind is between <> then you have to press those keys at once.
If it's not between <> then you will have to press those keys in succession.

## LSP
Space + c + a     Code actions
K                 Display function documentation
g + d             Go to definition

## Telescope
<CTRL + P>        Search for files.
Space + f + g     Live grep ( search within project files ).

## Neo Tree
<CTRL + n>        Displays the project tree on the left side.

## Panel Navigation
<CTRL + H>        Goes to left panel
<CTRL + L>        Goes to right panel

# Other:
Space + g + f     Autoformat 

# Cheatsheet
Keymaps
https://neovim.io/doc/user/quickref.html

LSP
Add support for other languages
File: lua/plugins/lsp-config.lua
Languages: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file
Check: Type :LspInfo to get a list of configured servers
Info on LSP:    :h vim.lsp.buf

Ident multiple lines
:3,10>
:3,10< 
