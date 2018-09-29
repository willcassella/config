# Check prerequisite: config is available in ~/usr/config
if [ ! -f ~/usr/config/WSL/setup.sh ]; then 
    echo 'config directory must be accessible from ~/usr/config'
    exit 1
fi

# Initial setup
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y

# Install basic utilities
sudo apt install -y git make cmake pkg-config dos2unix libssl-dev w3m man

# Install additional utilities
sudo apt install -y neovim fish rtv

# Install languages
sudo apt install -y gcc gdb clang lldb nasm emscripten mingw-w64 python python-pip python3 python3-pip
sudo apt install -y lua5.3 liblua5.3-dev valgrind racket tcc

# Set up neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.config/nvim
echo "let g:load_plugins = 1" > ~/.config/nvim/init.vim
echo "let g:pretty = 1" >> ~/.config/nvim/init.vim
echo "let g:config_path = '~/usr/config/nvim/'" >> ~/.config/nvim/init.vim
echo "source ~/usr/config/nvim/init.vim" >> ~/.config/nvim/init.vim
echo "source ~/usr/config/WSL/vim_clipboard.vim" >> ~/.config/nvim/init.vim
pip install --upgrade neovim
pip3 install --upgrade neovim

# Set up normal vim
echo "let g:load_plugins = 0" > ~/.vimrc
echo "let g:pretty = 1" >> ~/.vimrc
echo "let g:config_path = '~/usr/config/nvim/'" >> ~/.vimrc
echo "source ~/usr/config/nvim/init.vim" >> ~/.vimrc

# Make fish the default shell
sudo chsh -s $(which fish) $(whoami)

# Install oh-my-fish
curl -L https://get.oh-my.fish | fish

# Install foreign-environment plugin
echo omf install foreign-env | fish

ln -s ~/usr/config/fish/config.fish ~/.config/fish/config.fish
ln -s ~/usr/config/fish/functions ~/.config/fish/functions

# Setup directory colors
ln -s ~/usr/config/linux/.dircolors ~/.dircolors
