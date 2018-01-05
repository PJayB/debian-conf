#!/bin/sh
sh -c "dumpkeys | grep -Ev '(In|De)cr_Console' | loadkeys"
