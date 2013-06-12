//
// RETrimControl.h
// RETrimControl
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "RETrimPopover.h"

@protocol RETrimControlDelegate;

@interface RETrimControl : UIView {
    UIImageView *_outerView;
    UIImageView *_innerView;
    UIView *_sliderMiddleView;
    UIImageView *_leftThumbView;
    UIImageView *_rightThumbView;
    
    RETrimPopover *_leftPopover;
    RETrimPopover *_rightPopover;
    
    UIView *_popoverViewLong;
    UILabel *_timeLabelLong;
    NSInteger _maxValue;
    NSInteger _minValue;
    CGFloat _leftValue;
    CGFloat _rightValue;
}

@property (weak, readwrite, nonatomic) id<RETrimControlDelegate> delegate;
@property (assign, readwrite, nonatomic) NSInteger length;
@property (assign, readonly, nonatomic) CGFloat leftValue;
@property (assign, readonly, nonatomic) CGFloat rightValue;
@property (assign, readwrite, nonatomic) NSInteger threshold;
@property (strong, readonly, nonatomic) NSString *resourceBundle;
@property (strong, readwrite, nonatomic) UIFont *font;
@property (strong, readwrite, nonatomic) UIColor *textColor;
@property (strong, readwrite, nonatomic) UIColor *textBackgroundColor;
@property (assign, readwrite, nonatomic) NSInteger textVerticalOffset;

- (id)initWithFrame:(CGRect)frame resourceBundle:(NSString *)resourceBundle;

@end

@protocol RETrimControlDelegate <NSObject>

- (void)trimControl:(RETrimControl *)trimControl didChangeLeftValue:(CGFloat)leftValue rightValue:(CGFloat)rightValue;

@end