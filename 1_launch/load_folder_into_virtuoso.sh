#!/bin/bash

# This has to run in the root folder of all the datasourceS

ARGS=3

if [ $# -ne $ARGS ]
then
	echo "Usage: $0 <virtuoso-port> <data-folder-path> <graph-name>"
	exit -1
fi

PORT=$1

###########################################
# Load files

echo "### Loading data into virtuoso..."

isql-vt -S $PORT exec="ld_dir('$2', '%.ttl', '$3')"

isql-vt -S $PORT exec="DB.DBA.rdf_loader_run();"

# End
###########################################

echo "### Creating checkpoint for server $PORT..."
isql-vt -S $PORT exec="checkpoint"

