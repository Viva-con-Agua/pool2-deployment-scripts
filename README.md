# pool2-deployment-scripts

Installation
============

First, a user should be created for the administration of the pool. This user must be assigned to the docker group.
Next, it makes sense to copy the repository to a subfolder named Pool.

```
mkdir ~/Pool
cd ~/Pool
git clone git@github.com:Viva-con-Agua/pool2-deployment-scripts.git
```
The `pool.sh` in the root directory of the reposetory is the one that controls the pool.
To make the commands available on the command line, an alias must be created in the `.bashrc`.
Copy the following line at the end of the .bashrc and edit the path to the `pool2.sh`.

```
alias pool='bash /path/to/poo2.sh'
```

Since the Pool2 is based on a Docker architecture, the docker.service must be installed and started on the system. [A solution for Debian](https://docs.docker.com/engine/installation/linux/docker-ce/debian/)

Handling
========

A microservice of Pool2 can be started with the following command:
```
pool microserviceName parameter
```

Currently the following microservice are supported:

Microservice | Version | Alias | Parameter
--- | --- | --- | ---
Nginx | 0.12.1 | nginx | `run` `start` `rm` `logs`
Drops | 0.19.13 | drops | `run` `start` `rm` `logs`
Pool1 | N.A. 	| pool1 | `run` `start` `rm` `logs`
Dispenser | 0.1.12 | dispenser | `run` `start` `rm` `logs`
