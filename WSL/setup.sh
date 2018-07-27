# Check prequsite: config is avaiable form ~/usr/config
if [ ! -f '~/usr/config/WSL/setup.sh' ]; then 
    echo 'config directory must be accessible from ~/usr/config'
    exit 1
fi

# Initial setup
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# Install packages
sudo apt install -y make cmake gcc clang nasm neovim emscripten fish mingw-w64 dos2unix pkg-config

# Setup neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
echo 'source ~/usr/config/nvim/init.vim' > ~/.config/nvim/init.vim
echo 'source ~/usr/config/WSL/vim_clipboard.vim' >> ~/.config/nvim/init.vim
nvim -c ':PlugUpdate' -c ':qa'

# Make fish the default shell
sudo chsh -s $(which fish) $(whoami)

# Setup directory colors
ln -s ~/usr/config/linux/.dircolors ~/.dircolors
