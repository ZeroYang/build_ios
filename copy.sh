#!/bin/bash
echo "sdk plugin path: $1"
echo "xcode_project path: $2"
echo "add plugin-----------------------"
plugin_dir=$1

xcode_project_path=$2

# if [[$# < 1]];then
# 	echo "input sdk path"
# fi

#update plugin
#svn update $plugin_dir
#当前目录
echo "xcode_project_path : ${xcode_project_path}"
#拷贝 cp "资源位置" "目标位置"
cp -f "${plugin_dir}/info.plist" "${xcode_project_path}/info.plist"
echo "复制info.plist成功"
cp -f "${plugin_dir}/Classes/UnityAppController.mm" "${xcode_project_path}/Classes/UnityAppController.mm"
echo "复制UnityAppController.mm成功"
cp -f "${plugin_dir}/LaunchScreenImage-Landscape.png" "${xcode_project_path}/LaunchScreenImage-Landscape.png"
echo "复制LaunchScreenImage-Landscape.png成功"
cp -f "${plugin_dir}/LaunchScreenImage-Portrait.png" "${xcode_project_path}/LaunchScreenImage-Portrait.png"
echo "复制LaunchScreenImage-Portrait.png成功"
cp -f -r "${plugin_dir}/Unity-iPhone" "${xcode_project_path}"
echo "复制Unity-iPhone成功"

#是否有SDK_Plugin目录
if [[ -d  ${plugin_dir}/SDK_Plugin ]]; then
	cp -f -r "${plugin_dir}/SDK_Plugin" "${xcode_project_path}"
	echo "复制SDK_Plugin成功"
	#执行install
	cd $xcode_project_path
	#SDK_Plugin/run.command
	echo 'pkg begin...'
	LANG="zh_CN.UTF-8"
	pwd

	target=${xcode_project_path}/SDK_Plugin

	cd $target
	pwd

	ruby ./run.rb $target
	# touch step1_ok.txt
	echo 'pkg end...'
fi
