#!/bin/sh

#  Script.sh
#  UserLoginDemo
#
#  Created by JateXu on 2020/6/4.
#  Copyright © 2020 JateXu IOS Team. All rights reserved.

# Type a script or drag a script file from your workspace to insert its path.
echo "WTF"
echo ${BUILD_DIR}                           # <XXX>/Build/Products/
echo ${CONFIGURATION_BUILD_DIR}             # <XXX>/Build/Products/Debug-iphoneos
#echo ${SRCROOT}
echo ${UNLOCALIZED_RESOURCES_FOLDER_PATH}   # UserLoginDemo.app

targetDir=${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/
echo ${targetDir}

sourcefile=${CONFIGURATION_BUILD_DIR}/UserLogin.framework/UserLogin.storyboardc
cp -r ${sourcefile} ${targetDir}
