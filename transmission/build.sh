#!/bin/sh


MODULE=transmission
VERSION="1.0"
TITLE=transmission
DESCRIPTION=超强的BT客户端~
HOME_URL=Module_transmission.asp

# Check and include base
DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"

# now include build_base.sh
. $DIR/../softcenter/build_base.sh

# change to module directory
cd $DIR

# do something here
do_build_result

# now backup
sh backup.sh $MODULE
