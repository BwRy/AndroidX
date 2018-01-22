#!/bin/sh
#
# This script is used to retrieve a bootchart log generated by init.
# All options are passed to adb, for better or for worse.
# See the readme in this directory for more on bootcharting.

TMPDIR=/tmp/android-bootchart
rm -rf $TMPDIR
mkdir -p $TMPDIR

LOGROOT=/data/bootchart
TARBALL=bootchart.tgz

FILES="header proc_stat.log proc_ps.log proc_diskstats.log kernel_pacct"

for f in $FILES; do
    adb "${@}" pull $LOGROOT/$f $TMPDIR/$f 2>&1 > /dev/null
done
(cd $TMPDIR && tar -czf $TARBALL $FILES)
# bootchart ${TMPDIR}/${TARBALL}
