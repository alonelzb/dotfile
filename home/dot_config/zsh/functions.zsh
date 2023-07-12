# mkdir and info
take() {
  mkdir $1 && cd $1
}

proxy_on() {
    export http_proxy=http://127.0.0.1:7890
    export https_proxy=http://127.0.0.1:7890
    echo 'proxy on'
}

proxy_off() {
    unset http_proxy
    unset https_proxy
}

clash() {
    proxy_on
    ~/.config/clash/clash-linux &
}
