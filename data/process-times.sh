#!/bin/bash

for file in trap.log.*
do
    ./process-intervals.pl $file >> intervals.2.csv
done
