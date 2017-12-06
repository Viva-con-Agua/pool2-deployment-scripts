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
The pool.sh in the root directory of the reposetory is the one that controls the pool.
To make the commands available on the command line, an alias must be created in the .bashrc.
Copy the following line at the end of the .bashrc and edit the path to the pool2.sh.

```
alias pool='bash /path/to/poo2.sh'

```




