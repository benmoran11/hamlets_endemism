#!/bin/bash

# This loop submits every script for the creation of "multihetsep" files for MSMC cross-coalescence analysis.
# One scripts exists for each pairwise comparison between species (10 total)

cd 3-8_crosscoal_genHetSep/

for i in $( ls ./*genHetSep.sh); do
qsub $i;
done
