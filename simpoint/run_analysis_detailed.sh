#!/bin/bash

echo "[*] Starting SimPoint analysis & full detailed run for all workloads..."

(
    /work/11141/yc35637/ls6/project/gem5/build/X86/gem5.opt -re --outdir=/work/11141/yc35637/ls6/Lab4/simpoint/analysis/bzip2-analysis-m5out /work/11141/yc35637/ls6/Lab4/simpoint/analysis_bzip2.py 
) &

(
    /work/11141/yc35637/ls6/project/gem5/build/X86/gem5.opt -re --outdir=/work/11141/yc35637/ls6/Lab4/simpoint/analysis/hmmer-analysis-m5out /work/11141/yc35637/ls6/Lab4/simpoint/analysis_hmmer.py  
) &

(
    /work/11141/yc35637/ls6/project/gem5/build/X86/gem5.opt -re --outdir=/work/11141/yc35637/ls6/Lab4/simpoint/analysis/mcf-analysis-m5out /work/11141/yc35637/ls6/Lab4/simpoint/analysis_mcf.py 
) &

(
   /work/11141/yc35637/ls6/project/gem5/build/X86/gem5.opt -re --outdir=/work/11141/yc35637/ls6/Lab4/simpoint/full_detailed/bzip2-full-detailed-run-m5out /work/11141/yc35637/ls6/Lab4/simpoint/full_detailed_run_bzip2.py 
) &

(
   /work/11141/yc35637/ls6/project/gem5/build/X86/gem5.opt -re --outdir=/work/11141/yc35637/ls6/Lab4/simpoint/full_detailed/hmmer-full-detailed-run-m5out /work/11141/yc35637/ls6/Lab4/simpoint/full_detailed_run_hmmer.py 
) &

(
   /work/11141/yc35637/ls6/project/gem5/build/X86/gem5.opt -re --outdir=/work/11141/yc35637/ls6/Lab4/simpoint/full_detailed/mcf-full-detailed-run-m5out /work/11141/yc35637/ls6/Lab4/simpoint/full_detailed_run_mcf.py 
) &

wait
echo "[*] All workloads completed SimPoint analysis & full detailed run."
