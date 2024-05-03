#!/usr/bin/env fish
echo -e "\e[1;34mSetting up your environment...\e[0m"
rm -f ~/.vimrc
rm -f ~/.zshrc
rm  -f ~/.minttyrc
rm -f ~/.tmux.conf
rm -f ~/.config/fish/config.fish
ln -s ~/dotfiles/.vimrc ~/.vimrc 
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.minttyrc ~/.minttyrc
ln -s ~/dotfiles/config.fish ~/.config/fish/config.fish