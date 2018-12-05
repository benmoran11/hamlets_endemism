#!/bin/bash

INDIR=$WORK/3_output/3.11_smcpp_raw
OUTDIR=$WORK/3_output/3.12_smcpp_graphs

smc++ plot --csv $OUTDIR/allmaybel_estimate.withpeaks.plot.pdf $INDIR/maybel/allmaybel_estimate.withpeaks.out/model.final.json

smc++ plot --csv $OUTDIR/allmaybel_estimate.nopeaks.plot.pdf $INDIR/maybel/allmaybel_estimate.nopeaks.out/model.final.json


smc++ plot --csv $OUTDIR/allpuebel_estimate.withpeaks.plot.pdf $INDIR/puebel/allpuebel_estimate.withpeaks.out/model.final.json

smc++ plot --csv $OUTDIR/allpuebel_estimate.nopeaks.plot.pdf $INDIR/puebel/allpuebel_estimate.nopeaks.out/model.final.json


smc++ plot --csv $OUTDIR/allnigbel_estimate.withpeaks.plot.pdf $INDIR/nigbel/allnigbel_estimate.withpeaks.out/model.final.json

smc++ plot --csv $OUTDIR/allnigbel_estimate.nopeaks.plot.pdf $INDIR/nigbel/allnigbel_estimate.nopeaks.out/model.final.json


smc++ plot --csv $OUTDIR/allunibel_estimate.withpeaks.plot.pdf $INDIR/unibel/allunibel_estimate.withpeaks.out/model.final.json

smc++ plot --csv $OUTDIR/allunibel_estimate.nopeaks.plot.pdf $INDIR/unibel/allunibel_estimate.nopeaks.out/model.final.json


smc++ plot --csv $OUTDIR/allgemflo_estimate.withpeaks.plot.pdf $INDIR/gemflo/allgemflo_estimate.withpeaks.out/model.final.json

smc++ plot --csv $OUTDIR/allgemflo_estimate.nopeaks.plot.pdf $INDIR/gemflo/allgemflo_estimate.nopeaks.out/model.final.json

echo done

