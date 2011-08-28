//
//  PictureDetailViewController.m
//  PictureManage
//
//  Created by uzai on 11-8-28.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "PictureDetailViewController.h"
#import "Picture.h"

@implementation PictureDetailViewController
@synthesize pictures,index;
-(void)dealloc{
    [pictures release];
    
    [super dealloc];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-44)];
    scrollView.backgroundColor = [UIColor clearColor];
    
    
    
    [self.view addSubview:scrollView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
}


@end
