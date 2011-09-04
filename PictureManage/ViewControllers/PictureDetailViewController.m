//
//  PictureDetailViewController.m
//  PictureManage
//
//  Created by uzai on 11-8-28.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "PictureDetailViewController.h"
#import "Picture.h"
#import "ShareEditViewController.h"

@implementation PictureDetailViewController



@synthesize pictures,index;
-(void)dealloc{
    [pictures release];

    [super dealloc];
}
-(void)viewDidLoad{
    [super viewDidLoad];
    currentPage = self.index;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStyleBordered target:self action:@selector(doShare)];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    [rightBarButton release];
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-44)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.pagingEnabled =YES;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate= self;    
    NSInteger pageCount = [self.pictures count];

    CGSize newSize  = CGSizeMake(pageCount *320, 480 -44);
    scrollView.contentSize = newSize;
    
    //fill image
    for (int i=0; i<pageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, 480-44)];
        imageView.image  = [UIImage imageWithContentsOfFile:[[self.pictures objectAtIndex:i] imageUrl]];
        [scrollView addSubview:imageView];
        [imageView release];
    } 
    
    [self.view addSubview:scrollView];
    
    [scrollView setContentOffset:CGPointMake(self.index*320, 0) animated:NO];
     currentPage=self.index;
    
}





-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;    
    
}

-(void)doShare{
    ShareEditViewController *shareEditViewController = [[ShareEditViewController alloc]init];
  
    shareEditViewController.image =  [UIImage imageWithContentsOfFile:[[self.pictures objectAtIndex:currentPage] imageUrl]];
    [self.navigationController pushViewController:shareEditViewController animated:YES];
    [shareEditViewController release];
}


#pragma mark --ScrollerView Delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
        
}


-(void)scrollViewDidEndDragging:(UIScrollView *)aScrollView willDecelerate:(BOOL)decelerate{
    currentPage=aScrollView.contentOffset.x/320;

}




@end
