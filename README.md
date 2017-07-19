# Dankboard - a dank information board

## Setting up
The project was made to be used in a Vagrant environment, to do so, install Vagrant (and VirtualBox, which is used by Vagrant)

> [https://www.vagrantup.com/downloads.html]
> [https://www.virtualbox.org/wiki/Downloads]

Then run

```shell
vagrant up
```

This is start the virtual machine, once this is done, connect to the VM like this :

```shell
vagrant ssh
```

This is start the virtual machine, once this is done, connect to the VM like this :
The project was made to be used in a Vagrant environment, to do so,
install Vagrant (and VirtualBox, which is used by Vagrant)
[https://www.vagrantup.com/downloads.html]


## Running the Dankboard

Once this is done, go inside the apps folder and run the Server
```shell
    $ iex -S mix phoenix.server
```

(you can also run it with `mix phoenix.server` but it's nice to be able to interact with the server)
