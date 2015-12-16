//
//  ViewController.m
//  DrawItalicizeFontDemo
//
//  Created by 李佳 on 15/12/16.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "ViewController.h"
#import "DrawItalicizeFontView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    DrawItalicizeFontView* view = [[DrawItalicizeFontView alloc] init];
    view.frame = self.view.frame;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}


@end
