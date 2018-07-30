
AMLocalizedStringBuilder
==================

<p align="left">

<a href="https://travis-ci.org/MellongLau/AMLocalizedStringBuilder-Xcode-Plugin"><img src="https://travis-ci.org/MellongLau/AMLocalizedStringBuilder-Xcode-Plugin.svg" alt="Build Status" /></a>
<img src="https://img.shields.io/badge/platform-Xcode%206%2B-blue.svg?style=flat" alt="Platform: Xcode 6+"/>
<img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat" alt="License: MIT" />

</p>

AMLocalizedStringBuilder is the localized string helper which help you build your loacalized string file `Localizable.strings` to object-c class `AMLocalizedString`, and you can use your localized string key by `R_String.am_<#your_localized_string_key#>`, the shortcut key is `ctrl+f`.

> *AMLocalizedStringBuilder 是可以帮助你将语言本地化文件`Localizable.strings`生成object-c的类`AMLocalizedString`的Xcode插件，这样可以直接使用`R_String.am_<#你的本地化字符串key#>`获取对应key的值，还可以随时点击`Alt`或`Option`按键查看当前字符串的值。*  
**如果觉得这款插件不错的话请点击右上角的star和推荐给你的朋友，如果想即时了解到我的最新消息，请拉到底部扫描二维码关注我的公众号。**

## Usage
1. Click Xcode Menu `Product`->`AMLocalizedStringBuilder`->`Build Localized String` or use shortcut `ctrl+f` to build the `Localizable.strings` file.  
2. Open your project folder will find these two files: `AMLocalizedString.h` and `AMLocalizedString.m`, add these two files reference to your project.  
3. Import `AMLocalizedString.h` and use `R_String.am_<#your_localized_string_key#>` to get the localized string.   
4. On the other hand, you can use shortcut `ctrl+cmd+s` to show the setting window, choose the target localizable string file you want to build, and click `ctrl+f` to build.  

> *1. 点击Xcode顶部菜单 `Product`->`AMLocalizedStringBuilder`->`Build Localized String` 或者直接用快捷键 `ctrl+f` 来把`Localizable.strings`生成为object-c类。*  
  *2. 打开你当前项目文件夹，可以找到已经生成好的 `AMLocalizedString.h` and `AMLocalizedString.m` 这两个文件，把他们直接拉到项目中添加引用。*  
*3. 在要用到的地方先导入头文件 `AMLocalizedString.h`， 然后使用`R_String.am_<#your_localized_string_key#>`来获取对应本地化的文字。*  
*4. 另外，你还可以用快捷键`ctrl+cmd+s`打开设置窗口，在设置窗口里面选择你要进行转换的`Localizable.strings`文件。*

![screenshot.gif](https://raw.github.com/MellongLau/AMLocalizedStringBuilder-Xcode-Plugin/master/Screenshots/screenshot.gif)

## Install

You can:

Install from github.

* Get the source code from github

`$ git clone git@github.com:MellongLau/AMLocalizedStringBuilder-Xcode-Plugin.git`

* Build the AMLocalizedStringBuilder target in the Xcode project and the plug-in will automatically be installed in `~/Library/Application Support/Developer/Shared/Xcode/Plug-ins`.
* Relaunch Xcode.

or

Install via [Alcatraz](http://alcatraz.io/)

In any case, relaunch Xcode to load it.


## Support

Developed and tested against Xcode 6+.

For Xcode7.1, you may need to run shell script:
```shell
find ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins -name Info.plist -maxdepth 3 | xargs -I{} defaults write {} DVTPlugInCompatibilityUUIDs -array-add defaults read /Applications/Xcode.app/Contents/Info DVTPlugInCompatibilityUUID

sudo xcode-select --reset

defaults delete com.apple.dt.Xcode DVTPlugInManagerNonApplePlugIns-Xcode-7.1

```

Or download and execute this [script](https://github.com/cielpy/RPAXU) to add your current Xcode DVTPlugInCompatibilityUUID to all the Xcode plugins.

## More
Learn more? Follow my `WeChat` public account `mellong`:  
*想了解更多？请关注我的微信公众号 `mellong`, 扫描下面二维码进行关注即可。*

![WeChat QRcode](http://www.devlong.com/blogImages/qrcode_for_mellong.jpg)

## License

MIT License

Copyright (c) 2016 Mellong Lau

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
