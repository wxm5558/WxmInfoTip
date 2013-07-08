//
//  ViewController.m
//  WxmInfoTip
//
//  Created by xiaomanwang on 13-6-29.
//  Copyright (c) 2013年 wxm. All rights reserved.
//

#import "ViewController.h"
#import "InfoTipView.h"

@interface ViewController ()

@end

static int clickCount = -1;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button setTitle:@"test" forState:UIControlStateSelected];
    [button setTitle:@"test" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(140, 200, 40, 40);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(tip:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)tip:(id)sender
{
    clickCount ++;
    NSString *str = @"This is Test";
    NSMutableString *s = [NSMutableString string];
    for (int j = 0 ; j<= clickCount; j++)
    {
        [s appendFormat:@"%@\n",str];
    }
    [[InfoTipView sharedInfoTipView] showMessage:[NSString stringWithFormat:@"%@",s]];
}

@end
