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

#SBATCH -J perf2017int                        # Job name
#SBATCH -o perf2017int.o%j                    # Name of stdout output file (%j corresponds to the job id)
#SBATCH -e perf2017int.e%j                    # Name of stderr error file (%j corresponds to the job id)
#SBATCH -p vm-small                    # Queue (partition) name
#SBATCH -N 1                            # Total # of nodes (must be 1 for serial)
#SBATCH -n 1                            # Total # of mpi tasks (should be 1 for serial)
#SBATCH -t 47:59:59                     # Run time (hh:mm:ss)
#SBATCH --mail-user=tim20001128@gmail.com
#SBATCH --mail-type=all                 # Send email at begin and end of job (can assign begin or end as well)
######         # Allocation name (req'd if you have more than 1)

# Other commands must follow all #SBATCH directives...

export SPEC17="/work/11141/yc35637/ls6/spec2017"
cd $SPEC17
cd $SPEC17/benchspec/CPU/500.perlbench_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./perlbench_r_base.mytest-m64 -I. -I./lib ./makerand.pl > makerand.out 2>> makerand.err 2>$SPEC17/output/500.txt

cd $SPEC17/benchspec/CPU/502.gcc_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./cpugcc_r_base.mytest-m64 t1.c -O3 -finline-limit=50000 -o t1.opts-O3_-finline-limit_50000.s > t1.opts-O3_-finline-limit_50000.out 2>> t1.opts-O3_-finline-limit_50000.err 2>$SPEC17/output/502.txt

cd $SPEC17/benchspec/CPU/505.mcf_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./mcf_r_base.mytest-m64 inp.in  > inp.out 2>> inp.err 2>$SPEC17/output/505.txt

cd $SPEC17/benchspec/CPU/520.omnetpp_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./omnetpp_r_base.mytest-m64 -c General -r 0 > omnetpp.General-0.out 2>> omnetpp.General-0.err 2>$SPEC17/output/520.txt

cd $SPEC17/benchspec/CPU/523.xalancbmk_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./cpuxalan_r_base.mytest-m64 -v test.xml xalanc.xsl > test-test.out 2>> test-test.err 2>$SPEC17/output/523.txt

cd $SPEC17/benchspec/CPU/525.x264_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./x264_r_base.mytest-m64 --dumpyuv 50 --frames 156 -o BuckBunny_New.264 BuckBunny.yuv 1280x720 > run_000-156_x264_r_base.mytest-m64_x264.out 2>> run_000-156_x264_r_base.mytest-m64_x264.err 2>$SPEC17/output/525.txt

cd $SPEC17/benchspec/CPU/531.deepsjeng_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./deepsjeng_r_base.mytest-m64 test.txt > test.out 2>> test.err 2>$SPEC17/output/531.txt

cd $SPEC17/benchspec/CPU/541.leela_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./leela_r_base.mytest-m64 test.sgf > test.out 2>> test.err 2>$SPEC17/output/541.txt

cd $SPEC17/benchspec/CPU/548.exchange2_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./exchange2_r_base.mytest-m64 0 > exchange2.txt 2>> exchange2.err 2>$SPEC17/output/548.txt

cd $SPEC17/benchspec/CPU/557.xz_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,L1-icache-load-misses,branches,branch-misses,l2_cache_misses_from_dc_misses,iTLB-load-misses ./xz_r_base.mytest-m64 cpu2006docs.tar.xz 4 055ce243071129412e9dd0b3b69a21654033a9b723d874b2015c774fac1553d9713be561ca86f74e4f16f22e664fc17a79f30caa5ad2c04fbc447549c2810fae 1548636 1555348 0 > cpu2006docs.tar-4-0.out 2>> cpu2006docs.tar-4-0.err 2>$SPEC17/output/557.txt
