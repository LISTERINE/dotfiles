#!/bin/bash

# Setup stuff before we install any packages
# proxies, etx...
if [ -a ./res/pre_stage1.sh ]
    then
    source ./res/pre_stage1.sh
fi
if [ -a ./res/pre_stage2.sh ]
    then
    source ./res/pre_stage2.sh
fi
