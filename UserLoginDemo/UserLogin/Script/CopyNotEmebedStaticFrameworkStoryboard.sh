#!/bin/sh

#  Script.sh
#  UserLoginDemo
#
#  Created by JateXu on 2020/6/4.
#  Copyright © 2020 JateXu IOS Team. All rights reserved.

# Type a script or drag a script file from your workspace to insert its path.

## - Functions
function createDirIfNeed()
{
    inputDir=$1
    if [ ! -d "${inputDir}" ]
    then
        mkdir ${inputDir}
        echo "The directory has been created. "${inputDir}
    fi
}

function copyFiles()
{
    inputDir=$1; fileType=$2; targetDir=$3

    xx=$( createDirIfNeed ${targetDir} )

    searchFiles=$( find ${inputDir} -name "*.${fileType}" )
    #echo ${searchFiles}

    for file in ${searchFiles}
    do
        filename=$( basename ${file} )

        targetFullPath=${targetDir}"/"${filename}
        #echo ${targetFullPath}

        if [ -f ${targetFullPath} ] || [ -d ${targetFullPath} ]
        then
            echo `======请检查冲突文件：${filename}=======`
            echo `======请检查冲突文件：${filename}=======`
            echo `======请检查冲突文件：${filename}=======`
            return 1
        else
            $( cp -rf ${file} ${targetDir})
            #echo "The file has beed copied to target directory. "${file}
        fi

    done
    return 0
}


## - Call

echo "WTF -------------"
echo "Configration: "${CONFIGURATION}   # Debug / Release
echo "Target App Dir: ${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app"
echo "Input File Count: "${SCRIPT_INPUT_FILE_COUNT}

echo "App Build Dir: "${BUILD_DIR}                           # <XXX>/Build/Products/
echo "Config Build Dir: "${CONFIGURATION_BUILD_DIR}             # <XXX>/Build/Products/Debug-iphoneos
#echo ${SRCROOT}
echo "Only Resource Folder? "${UNLOCALIZED_RESOURCES_FOLDER_PATH}   # UserLoginDemo.app

targetDir="${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
echo "Target Path ===>>>> "${targetDir}

for (( index=0 ; index<${SCRIPT_INPUT_FILE_COUNT}; index++ )) {
    inputFrameworkString="SCRIPT_INPUT_FILE_"${index}
    inputFramework=`eval echo '$'"$inputFrameworkString"`
    echo "Input Framework: "${inputFramework}     # echo ${SCRIPT_INPUT_FILE_0}

    $( copyFiles ${inputFramework} "storyboardc" ${targetDir} )
    result=$?   # 奇葩的获取函数返回值
    if [ result != 0 ]
    then
        break
    fi

}

echo "------------- WTF"

## - Help

### 如果需要检查Copy过程中 存在冲突问题，就使用下面这条语句。
#exit ${result}

### 一般来说 正常开发过程中，不需要检查冲突问题。所以使用下面正常退出
exit 0
