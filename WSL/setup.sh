# Initial setup
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# Install packages
sudo apt install -y make cmake gcc clang nasm neovim emscripten

# Setup neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
echo 'source ~/src/config/nvim/init.vim' > ~/.config/nvim/init.vim
nvim -c ':PlugUpdate' -c ':qa'
