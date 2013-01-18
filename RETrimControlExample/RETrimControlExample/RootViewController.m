//
//  RootViewController.m
//  RETrimControlExample
//
//  Created by Roman Efimov on 1/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    RETrimControl *trimControl = [[RETrimControl alloc] initWithFrame:CGRectMake(10, (self.view.frame.size.height - 28) / 2.0f, 300, 28)];
    trimControl.length = 200; // 200 seconds
    trimControl.delegate = self;
    [self.view addSubview:trimControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark RETrimControlDelegate

- (void)trimControl:(RETrimControl *)trimControl didChangeLeftValue:(CGFloat)leftValue rightValue:(CGFloat)rightValue
{
    NSLog(@"Left = %f, right = %f", leftValue, rightValue);
}

@end
