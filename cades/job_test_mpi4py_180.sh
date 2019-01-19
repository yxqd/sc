#!/bin/bash

### Set the job name. Your output files will share this name.
#PBS -N test_mpi4py

### Node spec, number of nodes and processors per node that you desire.
###   Two nodes and 36 cores per node in this case
###   SNS can specify up to 5 nodes and up to 36 processors per node
#PBS -l nodes=5:ppn=36

### Tell PBS the anticipated runtime for your job, where walltime=Days:Hours:Minutes:Seconds
#PBS -l walltime=0:00:10:00

### The LDAP group list
#PBS -W group_list=cades-virtues

### Your account type
#PBS -A sns

### Quality of service set to standard
#PBS -l qos=std

### Queue
#PBS -q skylake



## main program ##

# Remove old modules to ensure a clean state
module purge

# Load modules (your programming environment)
module load anaconda2
source activate mcvine

module load PE-gnu/3.0
module load openmpi


# Print loaded modules
echo
echo
echo '------ Loaded Modules ------'
module list 2>&1
echo
echo

# Switch to the working directory (path of your PBS script)
cd $PBS_O_WORKDIR

# Print current directory
echo
echo
echo '------ Current Working Directory ------'
pwd
echo
echo

# MPI run followed by the name/path of the binary
echo '------ Main Program ------'
echo $PBS_NODEFILE
cat $PBS_NODEFILE

# module load mpich
which mpirun
which python

mpirun -np 180  --hostfile $PBS_NODEFILE python -c "from mpi4py import MPI; print MPI.COMM_WORLD.Get_rank(), MPI.COMM_WORLD.Get_size()"

# exit
exit 0
