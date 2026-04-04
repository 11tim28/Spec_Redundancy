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

#SBATCH -J perf2006int                        # Job name
#SBATCH -o perf2006int.o%j                    # Name of stdout output file (%j corresponds to the job id)
#SBATCH -e perf2006int.e%j                    # Name of stderr error file (%j corresponds to the job id)
#SBATCH -p vm-small                    # Queue (partition) name
#SBATCH -N 1                            # Total # of nodes (must be 1 for serial)
#SBATCH -n 1                            # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 47:59:59                     # Run time (hh:mm:ss)
#SBATCH --mail-user=tim20001128@gmail.com
#SBATCH --mail-type=all                 # Send email at begin and end of job (can assign begin or end as well)
######         # Allocation name (req'd if you have more than 1)

# Other commands must follow all #SBATCH directives...

export SPEC06="/work/11141/yc35637/ls6/my_spec/spec2006"
cd $SPEC06
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses $SPEC06/benchspec/CPU2006/401.bzip2/run/run_base_test_amd64-m64-gcc42-nn.0000/bzip2_base.amd64-m64-gcc42-nn $SPEC06/benchspec/CPU2006/401.bzip2/run/run_base_test_amd64-m64-gcc42-nn.0000/input.program 5 2>$SPEC06/output/401.txt
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses $SPEC06/benchspec/CPU2006/403.gcc/run/run_base_test_amd64-m64-gcc42-nn.0000/gcc_base.amd64-m64-gcc42-nn $SPEC06/benchspec/CPU2006/403.gcc/run/run_base_test_amd64-m64-gcc42-nn.0000/cccp.i -o cccp.s 2>$SPEC06/output/403.txt  
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses $SPEC06/benchspec/CPU2006/429.mcf/run/run_base_test_amd64-m64-gcc42-nn.0000/mcf_base.amd64-m64-gcc42-nn $SPEC06/benchspec/CPU2006/429.mcf/run/run_base_test_amd64-m64-gcc42-nn.0000/inp.in 2>$SPEC06/output/429.txt    
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses $SPEC06/benchspec/CPU2006/445.gobmk/run/run_base_test_amd64-m64-gcc42-nn.0000/gobmk_base.amd64-m64-gcc42-nn --quiet --mode gtp 2>$SPEC06/output/445.txt   
cd $SPEC06/benchspec/CPU2006/456.hmmer/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./hmmer_base.amd64-m64-gcc42-nn --fixed 0 --mean 325 --num 45000 --sd 200 --seed 0 ./bombesin.hmm 2>$SPEC06/output/456.txt 
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses $SPEC06/benchspec/CPU2006/458.sjeng/run/run_base_test_amd64-m64-gcc42-nn.0000/sjeng_base.amd64-m64-gcc42-nn $SPEC06/benchspec/CPU2006/458.sjeng/run/run_base_test_amd64-m64-gcc42-nn.0000/test.txt 2>$SPEC06/output/458.txt
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses $SPEC06/benchspec/CPU2006/462.libquantum/run/run_base_test_amd64-m64-gcc42-nn.0000/libquantum_base.amd64-m64-gcc42-nn 33 5 2>$SPEC06/output/462.txt
cd $SPEC06/benchspec/CPU2006/464.h264ref/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./h264ref_base.amd64-m64-gcc42-nn -d ./foreman_test_encoder_baseline.cfg 2>$SPEC06/output/464.txt
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses $SPEC06/benchspec/CPU2006/471.omnetpp/run/run_base_test_amd64-m64-gcc42-nn.0000/omnetpp_base.amd64-m64-gcc42-nn $SPEC06/benchspec/CPU2006/471.omnetpp/run/run_base_test_amd64-m64-gcc42-nn.0000/omnetpp.ini 2>$SPEC06/output/471.txt
cd $SPEC06/benchspec/CPU2006/473.astar/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./astar_base.amd64-m64-gcc42-nn ./lake.cfg 2>$SPEC06/output/473.txt


