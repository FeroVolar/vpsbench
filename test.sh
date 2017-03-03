#!/bin/bash

#==============================================================================
# Copyright (c) 2017 Fero Volar <alian@alian.info>
#
# Licensed under The MIT License
#==============================================================================

echo "Please enter VPS provider name"
echo "for example WS1, DO1, AMZ1, etc: "
read VPSname
#echo "You entered: $input_variable"

if [ -x /usr/bin/sysbench ]; then
    echo "Benchmark running, this take some time..."
    cat /proc/cpuinfo >> $VPSname.log
    echo "==========================================================" >> $VPSname.log
    cat /proc/meminfo >> $VPSname.log
    echo "==========================================================" >> $VPSname.log
    sysbench --test=cpu run >> $VPSname.log
    echo "==========================================================" >> $VPSname.log
    sysbench --test=memory run >> $VPSname.log
    echo "==========================================================" >> $VPSname.log
    sysbench --test=memory --memory-oper=write run >> $VPSname.log
    echo "==========================================================" >> $VPSname.log
    sysbench --test=fileio prepare
    sysbench --test=fileio --file-test-mode=rndrw run >> $VPSname.log
    sysbench --test=fileio cleanup
    echo "==========================================================" >> $VPSname.log
    echo "DONE!" >> $VPSname.log
    echo "DONE! Outupt in file $VPSname.log"
else
    echo "Installing sysbench"
    apt install sysbench
    echo "Please run this script again"
fi
