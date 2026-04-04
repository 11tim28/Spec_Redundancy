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

#SBATCH -J perf2006fp                        # Job name
#SBATCH -o perf2006fp.o%j                    # Name of stdout output file (%j corresponds to the job id)
#SBATCH -e perf2006fp.e%j                    # Name of stderr error file (%j corresponds to the job id)
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
cd $SPEC06/benchspec/CPU2006/410.bwaves/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./bwaves_base.amd64-m64-gcc42-nn  2>$SPEC06/output/410.txt
#cd $SPEC06/benchspec/CPU2006/433.milc/run/run_base_test_amd64-m64-gcc42-nn.0000/
#perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./milc_base.amd64-m64-gcc42-nn 2>$SPEC06/output/433.txt  
cd $SPEC06/benchspec/CPU2006/434.zeusmp/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./zeusmp_base.amd64-m64-gcc42-nn 2>$SPEC06/output/434.txt    
cd $SPEC06/benchspec/CPU2006/435.gromacs/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./gromacs_base.amd64-m64-gcc42-nn -silent -deffnm gromacs -nice 0 2>$SPEC06/output/435.txt 
cd $SPEC06/benchspec/CPU2006/436.cactusADM/run/run_base_test_amd64-m64-gcc42-nn.0000/  
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./cactusADM_base.amd64-m64-gcc42-nn ./benchADM.par 2>$SPEC06/output/436.txt 
#cd $SPEC06/benchspec/CPU2006/437.leslie3d/run/run_base_test_amd64-m64-gcc42-nn.0000/
#perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./leslie3d_base.amd64-m64-gcc42-nn -i ./leslie3d.in 2>$SPEC06/output/437.txt
cd $SPEC06/benchspec/CPU2006/444.namd/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./namd_base.amd64-m64-gcc42-nn --input ./namd.input --iterations 1 --output ./namd.out 2>$SPEC06/output/444.txt
cd $SPEC06/benchspec/CPU2006/453.povray/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./povray_base.amd64-m64-gcc42-nn ./SPEC-benchmark-test.ini 2>$SPEC06/output/453.txt
cd $SPEC06/benchspec/CPU2006/454.calculix/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./calculix_base.amd64-m64-gcc42-nn -i ./beampic.inp 2>$SPEC06/output/454.txt
cd $SPEC06/benchspec/CPU2006/459.GemsFDTD/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./GemsFDTD_base.amd64-m64-gcc42-nn 2>$SPEC06/output/459.txt
cd $SPEC06/benchspec/CPU2006/465.tonto/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./tonto_base.amd64-m64-gcc42-nn 2>$SPEC06/output/465.txt
cd $SPEC06/benchspec/CPU2006/470.lbm/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./lbm_base.amd64-m64-gcc42-nn 20 ./reference.dat 0 1 ./100_100_130_cf_a.of 2>$SPEC06/output/470.txt
cd $SPEC06/benchspec/CPU2006/481.wrf/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./wrf_base.amd64-m64-gcc42-nn 2>$SPEC06/output/481.txt
cd $SPEC06/benchspec/CPU2006/482.sphinx3/run/run_base_test_amd64-m64-gcc42-nn.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./sphinx_livepretend_base.amd64-m64-gcc42-nn ./ctlfile . ./args.an4 2>$SPEC06/output/482.txt

# 454 481 482
