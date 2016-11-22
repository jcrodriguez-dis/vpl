#!/bin/bash
# Default C# language debug script for VPL
# Copyright (C) 2012 Juan Carlos Rodríguez-del-Pino
# License http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
# Author Juan Carlos Rodríguez-del-Pino <jcrodriguez@dis.ulpgc.es>

#load common script and check programs
. common_script.sh
export MONO_ENV_OPTIONS=--gc=sgen
check_program gdb
check_program mcs
#compile
mcs -debug -out:output.exe *.cs
if [ -f output.exe ] ; then
    echo "handle SIGXCPU SIG33 SIG35 SIGPWR nostop noprint" >> .dbinit
	cat common_script.sh > vpl_execution
	echo "export MONO_ENV_OPTIONS=--gc=sgen" >> vpl_execution
	echo "gdb -args mono --debug output.exe" >> vpl_execution
	chmod +x vpl_execution
fi
