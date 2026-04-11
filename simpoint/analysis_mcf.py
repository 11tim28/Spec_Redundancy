# Copyright (c) 2024 The Regents of the University of California
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met: redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer;
# redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution;
# neither the name of the copyright holders nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

"""
Usage
-----

gem5 -re --outdir=simpoint-analysis-m5out analysis.py

"""

import argparse
from pathlib import Path

from gem5.components.boards.simple_board import SimpleBoard
from gem5.components.cachehierarchies.classic.private_l1_private_l2_walk_cache_hierarchy import (
    PrivateL1PrivateL2WalkCacheHierarchy,
)
from gem5.components.cachehierarchies.classic.no_cache import NoCache
from gem5.components.memory.single_channel import SingleChannelDDR3_1600
from gem5.components.processors.cpu_types import CPUTypes
from gem5.components.processors.simple_processor import SimpleProcessor
from gem5.isas import ISA
from gem5.simulate.simulator import Simulator
from gem5.resources.resource import BinaryResource
from gem5.utils.requires import requires

# binary_path = "/work/11141/yc35637/ls6/my_spec/spec2006/benchspec/CPU2006/401.bzip2/run/run_base_test_amd64-m64-gcc42-nn.0000/bzip2_base.amd64-m64-gcc42-nn"
binary_path = "/work/11141/yc35637/ls6/my_spec/spec2006/benchspec/CPU2006/429.mcf/run/run_base_test_amd64-m64-gcc42-nn.0000/mcf_base.amd64-m64-gcc42-nn"
# binary_path = "/work/11141/yc35637/ls6/my_spec/spec2006/benchspec/CPU2006/456.hmmer/run/run_base_test_amd64-m64-gcc42-nn.0000/hmmer_base.amd64-m64-gcc42-nn"
# input_path = "/work/11141/yc35637/ls6/my_spec/spec2006/benchspec/CPU2006/401.bzip2/run/run_base_test_amd64-m64-gcc42-nn.0000/input.program"
input_path = "/work/11141/yc35637/ls6/my_spec/spec2006/benchspec/CPU2006/429.mcf/run/run_base_test_amd64-m64-gcc42-nn.0000/inp.in"
# input_path = "/work/11141/yc35637/ls6/my_spec/spec2006/benchspec/CPU2006/456.hmmer/run/run_base_test_amd64-m64-gcc42-nn.0000/bombesin.hmm"

requires(isa_required=ISA.X86)

cache_hierarchy = NoCache()

memory = SingleChannelDDR3_1600(size="3GB")

processor = SimpleProcessor(
    cpu_type=CPUTypes.ATOMIC,
    isa=ISA.X86,
    num_cores=1,
)

processor.get_cores()[0].core.addSimPointProbe(1_000_000)

board = SimpleBoard(
    clk_freq="3GHz",
    processor=processor,
    memory=memory,
    cache_hierarchy=cache_hierarchy,
)

board.set_se_binary_workload(
    binary=BinaryResource(local_path=Path(binary_path).as_posix()),
    arguments=[input_path]
)


simulator = Simulator(
    board=board
)

simulator.run()

print("Simulation Done")