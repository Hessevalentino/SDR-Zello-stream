#!/bin/bash

#python3 zellostreamer.py
#rtl_fm -M fm -f 439000000 -g 45 -s 48k -l 50  | python3 stdinpythonclient.py
rtl_fm -M fm -f 439000000 -g 45 -s 48k -l 50 | python3 stdinpythonclient.py
