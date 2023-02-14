
# MARK: --- Environment ---
USER_PROFILE="$(whoami)"
SCRIPTS_DIR="/Users/$USER_PROFILE/.dotfiles/scripts"
export ZPLUG_HOME="/Users/$USER_PROFILE/.zplug"
export PATH="$PATH:/usr/local/bin:/usr/local/Cellar/vim/bin"
export JAVA_HOME="/usr/local/Cellar/openjdk@8/1.8.0+275"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
source ~/.zplug/init.zsh

# MARK: --- Plugins ---
zplug "zsh-users/zsh-autosuggestions"
zplug "agnoster/agnoster-zsh-theme", as:theme
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load # --verbose

# MARK: --- Functions ---

function demangle() {
  local symbol="$1"
  echo $symbol | c++filt -n
}

function demangleLines() {
    local symbols="$1"
    IFS=$'\n' lines=(${(f)symbols})

    echo "\n\nDEMANGLED:"
    for line in $lines 
    do
        symbol=$(echo $line | ack -o '(?<=\().+(?=\))')
        if [[ -z $symbol ]]; then
            symbol=$line
        fi
        demangle $symbol
    done

    IFS=$' \t\n'
}


# MARK:  --- Aliases ---
alias compvid="$SCRIPTS_DIR/compressVideo.sh"
alias ssymb="$SCRIPTS_DIR/symbolicate.sh"
alias androidss="$SCRIPTS_DIR/androidScreenshots.sh"
alias gitCleanBranches="git fetch -p && git branch -vv | grep ': gone]' | cut -d' ' -f3 | xargs git branch -D"
alias gitCleanAllButDev="git branch | grep -v 'dev' | xargs git branch -D"
alias gcpl="git clean -fd && git checkout . && git fetch && git pull --rebase"
alias vi="vim"
eval $(thefuck --alias)

