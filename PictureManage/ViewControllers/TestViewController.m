//
//  TestViewController.m
//  PictureManage
//
//  Created by uzai on 11-8-26.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "TestViewController.h"

@implementation TestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    // coverFlow
    coverImageData = [[NSMutableArray alloc]init];
    for (int i =0; i<30; i++) {
        [coverImageData addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",i]]];
    }
    
    

    

    afOpenFlowView = [[AFOpenFlowView alloc] initWithFrame:CGRectMake(0, 0, 320, 380)];
    afOpenFlowView.dataSource = self;
    afOpenFlowView.viewDelegate = self;
    
    [afOpenFlowView setNumberOfImages:[coverImageData count]];
    [afOpenFlowView defaultImage];
    [self.view addSubview:afOpenFlowView];
    
  
}


- (void)dealloc
{
    [afOpenFlowView release];
    [coverImageData release];
    [super dealloc];
}


#pragma mark -
#pragma mark AFOpenFlowViewDataSource AFOpenFlowViewDelegate methods
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index{

}


-(void)openFlowView:(AFOpenFlowView *)openFlowView requestImageForIndex:(int)index{
    UIImage *image = [coverImageData objectAtIndex:index];
    [openFlowView setImage:image  forIndex:index];
    
}

- (UIImage *)defaultImage{
	return [UIImage imageNamed:@"1.jpg"];
}


@end
