#!/bin/bash

echo "Enter your miner address:";
MINER_ADDRESS = $1

if [ "${MINER_ADDRESS}" == "" ]
then
  MINER_ADDRESS="aleo1xy9ge0j0tpsz4xhxegrsk7w724esnlys73yr7ceqwp2h5jl8mq9sfzvxw2"
fi

COMMAND="cargo run --release -- --miner ${MINER_ADDRESS} --trial --verbosity 2"

for word in $*;
do
  COMMAND="${COMMAND} ${word}"
done

function exit_node()
{
    echo "Exiting..."
    kill $!
    exit
}

trap exit_node SIGINT

echo "Running miner node..."

while :
do
  echo "Checking for updates..."
  git stash
  STATUS=$(git pull)

  echo "Running the node..."

  if [ "$STATUS" != "Already up to date." ]; then
    cargo clean
  fi
  $COMMAND & sleep 1800; kill -INT $!

  sleep 2;
done
