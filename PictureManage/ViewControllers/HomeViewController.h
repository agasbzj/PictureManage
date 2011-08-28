//
//  HomeViewController.h
//  PictureManage
//
//  Created by uzai on 11-8-24.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFOpenFlowView.h"

@interface HomeViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,AFOpenFlowViewDelegate,AFOpenFlowViewDataSource, UIImagePickerControllerDelegate> {
    UITableView *_tableView;
    AFOpenFlowView * afOpenFlowView;
    UISegmentedControl* segmentedControl;
    UIScrollView *_scrollView;


    NSMutableArray *pictures;
    NSMutableArray *toolImages;
    NSArray *categorys;
    
}





@end
