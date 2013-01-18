//
// RETrimControl.m
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


#import "RETrimControl.h"

#define RANGESLIDER_THUMB_SIZE 22

@implementation RETrimControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.threshold = 22;

        _outerView = [[UIImageView alloc] initWithFrame:CGRectMake(_threshold, frame.size.height / 2 - 4, frame.size.width - 1 - _threshold * 2, 9)];
        _outerView.image = [[UIImage imageNamed:@"RETrimControl.bundle/Outer"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
        [self addSubview:_outerView];

        _sliderMiddleView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _sliderMiddleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"RETrimControl.bundle/SliderMiddle"]];
        [self addSubview:_sliderMiddleView];

        UIPanGestureRecognizer *middlePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMiddlePan:)];
        [_sliderMiddleView addGestureRecognizer:middlePan];

        _maxValue = 100;
        _minValue = 0;

        _leftValue = 0;
        _rightValue = 100;

        _leftThumbView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, RANGESLIDER_THUMB_SIZE, 28)];
        _leftThumbView.image = [UIImage imageNamed:@"RETrimControl.bundle/Slider"];
        _leftThumbView.contentMode = UIViewContentModeLeft;
        _leftThumbView.userInteractionEnabled = YES;
        _leftThumbView.clipsToBounds = YES;
        [self addSubview:_leftThumbView];

        UIPanGestureRecognizer *leftPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftPan:)];
        [_leftThumbView addGestureRecognizer:leftPan];

        _rightThumbView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - RANGESLIDER_THUMB_SIZE, 0, RANGESLIDER_THUMB_SIZE, 28)];
        _rightThumbView.image = [UIImage imageNamed:@"RETrimControl.bundle/Slider"];
        _rightThumbView.contentMode = UIViewContentModeRight;
        _rightThumbView.userInteractionEnabled = YES;
        _rightThumbView.clipsToBounds = YES;
        [self addSubview:_rightThumbView];

        _innerView = [[UIImageView alloc] initWithFrame:CGRectMake(10, frame.size.height / 2 - 4, frame.size.width - 21, 9)];
        _innerView.image = [[UIImage imageNamed:@"RETrimControl.bundle/Inner"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
        [self addSubview:_innerView];

        UIPanGestureRecognizer *rightPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightPan:)];
        [_rightThumbView addGestureRecognizer:rightPan];

        _popoverView = [[UIView alloc] initWithFrame:CGRectMake(-9, -28, 40, 28)];
        _popoverView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"RETrimControl.bundle/Popover"]];
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 40, 10)];
        _timeLabel.font = [UIFont boldSystemFontOfSize:10];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = UITextAlignmentCenter;
        [_popoverView addSubview:_timeLabel];
        _popoverView.alpha = 0;
        [self addSubview:_popoverView];

        _popoverViewLong = [[UIView alloc] initWithFrame:CGRectMake(-9, -28, 90, 28)];
        _popoverViewLong.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"RETrimControl.bundle/PopoverLong"]];
        _timeLabelLong = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 90, 10)];
        _timeLabelLong.font = [UIFont boldSystemFontOfSize:10];
        _timeLabelLong.backgroundColor = [UIColor clearColor];
        _timeLabelLong.textColor = [UIColor whiteColor];
        _timeLabelLong.textAlignment = UITextAlignmentCenter;
        [_popoverViewLong addSubview:_timeLabelLong];
        _popoverViewLong.alpha = 0;
        [self addSubview:_popoverViewLong];
    }
    return self;
}

- (NSString *)stringFromTime:(NSInteger)time
{
    NSInteger minutes = floor(time / 60);
    NSInteger seconds = time - minutes * 60;
    NSString *minutesStr = [NSString stringWithFormat:minutes >= 10 ? @"%i" : @"0%i", minutes];
    NSString *secondsStr = [NSString stringWithFormat:seconds >= 10 ? @"%i" : @"0%i", seconds];
    return [NSString stringWithFormat:@"%@:%@", minutesStr, secondsStr];
}

- (void)updateLongTimeLabel:(NSInteger)timeStart timeEnd:(NSInteger)timeEnd
{
    _timeLabelLong.text = [NSString stringWithFormat:@"%@  —  %@", [self stringFromTime:timeStart], [self stringFromTime:timeEnd]];
}

