//
//  CategoryEditViewController.m
//  PictureManage
//
//  Created by uzai on 11-8-27.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "CategoryEditViewController.h"
#import "PathHelper.h"

@implementation CategoryEditViewController
@synthesize isRename;

- (void)dealloc
{
    [textField release];
    [super dealloc];
}
-(void)viewDidLoad{
    [super viewDidLoad];  
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 60, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"分类名 :";
    label.font = [UIFont systemFontOfSize:16.0f];
    [self.view addSubview:label];
    [label release];
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 30, 200, 30)];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:16.0f];
    textField.borderStyle  =UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(doButton) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(200, 100, 50, 25)];
    [self.view addSubview:button];

    
}
-(void)doButton{
    if([PathHelper createPathIfNecessary:textField.text]){
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(!self.isRename){
        self.navigationItem.title=@"添加新分类";
    }
    else{
        self.navigationItem.title =@"修改分类";
    }
    
    
    
}
@end
