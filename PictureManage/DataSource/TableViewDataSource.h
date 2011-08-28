//
//  TableViewDataSource.h
//  PictureManage
//
//  Created by uzai on 11-8-24.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TableViewDataSource : NSObject<UITableViewDataSource,UITableViewDelegate> {
    BOOL _reloading;
    UITableView *_tableView;
}
@property(nonatomic,assign)BOOL reloading;
@property(nonatomic,retain)UITableView *tableView;

-(void)reloadTableViewDataSource;
-(id)initWithTableView:(UITableView *)_aTableView;

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
//-(void)doneLoadingTableViewData;

@end
