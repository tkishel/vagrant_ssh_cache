#!/bin/bash

function vssh() {
  if [ $# -eq 0 ]; then echo "Error: please specify a parameter"; return; fi

  VAGRANT_MACHINE_PATH=$PWD/.vagrant/machines/$1
  VAGRANT_MACHINE_SYNCED_FOLDERS_PATH=$VAGRANT_MACHINE_PATH/virtualbox/synced_folders
  VAGRANT_MACHINE_CACHED_SSH_FILE=$VAGRANT_MACHINE_PATH/vssh

  # If the ssh cache file for the machine is out of date, delete it.
  if [ -f "$VAGRANT_MACHINE_SYNCED_FOLDERS_PATH" ]; then
    if [[ "$VAGRANT_MACHINE_SYNCED_FOLDERS_PATH" -nt "$VAGRANT_MACHINE_CACHED_SSH_FILE" ]]; then
      rm -f $VAGRANT_MACHINE_CACHED_SSH_FILE
    fi
  fi

  # If the ssh cache file for the machine does not exist, create it.
  if [ ! -f "$VAGRANT_MACHINE_CACHED_SSH_FILE" ]; then
    ~/vagrant_ssh_cache/vssh.rb $1
  fi

  # If the ssh cache file exists, use it to connect to the machine.
  if [ -f "$VAGRANT_MACHINE_CACHED_SSH_FILE" ]; then
    $VAGRANT_MACHINE_CACHED_SSH_FILE
    if [ $? -ne 0 ]; then
      echo "Error: $?: deleting ssh cache file"
      rm -f $VAGRANT_MACHINE_CACHED_SSH_FILE
    fi
  else
    echo "Error: ssh cache file was not created for $1: please verify the machine is running"
  fi
}
