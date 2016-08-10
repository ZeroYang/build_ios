readme

zwwx jsws unity项目ios构建脚本说明

##配置
config.cfg配置文件

使用打包脚本前，先配置渠道sdk路径，渠道信息等等，详见config.cfg文件


##渠道sdk接入代码

这部分包含xcode工程配置信息，比如ios的bundleID,version,Name等以及icon，splash，sdk接入代码

经常会修改有info.plist文件配置ios工程信息

sdk更新，接入代码修改

重点：
###SDK_Plugin   渠道sdk接入代码

由于sdk代码会包含资源bundle，代码src, framework等，以及渠道的cer 签名，这部分信息都会配置在SDK_Plugin目录



##copy.sh

拷贝sdk接入代码到xcode工程，并完成配置， SDK_Plugin/run.command xcode工程配置执行脚本



##build.sh

打包脚本，先读取配置，更新unity工程，导出xcode工程，执行copy.sh完成配置，使用xcodebuild编译xcode工程，xcrun导出ipa文件


##如何使用
 1.先完成配置config.cfg
 2.打开终端，cd到unity工程路径

 ```
Test:Test_Auto zwwx$ cd /Users/zwwx/work/projects/2016/TestUnity/Test_Auto 
Test:Test_Auto zwwx$ ./build_ios/build.sh 
 ```

 ##改进记录

 xcode打包签名cer配置

 xcodebuild 编译指定scheme（xgsdk 脚本会创建自己的scheme）

 ios 的dev/dis/adhoc包导出
 
