#! /bin/bash

/Users/jgiles/tools/openocd/bin/openocd -f interface/cmsis-dap.cfg -f target/lpc8xx-jg.cfg -c 'program ./build/blinky.bin 0x00000000' -c 'sleep 200' -c 'reset run' -c 'exit'

