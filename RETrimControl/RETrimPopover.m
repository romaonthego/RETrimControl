//
//  RETrimPopover.m
//  RETrimControlExample
//
//  Created by Roman Efimov on 1/23/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RETrimPopover.h"

@implementation RETrimPopover

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame resourceBundle:@"RETrimControl.bundle"];
}

- (id)initWithFrame:(CGRect)frame resourceBundle:(NSString *)resourceBundle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@/Popover", resourceBundle]]];
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, 40, 10)];
        _timeLabel.font = [UIFont boldSystemFontOfSize:10];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_timeLabel];
        self.alpha = 0;
    }
    return self;
}

@end
