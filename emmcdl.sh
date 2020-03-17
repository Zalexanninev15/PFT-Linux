#!/bin/bash

cd tools/emmcdl
make
./emmcdl
read -r -p '-- press Enter to exit --'