- (void)layoutSubviews
{
    CGFloat availableWidth = self.frame.size.width - RANGESLIDER_THUMB_SIZE;
    CGFloat inset = RANGESLIDER_THUMB_SIZE / 2;

    CGFloat range = _maxValue - _minValue;

    CGFloat left = floorf((_leftValue - _minValue) / range * availableWidth);
    CGFloat right = floorf((_rightValue - _minValue) / range * availableWidth);

    if (isnan(left)) left = 0;
    if (isnan(right)) right = 0;

    _leftThumbView.center = CGPointMake(inset + left, 14);
    _rightThumbView.center = CGPointMake(inset + right, 14);

    _sliderMiddleView.frame = CGRectMake(_leftThumbView.frame.origin.x + RANGESLIDER_THUMB_SIZE, 0, _rightThumbView.frame.origin.x - _leftThumbView.frame.origin.x - RANGESLIDER_THUMB_SIZE, 28);

    CGRect frame = _innerView.frame;
    frame.origin.x = _leftThumbView.frame.origin.x + _threshold;
    frame.size.width = _rightThumbView.frame.origin.x + _rightThumbView.frame.size.width - _threshold - frame.origin.x;
    _innerView.frame = frame;

    _outerView.frame = CGRectMake(_threshold, self.frame.size.height / 2 - 4, self.frame.size.width - 1 - _threshold * 2, _outerView.image.size.height);
}

- (void)handleMiddlePan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];

        CGFloat range = _maxValue - _minValue;
        CGFloat availableWidth = self.frame.size.width - RANGESLIDER_THUMB_SIZE;

        if (_leftValue + translation.x / availableWidth * range < 0) {
            CGFloat diff = _rightValue - _leftValue;
            _leftValue = 0;
            _rightValue = diff;

            return [self setNeedsLayout];
        }

        if (_rightValue + translation.x / availableWidth * range > 100) {
            CGFloat diff = _rightValue - _leftValue;
            _leftValue = 100 - diff;
            _rightValue = 100;

            return [self setNeedsLayout];
        }

        _leftValue += translation.x / availableWidth * range;
        _rightValue += translation.x / availableWidth * range;

        [gesture setTranslation:CGPointZero inView:self];

        [self setNeedsLayout];

        _popoverViewLong.alpha = 1;
        CGRect frame = _popoverViewLong.frame;
        frame.origin.x = _leftThumbView.frame.origin.x - 34 + floor((_rightThumbView.frame.origin.x - _leftThumbView.frame.origin.x) / 2);
        _popoverViewLong.frame = frame;
        
        _timeLabelLong.text = [NSString stringWithFormat:@"%@  —  %@", [self stringFromTime:_leftValue * _length / 100.0f], [self stringFromTime:_rightValue * _length / 100.0f]];

        if ([_delegate respondsToSelector:@selector(trimControl:didChangeLeftValue:rightValue:)])
            [_delegate trimControl:self didChangeLeftValue:self.leftValue rightValue:self.rightValue];
    }

    if (gesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void) {
                             _popoverViewLong.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                         }];
    }
}

- (void)handleLeftPan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];
        CGFloat range = _maxValue - _minValue;
        CGFloat availableWidth = self.frame.size.width - RANGESLIDER_THUMB_SIZE;
        _leftValue += translation.x / availableWidth * range;
        if (_leftValue < 0) _leftValue = 0;
        if (_rightValue - _leftValue < 10) _leftValue = _rightValue - 9;

        [gesture setTranslation:CGPointZero inView:self];

        [self setNeedsLayout];

        _popoverView.alpha = 1;
        CGRect frame = _popoverView.frame;
        frame.origin.x = _leftThumbView.frame.origin.x - 9;
        _popoverView.frame = frame;

       // [self updateTimeLabel:_leftValue * _length / 100.0f];
        _timeLabel.text = [self stringFromTime:_leftValue * _length / 100.0f];

        if ([_delegate respondsToSelector:@selector(trimControl:didChangeLeftValue:rightValue:)])
            [_delegate trimControl:self didChangeLeftValue:self.leftValue rightValue:self.rightValue];
    }

    if (gesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void) {
                             _popoverView.alpha = 0;
                         }
                         completion:^(BOOL finished) {
                         }];
    }
}

- (void)handleRightPan:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];
        CGFloat range = _maxValue - _minValue;
        CGFloat availableWidth = self.frame.size.width - RANGESLIDER_THUMB_SIZE;
        _rightValue += translation.x / availableWidth * range;

        if (_rightValue > 100) _rightValue = 100;
        if (_rightValue - _leftValue < 10) _rightValue = _leftValue + 9;

        [gesture setTranslation:CGPointZero inView:self];

        [self setNeedsLayout];

        _popoverView.alpha = 1;
        CGRect frame = _popoverView.frame;
        frame.origin.x = _rightThumbView.frame.origin.x - 9;
        _popoverView.frame = frame;
        
        _timeLabel.text = [self stringFromTime:_rightValue * _length / 100.0f];

        if ([_delegate respondsToSelector:@selector(trimControl:didChangeLeftValue:rightValue:)])
            [_delegate trimControl:self didChangeLeftValue:self.leftValue rightValue:self.rightValue];
    }

    if (gesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^(void){
                             _popoverView.alpha = 0;
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

- (CGFloat)leftValue
{
    return _leftValue * _length / 100.0f;
}

- (CGFloat)rightValue
{
    return _rightValue * _length / 100.0f;
}

@end
