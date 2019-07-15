# CentOS for Cluster Computing

## Table of Contents


## Accessing the Cluster
`ssh USERNAME@login.rc.fas.harvard.edu`

## Transfer files
* `scp hg19.chr1.fasta akitzmiller@login:`  
* `scp hg19.chr1.fasta akitzmiller@login:/var/www/html/`
* Using Filezilla is easier
* [Video](https://youtu.be/U9YqIVlEFN0?t=1776)

## Storage
[Video](https://youtu.be/U9YqIVlEFN0?t=1030)


## Module
* [List of Modules](https://portal.rc.fas.harvard.edu/apps/modules)
* `module load MODULENAME`
  * `module load gcc/8.2.0-fasrc01 openmpi/3.1.1-fasrc01 R/3.6.1-fasrc01`
  * `module load python/3.6.3-fasrc02`
* `module unload MODULENAME`
* Modules you loaded: `module list`


## R
### R packages
[Reference[(https://www.rc.fas.harvard.edu/resources/documentation/software-on-odyssey/r/)

* `$ mkdir -pv ~/apps/R_3.6.1`
* `$ module load gcc/8.2.0-fasrc01 openmpi/3.1.1-fasrc01 R/3.6.1-fasrc01`
* `$ export R_LIBS_USER=$HOME/apps/R_3.6.1:$R_LIBS_USER`
* `$ R`

## SLURM
[Reference](https://slurm.schedmd.com/sbatch.html)

### Run R

[Reference 1](https://hcc.unl.edu/docs/guides/submitting_jobs/submitting_r_jobs/) / [Reference 2](https://www.chpc.utah.edu/documentation/software/r-language.php)

```
#!/bin/bash
#SBATCH -n 1 # Number of cores requested
#SBATCH -N 1 # Ensure that all cores are on one machine
#SBATCH -t 01:00:00 # Runtime Limit
#SBATCH -p serial_requeue # Partition to submit to
#SBATCH --mem-per-cpu=2048 # Memory per cpu in MB (see also --mem-per-cpu)
#SBATCH --open-mode=truncate
#SBATCH --job-name=RunRSingleCore
#SBATCH -o RunRSingleCore.out # Standard out goes to this file
#SBATCH -e RunRSingleCore.err # Standard err goes to this filehostname

# Load R
module load gcc/8.2.0-fasrc01 openmpi/3.1.1-fasrc01 R/3.6.1-fasrc01
export R_LIBS_USER=$HOME/apps/R_3.6.1:$R_LIBS_USE

# Run R
R CMD BATCH ~/obj/run.R ~/obj/Routput.txt
```
