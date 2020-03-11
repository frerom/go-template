#!/bin/bash
set -e
set -x

$PROGRAM &> actual_output.txt
diff actual_output.txt expected_output.txt
