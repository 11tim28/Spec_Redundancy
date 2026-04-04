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

#SBATCH -J perf2017fp                        # Job name
#SBATCH -o perf2017fp.o%j                    # Name of stdout output file (%j corresponds to the job id)
#SBATCH -e perf2017fp.e%j                    # Name of stderr error file (%j corresponds to the job id)
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
cd $SPEC17/benchspec/CPU/503.bwaves_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./bwaves_r_base.mytest-m64 bwaves_1 < bwaves_1.in > bwaves_1.out 2>> bwaves_1.err  2>$SPEC17/output/503.txt

cd $SPEC17/benchspec/CPU/507.cactuBSSN_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./cactusBSSN_r_base.mytest-m64 spec_test.par   > spec_test.out 2>> spec_test.err  2>$SPEC17/output/507.txt

cd $SPEC17/benchspec/CPU/508.namd_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./namd_r_base.mytest-m64 --input apoa1.input --iterations 1 --output apoa1.test.output > namd.out 2>> namd.err  2>$SPEC17/output/508.txt

cd $SPEC17/benchspec/CPU/511.povray_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./povray_r_base.mytest-m64 SPEC-benchmark-test.ini > SPEC-benchmark-test.stdout 2>> SPEC-benchmark-test.stderr  2>$SPEC17/output/511.txt

cd $SPEC17/benchspec/CPU/519.lbm_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./lbm_r_base.mytest-m64 20 reference.dat 0 1 100_100_130_cf_a.of > lbm.out 2>> lbm.err  2>$SPEC17/output/519.txt

cd $SPEC17/benchspec/CPU/521.wrf_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./wrf_r_base.mytest-m64 > rsl.out.0000 2>> wrf.err  2>$SPEC17/output/521.txt

cd $SPEC17/benchspec/CPU/526.blender_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./blender_r_base.mytest-m64 cube.blend --render-output cube_ --threads 1 -b -F RAWTGA -s 1 -e 1 -a > cube.1.spec.out 2>> cube.1.spec.err  2>$SPEC17/output/526.txt

cd $SPEC17/benchspec/CPU/527.cam4_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./cam4_r_base.mytest-m64 > cam4_r_base.mytest-m64.txt 2>> cam4_r_base.mytest-m64.err  2>$SPEC17/output/527.txt

cd $SPEC17/benchspec/CPU/538.imagick_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./imagick_r_base.mytest-m64 -limit disk 0 test_input.tga -shear 25 -resize 640x480 -negate -alpha Off test_output.tga > test_convert.out 2>> test_convert.err  2>$SPEC17/output/538.txt

cd $SPEC17/benchspec/CPU/544.nab_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./nab_r_base.mytest-m64 hkrdenq 1930344093 1000 > hkrdenq.out 2>> hkrdenq.err  2>$SPEC17/output/544.txt

cd $SPEC17/benchspec/CPU/549.fotonik3d_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./fotonik3d_r_base.mytest-m64 > fotonik3d_r.log 2>> fotonik3d_r.err  2>$SPEC17/output/549.txt

cd $SPEC17/benchspec/CPU/554.roms_r/run/run_base_test_mytest-m64.0000/
perf stat -e instructions,all_data_cache_accesses,l2_cache_misses_from_dc_misses,l2_cache_accesses_from_dc_misses,l1_dtlb_misses,L1-dcache-load-misses ./roms_r_base.mytest-m64 < ocean_benchmark0.in.x > ocean_benchmark0.log 2>> ocean_benchmark0.err  2>$SPEC17/output/554.txt


# 454 481 482
