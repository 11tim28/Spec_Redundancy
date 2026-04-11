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

#SBATCH -J analysis                        # Job name
#SBATCH -o out/analysis.o%j                    # Name of stdout output file (%j corresponds to the job id)
#SBATCH -e err/analysis.e%j                    # Name of stderr error file (%j corresponds to the job id)
#SBATCH -p vm-small                    # Queue (partition) name
#SBATCH -N 1                            # Total # of nodes (must be 1 for serial)
#SBATCH -n 1                            # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 47:59:59                     # Run time (hh:mm:ss)
#SBATCH --mail-user=tim20001128@gmail.com
#SBATCH --mail-type=all                 # Send email at begin and end of job (can assign begin or end as well)
######         # Allocation name (req'd if you have more than 1)

# Other commands must follow all #SBATCH directives..

cd /work/11141/yc35637/ls6/Lab4/simpoint/
module load python/3.12.11
./run_analysis_detailed.sh
