# SFBackgroundTaskManager

[![CI Status](https://img.shields.io/travis/Sfh03031/SFBackgroundTaskManager.svg?style=flat)](https://travis-ci.org/Sfh03031/SFBackgroundTaskManager)
[![Version](https://img.shields.io/cocoapods/v/SFBackgroundTaskManager.svg?style=flat)](https://cocoapods.org/pods/SFBackgroundTaskManager)
[![License](https://img.shields.io/cocoapods/l/SFBackgroundTaskManager.svg?style=flat)](https://cocoapods.org/pods/SFBackgroundTaskManager)
[![Platform](https://img.shields.io/cocoapods/p/SFBackgroundTaskManager.svg?style=flat)](https://cocoapods.org/pods/SFBackgroundTaskManager)

## Introduction

在TARGETS -> Signing & Capabilities -> Backgound Modes 勾选【Audio,AirPlay,and Picture in Picture】

在进入后台方法里调用 `SFBackgroundTaskManager.shared.start()`，进入前台方法里调用 `SFBackgroundTaskManager.shared.stop()`

为节省设备电量，默认保活两小时后自动取消保活，可自定义保活时长、是否自动取消保活。

###### 原理: 

在App退到后台时申请时间(系统限制一般为30秒)执行一段后台任务(播放无声音乐)并返回任务id，任务结束的回调中必须结束该后台任务，否则系统会杀死App。

在结束回调中再次申请时间执行一段后台任务，系统会开始新的申请，重复此过程以达到保活的目的。

###### 注意：

1.被挂起的程序，在系统资源不够的时候也会被杀死。

2.如果应用退到后台长时间不被杀死，长时间静默播放无声音频会累积消耗大量的设备电量，风险自行评估。

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 12.0 or later
* Swift 5.9.2
* Xcode 15.1

## Installation

SFBackgroundTaskManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SFBackgroundTaskManager', :git => 'https://github.com/Sfh03031/SFBackgroundTaskManager.git'
```

## Author

  Sfh03031, sfh894645252@163.com

## License

SFBackgroundTaskManager is available under the MIT license. See the LICENSE file for more info.
