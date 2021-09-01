#!/bin/bash

if [ ! $(command -v singularity) ]; then
        module load singularity
fi

singularity pull https://depot.galaxyproject.org/singularity/raven-assembler:1.5.1--h2e03b76_0
mv -v raven*0 singularity-raven-1.5.1.sif
