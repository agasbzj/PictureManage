//
//  CategoryViewController.h
//  PictureManage
//
//  Created by uzai on 11-8-27.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CategoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
    NSMutableArray *_categorys;
}




@end
