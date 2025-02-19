mac:
  brew install neovim && git clone git@github.com:mihaiflorentin88/neovim.git ~/.config/nvim

linux:
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz; \
    sudo rm -rf /opt/nvim; \
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz;\
    git clone git@github.com:mihaiflorentin88/neovim.git ~/.config/nvim

