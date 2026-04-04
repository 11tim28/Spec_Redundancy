#!/bin/bash
#----------------------------------------------------
# Sample Slurm job script
#   for TACC Lonstar6 SKX nodes
#
#   *** Serial Job on SKX Normal Queue ***
#
# Notes:
#
#   -- Copy/edit this script as desired.  Launch by executing
#      "sbatch sample.slurm" on a Lonstar6 login node.
#
#   -- Serial codes run on a single node (upper case N = 1).
#        A serial code ignores the value of lower case n,
#        but slurm needs a plausible value to schedule the job.
#
#   -- For a good way to run multiple serial executables at the
#        same time, execute "module load launcher" followed
#        by "module help launcher".

#----------------------------------------------------

#SBATCH -J spec_compile                        # Job name
#SBATCH -o spec.o%j                    # Name of stdout output file (%j corresponds to the job id)
#SBATCH -e spec.e%j                    # Name of stderr error file (%j corresponds to the job id)
#SBATCH -p vm-small                    # Queue (partition) name
#SBATCH -N 1                            # Total # of nodes (must be 1 for serial)
#SBATCH -n 1                            # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 47:59:59                     # Run time (hh:mm:ss)
#SBATCH --mail-user=tim20001128@gmail.com
#SBATCH --mail-type=all                 # Send email at begin and end of job (can assign begin or end as well)
######         # Allocation name (req'd if you have more than 1)

# Other commands must follow all #SBATCH directives...

cdw
cd my_spec
cd spec2006
cd config
runspec --config=linux.cfg --action=build --tune=base all
