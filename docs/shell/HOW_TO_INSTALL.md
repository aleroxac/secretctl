# How to install
``` shell
if [ -d /opt/secretctl ]; then
    git -C /opt/secretctl pull --quiet origin main &> /dev/null
else
    git clone git@github.com:aleroxac/secretctl.git /tmp/secretctl
    sudo mv /tmp/secretctl /opt/
    chown -R ${USERNAME}:${USERNAME} /opt/secretctl

    CURRENT_SHELL=$(echo "${SHELL}" | cut -d '/' -f3)
    if [[ ! "${CURRENT_SHELL}" =~ bash|zsh ]]; then
        echo "Sorry, this shell is not supported by secretctl."
        exit 1
    fi
    echo -e "## ----- secretctl\nexport PATH=${PATH}:/opt/secretctl/shell/secretctl" >> "~/.${CURRENT_SHELL}rc"
fi
```
