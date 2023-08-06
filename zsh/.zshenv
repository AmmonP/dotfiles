USER_PROFILE="$(whoami)"

export VOLTA_HOME="$HOME/.volta"
export ZPLUG_HOME="/Users/$USER_PROFILE/.zplug"
export JAVA_HOME="/usr/local/Cellar/openjdk@8/1.8.0+275"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH="$VOLTA_HOME/bin:/Users/$(whoami)/.local/bin:$PATH:/usr/local/bin:/usr/local/Cellar/vim/bin"

source ~/.zplug/init.zsh

# setup pyenv
eval "PATH="$(bash --norc -ec 'IFS=:; paths=($PATH); 
for i in ${!paths[@]}; do 
if [[ ${paths[i]} == "''/Users/$(whoami)/.pyenv/shims''" ]]; then unset '\''paths[i]'\''; 
fi; done; 
echo "${paths[*]}"')"
export PATH="/Users/$(whoami)/.pyenv/shims:${PATH}"
command pyenv rehash 2>/dev/null"

# Created by `pipx` on 2023-08-30 18:26:48
export PATH="$PATH:/Users/$(whoami)/.local/bin"
