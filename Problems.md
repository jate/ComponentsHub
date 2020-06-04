# 目前在项目中遇到的问题

## 1、当UserLogin.framework作为静态库链接至 UserLoginDemo.app时，丢失其中的Storyboard文件，导致最终运行崩溃。

解决办法有以下几个：

* 0x01：将UserLogin.framework作为静态库，且**Emebed**至 *.app中去。然后在库中使用如下代码访问：
	
	```
let path = Bundle.main.path(forResource: "UserLogin", ofType: "framework", inDirectory: "Frameworks")
let userLoginFramework = Bundle.init(path: path!)!
let storyboard = UIStoryboard.init(name: "UserLogin", bundle: userLoginFramework)
let viewController = storyboard.instantiateViewController(withIdentifier: "UserLoginViewController")
	```
	
* 0x02：将UserLogin.framework作为**动态库**，且需要Emebed。然后依然可以按 0x01条方法在库中使用。

* 0x02：UserLogin.framework本来是静态库，为什么要Emebed？其主要目的是方便Copy Storyboard文件。。。是不是有些无语？是的，Xcode不能自动cp一下storyboard文件吗？

	* [link-framework-storyboard-for-main-project](https://stackoverflow.com/questions/19954771/ios-linking-framework-storyboard-to-viewcontroller-for-use-in-main-project) 
	* [-force_load](https://stackoverflow.com/questions/10809304/alternative-for-all-load-in-xcodes-other-linker-flags)
	* 这上面两个方法，似乎都没有解决？？？况且all\_load或者force\_load是不是有点狠了？所以如果还想完美解决问题，请往下看。
	
* 0x04：_既然只是需要*.storyboard文件，那么直接使用脚本Cp就是了。。。_具体如下：

	* 要Cp的是XX.framework编译后的 *.storyboardc 文件。注意这里是待后缀 c的。
	* 然后找到主工程的Build Phases，在Link Binary With Libraries后面new一个Run Script Phase。（**注意Link Binary With Libraries中，已经存在UserLogin.framework，且NOT Emebed，且还依然是Static Library类型**）
	* 然后添加如下脚本：

		```
		echo ${BUILD_DIR}                           # <XXX>/Build/Products/
echo ${CONFIGURATION_BUILD_DIR}             # <XXX>/Build/Products/Debug-iphoneos
echo ${UNLOCALIZED_RESOURCES_FOLDER_PATH}   # UserLoginDemo.app
sourcefile=${CONFIGURATION_BUILD_DIR}/UserLogin.framework/UserLogin.storyboardc
targetDir=${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/
cp -r ${sourcefile} ${targetDir}
		```

	* 这样UserLogin.storyboardc 就Cp到了主工程的Bundle中。所以在使用时，就跟主工程里面的Storyboard一样使用了。
	* 最后，也是最重要的一条：**关闭Xcode，删除DerivedData，再从新Build！关闭Xcode，删除DerivedData，再从新Build！关闭Xcode，删除DerivedData，再从新Build！**

* 0x05：这里的UserLogin.framework是非pod库，如果变成pod库，并添加.bundle_resource应该就问题不大。。。。:( 就是太爱折腾自己了~ ):

## 2、...