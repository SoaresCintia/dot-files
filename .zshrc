export ZSH=~/.oh-my-zsh
ZSH_THEME="agnoster"
plugins=(git)
export PATH="~/bin:/var/setuid-wrappers:~/.nix-profile/bin:~/.nix-profile/sbin:~/.nix-profile/lib/kde4/libexec:/nix/var/nix/profiles/default/bin:/nix/var/nix/profiles/default/sbin:/nix/var/nix/profiles/default/lib/kde4/libexec:/run/current-system/sw/bin:/run/current-system/sw/sbin:/run/current-system/sw/lib/kde4/libexec"
source $ZSH/oh-my-zsh.sh
export LANG=en_US.UTF-8
export EDITOR='sublime3 -n -w'
export SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled"

