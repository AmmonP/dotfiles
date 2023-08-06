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

eval $(/opt/homebrew/bin/brew shellenv)

if [[ -f ~/work.zprofile ]]; then
    source ~/work.zprofile
fi
