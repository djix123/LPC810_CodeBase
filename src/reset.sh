#! /bin/bash

/Users/jgiles/tools/openocd/bin/openocd -f interface/cmsis-dap.cfg -f target/lpc8xx-jg.cfg -c "init" -c 'reset run' -c "exit"

