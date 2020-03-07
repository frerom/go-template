#!/bin/bash
set -e
set -x

PROGRAM=$(cat ../../go/.program)

$PROGRAM &> actual_output.txt
diff actual_output.txt expected_output.txt
