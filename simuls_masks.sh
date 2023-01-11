#!/bin/bash

n_max=50; n_iter=10;

#     ----------------------------------
#        Mask wearing in public places
#     ----------------------------------


# Lille
# work leisure shop education primary home bus tram rail subway
# 1    2       3    4         5       6    7   8    9    10

# Only public transport
n_dir=1; x0=703744; y0=7059180;
oarsub -S "sh/simulate.sh $n_dir $n_iter .1 .3 1 0.08 0.009 0.15 0.21 0.12 0.09 0.175 $x0 $y0 $n_max"

