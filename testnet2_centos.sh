#!/bin/bash
if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Aborting: run as root user!"
    exit 1
fi

echo "================================================"
echo " Attention - Building snarkOS from source code."
echo "================================================"

# Install Ubuntu dependencies

dnf install -y \
    openssl-devel \
    llvm \
    tmux \
    jq

# Install Rust

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env

# Install snarkOS
# cargo clean
cargo install --path .

echo "=================================================="
echo " Attention - Please ensure ports 4132 and 3032"
echo "             are enabled on your local network."
echo ""
echo " Cloud Providers - Enable ports 4132 and 3032"
echo "                   in your network firewall"
echo ""
echo " Home Users - Enable port forwarding or NAT rules"
echo "              for 4132 and 3032 on your router."
echo "=================================================="
