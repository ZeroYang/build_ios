#!/bin/bash

Cur_Dir=$(pwd)
echo $Cur_Dir

Base_Path=$Cur_Dir


source ${Base_Path}/build_ios/config.cfg

# ----------------------------------------------------------------------------------------------------
# sdk_plugin_dir=/Users/zwwx/work/projects/2016/ios_project/xlj_zwwx
# #build.sh channel=1 url=http://192.168.1.211/jsws_res/ output=/user/..../xcode-project/ debug=false 
# channel=1
# url=http://192.168.1.211/jsws_res/
# project=Unity_iPhone
# debug=false
# ----------------------------------------------------------------------------------------------------

# echo "sdk_plugin_dir=$sdk_plugin_dir"
# echo "channel=$channel"
# echo "url=$url"
# echo "project=$project"
# echo "ipa_name=$ipa_name"


echo "-----------svn up $Base_Path-----------"

cd "${Base_Path}/Assets/Resources/UI/Login"
svn up

cd "${Base_Path}/Assets/Scene"
svn up

cd "${Base_Path}/Assets/NGUI"
svn up

cd "${Base_Path}/Assets/Script"
svn up

cd "${Base_Path}/Assets/Plugins"
svn up

#svn update

# #打包工程的Resources/UI只保留Login目录
# rm -r "${Base_Path}/Assets/Resources/UI/Atlas"
# rm -r "${Base_Path}/Assets/Resources/UI/mat"
# rm -r "${Base_Path}/Assets/Resources/UI/texture"
# rm -r "${Base_Path}/Assets/Resources/UI/txt"
# rm -r "${Base_Path}/Assets/Resources/UI/UIPrefab"
# rm -r "${Base_Path}/Assets/Resources/UI/animation"
# rm -r "${Base_Path}/Assets/Resources/UI/UIScenes"

# rm -r "${Base_Path}/Assets/Resources/UI/Atlas.meta"
# rm -r "${Base_Path}/Assets/Resources/UI/mat.meta"
# rm -r "${Base_Path}/Assets/Resources/UI/texture.meta"
# rm -r "${Base_Path}/Assets/Resources/UI/txt.meta"
# rm -r "${Base_Path}/Assets/Resources/UI/UIPrefab.meta"
# rm -r "${Base_Path}/Assets/Resources/UI/animation.meta"
# rm -r "${Base_Path}/Assets/Resources/UI/UIScenes.meta"

echo "更新成功"

UNITY_PATH=/Applications/Unity/Unity.app/Contents/MacOS/Unity

#导出xcode工程
$UNITY_PATH -projectPath $Base_Path -executeMethod AutoBuildForIOS.BuildForIOS  -quit channel=$channel url=$url project=$project debug=$debug

echo "xcode工程生成完毕"
echo "-----------------"

#xcode 工程路径
XCODE_PROJ_PATH=${Base_Path}/$project

#根据渠道配置xcode工程 渠道sdk 包信息 icon 等
#根据channel找出对应的渠道
#buildsetting.sh
setting_ios_path=${Base_Path}/build_ios/copy.sh

# echo "-----------------copy&install sdk plugin src-----------------"
# echo "copy sdk plugin src"
# echo "install sdk plugin"
# $setting_ios_path $sdk_plugin_dir  $XCODE_PROJ_PATH


# #开始xcode 工程build生成ipa
# echo "-----------------start xcodebuild-----------------"

#待处理问题
##xcode cer 签名

echo "xcode-project path= $XCODE_PROJ_PATH"


XCODE_BUILD_PATH=$XCODE_PROJ_PATH/build

#ipa_name 使用传人的 project name
#ipa_name=$project

#编译xcode工程
cd $XCODE_PROJ_PATH
echo $(pwd)

#clean#
echo "-----------------xcodebuild clean-----------------"
xcodebuild clean

#xcodebuild || exit
# echo "-----------------end xcodebuild-----------------"

# #打包#
# echo "-----------------start export ipa-----------------"
# #导出的ipa文件放在unity工程的根目录
# xcrun -sdk iphoneos PackageApplication -v ${XCODE_BUILD_PATH}/Release-iphoneos/*.app -o ${Base_Path}/${ipa_name}.ipa
# echo "-----------------end export ipa-----------------"

# echo "-----------------success----------------"

PROJECT_NAME=$project
SCHEME_NAME=${sdk_channelName}_${project}

echo "dev profile name = ${DEV_PROFILE_NAME}"
echo "dis profile name = ${DIS_PROFILE_NAME}"

DATE=$(date +%Y%m%d%H%M)

#如果没有sdk_channelName，则scheme默认使用Project_Name
if [[ ! -n "${sdk_channelName}" ]]; then
	SCHEME_NAME=$project
fi

echo "SCHEME_NAME = ${SCHEME_NAME}"

#archive
xcodebuild archive -project ${PROJECT_NAME}.xcodeproj \
                   -scheme ${SCHEME_NAME} \
                   -destination generic/platform=iOS \
                   -archivePath bin/${PROJECT_NAME}.xcarchive

#export dev ipa
xcodebuild -exportArchive -archivePath bin/${PROJECT_NAME}.xcarchive \
                          -exportPath bin/Dev_${ipa_name}_${DATE} \
                          -exportFormat ipa \
                          -exportProvisioningProfile ${DEV_PROFILE_NAME}     

#export dis ipa
xcodebuild -exportArchive -archivePath bin/${PROJECT_NAME}.xcarchive \
                          -exportPath bin/Dis_${ipa_name}_${DATE} \
                          -exportFormat ipa \
                          -exportProvisioningProfile ${DIS_PROFILE_NAME}          
