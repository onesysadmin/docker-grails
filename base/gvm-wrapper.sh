#!/bin/bash

# A quick wrapper to source the gvm env and run it
# This is used to run gvm in Dockerfile RUN commands
# since the RUN commands does not use interactive shells

[[ -s "//.gvm/bin/gvm-init.sh" ]] && source "//.gvm/bin/gvm-init.sh" && gvm $@
