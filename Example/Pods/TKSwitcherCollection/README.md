# TKSwitcherCollection
> An animate switch collection

![Xcode 9.0+](https://img.shields.io/badge/Xcode-9.0%2B-blue.svg)
![iOS 8.0+](https://img.shields.io/badge/iOS-8.0%2B-blue.svg)
![Swift 4.0+](https://img.shields.io/badge/Swift-4.0%2B-orange.svg)
[![Build Status](https://travis-ci.org/TBXark/TKSwitcherCollection.svg?branch=master)](https://travis-ci.org/TBXark/TKRubberIndicator)
[![CocoaPods](http://img.shields.io/cocoapods/v/TKSwitcherCollection.svg?style=flat)](http://cocoapods.org/?q=TKSwitcherCollection)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/TBXark/TKSwitcherCollection/master/LICENSE)

## Requirements

- iOS 8.0+
- Xcode 9.0
- Swift 4.0

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `TKSwitcherCollection` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'TKSwitcherCollection'
```

To get the full benefits import `TKSwitcherCollection` wherever you import UIKit

``` swift
import UIKit
import TKSwitcherCollection
```
#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/TKSwitcherCollection.framework` to an iOS project.

```shell
github "tbxark/TKSwitcherCollection"
```
#### Manually
1. Download and drop ```TKSwitcherCollection``` in your project.  
2. Congratulations!  

## Usage example

|Class|Example|
|---|---|
|TKSimpleSwitch|<img src="Images/simple.gif" style="height:200;width:auto">|  
|TKSimpleSwitch|<img src="Images/simple2.gif" style="height:200;width:auto">|  
|TKExchangeSwitch|<img src="Images/exchange.gif" style="height:200;width:auto">|  
|TKSmileSwitch|<img src="Images/smile.gif" style="height:200;width:auto">|  
|TKLiquidSwitch|<img src="Images/liquid.gif" style="height:200;width:auto">|  


## Release History
* 1.4.2
    add `IBDesignable`/`IBInspectable` support
* 1.4.1
  bugs fixed
* 1.4.0
  support swift 4.0
* 1.3.1
  support swift 3.0
* 1.0.3
  Complete basic functions, add Cocoapod and Carthage support

## Contribute

We would love for you to contribute to **TKSwitcherCollection**, check the ``LICENSE`` file for more info.

## Meta

TBXark – [@tbxark](https://twitter.com/tbxark) – tbxark@outlook.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/TBXark](https://github.com/TBXark)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
