#!/bin/bash

cd tools/emmcdl
make
./emmcdl
read -r -p '-- Press Enter to exit --'