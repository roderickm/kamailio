#!/bin/bash
#
# This shell script allows runit to manage a non-daemonized app 
# under baseimage-docker. The Dockerfile should add this script 
# to the container as /etc/service/<NAME>/run

# Default amount of shared memory in megabytes allocated
# Used by all kamailio processes, allocated per kamailio instance
# Override this value with a docker run variable:
#    docker run -dt kamailio -e 'KAMAILIO_SHM=512'
shm_mem=${KAMAILIO_SHM-64}
# Default amount of private memory in megabytes allocated
# Used by one kamailio process, allocated for each kamailio process
# Override this value with a docker run variable:
#    docker run -dt kamailio -e 'KAMAILIO_PKG=24'
pkg_mem=${KAMAILIO_PKG-16}

exec /sbin/setuser kamailio kamailio -M ${pkg_mem} -m ${shm_mem} -DD -E -e
