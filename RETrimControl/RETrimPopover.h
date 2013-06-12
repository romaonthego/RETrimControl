//
//  RETrimPopover.h
//  RETrimControlExample
//
//  Created by Roman Efimov on 1/23/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RETrimPopover : UIView

@property (strong, readonly, nonatomic) UILabel *timeLabel;

- (id)initWithFrame:(CGRect)frame resourceBundle:(NSString *)resourceBundle;

@end
