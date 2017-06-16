# vagrant_ssh_cache

#### Table of Contents

1. [Description](#description)
1. [Installation](#installation)
1. [Usage](#usage)

## Description

This script provides a `vssh` command that is faster than `vagrant ssh`.

## Installation

Clone this repository to your home directory.

~~~
cd ~
git clone https://github.com/tkishel/vagrant_ssh_cache.git
~~~

Add its script to your .bashrc:

~~~
echo "source ~/vagrant_ssh_cache/vssh.sh" >> ~/.bashrc
~~~

Reload your .bashrc:

~~~
. ~/.bashrc
~~~

> Note: On OSX, all Terminal opens as a login shell, which sources .bash_profile instead of .bashrc. Either change .bashrc to .bash_profile in the above, or add the following to your .bash_profile.
>
> ~~~
> # OSX
> if [ -f ~/.bashrc ]; then
>   source ~/.bashrc
> fi
> ~~~

## Usage

Execute the `vssh` command while in a vagrant directory to ssh to a running machine:

~~~
cd puppet-debugging-kit
vssh pe-201645-master
~~~

## Reference

The script caches `vagrant ssh-config` data for vagrant machines.

The script will use that data to ssh to a vagrant machine.

If cached data does not exist, the script will cache the data, and then ssh to the machine.

Connections will not update the known hosts file or perform host key checking.

