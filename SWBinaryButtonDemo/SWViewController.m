//
//  SWViewController.m
//  SWBinaryButtonDemo
//
//  Created by WANG ShengJia on 2/12/13.
//  Copyright (c) 2013 WANG ShengJia. All rights reserved.
//

#import "SWViewController.h"
#import "SWBinaryButton.h"
//#import <QuartzCore/QuartzCore.h>

@interface SWViewController ()

@end

@implementation SWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
	[button1 setBackgroundImage:[UIImage imageNamed:@"button1.png"] forState:UIControlStateNormal];
	[button1 addTarget:self action:@selector(button1Tapped:) forControlEvents:UIControlEventTouchUpInside];
    
	UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[button2 setBackgroundImage:[UIImage imageNamed:@"button2.png"] forState:UIControlStateNormal];
	[button2 addTarget:self action:@selector(button2Tapped:) forControlEvents:UIControlEventTouchUpInside];
    
	SWBinaryButton *binaryButton = [[SWBinaryButton alloc] initWithFirstButton:button1 secondButton:button2 frame:CGRectMake(100, 100, 50, 50)];
	[self.view addSubview:binaryButton];
    
}

- (void)button1Tapped:(id)sender {
	NSLog(@"button1 tapped");
}

- (void)button2Tapped:(id)sender {
	NSLog(@"button2 tapped");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
