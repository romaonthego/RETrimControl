# RETrimControl

Audio trim control, similar to the one seen in default iPhone Voice Memos app.

![Screenshot of RETrimControl](https://github.com/romaonthego/RETrimControl/raw/master/Screenshot.png "RETrimControl Screenshot")

## Requirements
* Xcode 4.6 or higher
* Apple LLVM compiler
* iOS 5.0 or higher
* ARC

If you are not using ARC in your project, add `-fobjc-arc` as a compiler flag for all the files in this project.

## Demo

Build and run the `RETrimControlExample` project in Xcode to see `RETrimControl` in action.

## Installation

### CocoaPods

The recommended approach for installating `RETrimControl` is via the [CocoaPods](http://cocoapods.org/) package manager, as it provides flexible dependency management and dead simple installation.
For best results, it is recommended that you install via CocoaPods >= **0.15.2** using Git >= **1.8.0** installed via Homebrew.

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Change to the directory of your Xcode project:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
```

Edit your Podfile and add RETrimControl:

``` bash
platform :ios, '5.0'
pod 'RETrimControl', '~> 1.2'
```

Install into your Xcode project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file)

``` bash
$ open MyProject.xcworkspace
```

Please note that if your installation fails, it may be because you are installing with a version of Git lower than CocoaPods is expecting. Please ensure that you are running Git >= **1.8.0** by executing `git --version`. You can get a full picture of the installation details by executing `pod install --verbose`.

### Manual Install

All you need to do is drop `RETrimControl` files into your project, and add `#include "RETrimControl.h"` to the top of classes that will use it.

## Example Usage

``` objective-c
RETrimControl *trimControl = [[RETrimControl alloc] initWithFrame:CGRectMake(10, (self.view.frame.size.height - 28) / 2.0f, 300, 28)];
trimControl.length = 200; // 200 seconds
trimControl.delegate = self;
[self.view addSubview:trimControl];
```

You may want to to set your controller to conform to `RETrimControlDelegate` protocol to receive notifications when values are being changed.

``` objective-c
...
trimControl.delegate = self;
...
```

``` objective-c
- (void)trimControl:(RETrimControl *)trimControl didChangeLeftValue:(CGFloat)leftValue rightValue:(CGFloat)rightValue
{
    NSLog(@"Left = %f, right = %f", leftValue, rightValue);
}
```

## Customization

You can assign your custom resource bundle on control initialization:

``` objective-c
RETrimControl *trimControl = [[RETrimControl alloc] initWithFrame:CGRectMake(0, 0, 300, 28) resourceBundle:@"CustomResources.bundle"];
```

## Contact

Roman Efimov

- https://github.com/romaonthego
- https://twitter.com/romaonthego
- romefimov@gmail.com

## License

RETrimControl is available under the MIT license.

Copyright © 2013 Roman Efimov.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
