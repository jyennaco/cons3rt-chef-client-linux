#!/bin/bash

# Created by Joe Yennaco (8/26/14)

# Set log commands
logTag=chef-client
logInfo="logger -i -s -p local3.info -t ${logTag} [INFO] "
logWarn="logger -i -s -p local3.warning -t ${logTag} [WARNING] "
logErr="logger -i -s -p local3.err -t ${logTag} [ERROR] "

# Get the current timestamp and append to logfile name
TIMESTAMP=$(date "+%Y-%m-%d-%H%M")
LOGFILE=/var/log/cons3rt-${logTag}-${TIMESTAMP}.log

########################## USER VARIABLES ########################## 

# None

######################## END USER VARIABLES ########################

function install-chef-client() {

    ${logInfo} "Beginning Chef Client install ..."
    ${logInfo} "Timestamp: ${TIMESTAMP}"

    ${logInfo} "Installing Chef Client ..."
    curl -L https://www.opscode.com/chef/install.sh | bash

    RESULT=`chef-client --version`
    ${logInfo} "Checking chef-client version: ${RESULT}"

    ${logInfo} "Creating directory: /etc/chef ..."
    mkdir -p /etc/chef

    ${logInfo} "Completed Chef Client install!"
}

install-chef-client 2>&1 | tee ${LOGFILE}

chmod 644 ${LOGFILE}

exit 0

