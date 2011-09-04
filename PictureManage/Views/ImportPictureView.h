//
//  ImportPictureView.h
//  PictureManage
//
//  Created by uzai on 11-9-1.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImportPictureView : UIView<UITableViewDataSource,UITableViewDelegate> { 
    UITableView *_tableView;
}

@end
