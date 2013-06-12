//
//  RootViewController.m
//  RETrimControlExample
//
//  Created by Roman Efimov on 1/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    RETrimControl *trimControl = [[RETrimControl alloc] initWithFrame:CGRectMake(10, (self.view.frame.size.height - 28) / 2.0f, 300, 28)];
    trimControl.length = 200; // 200 seconds
    trimControl.delegate = self;
    trimControl.font = [UIFont boldSystemFontOfSize:10];
    [self.view addSubview:trimControl];
}

#pragma mark -
#pragma mark RETrimControlDelegate

- (void)trimControl:(RETrimControl *)trimControl didChangeLeftValue:(CGFloat)leftValue rightValue:(CGFloat)rightValue
{
    NSLog(@"Left = %f, right = %f", leftValue, rightValue);
}

@end
