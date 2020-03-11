#!/bin/bash
set -e
set -x

PROGRAM=$(cat ../../src/.program)

$PROGRAM &> actual_output.txt
diff actual_output.txt expected_output.txt
