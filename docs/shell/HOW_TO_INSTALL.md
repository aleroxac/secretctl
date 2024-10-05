# How to install
``` shell
if [ -d /opt/secretctl ]; then
    git -C /opt/secretctl pull --quiet origin main &> /dev/null
else
    git clone git@github.com:aleroxac/secretctl.git /tmp/secretctl
    sudo mv /tmp/secretctl /opt/
    chown -R ${USERNAME}:${USERNAME} /opt/secretctl
fi
```
