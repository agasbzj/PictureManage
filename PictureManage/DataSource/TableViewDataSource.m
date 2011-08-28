//
//  TableViewDataSource.m
//  PictureManage
//
//  Created by uzai on 11-8-24.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "TableViewDataSource.h"

@interface TableViewDataSource (private)

- (void)dataSourceDidFinishLoadingNewData;

@end

@implementation TableViewDataSource
@synthesize reloading=_reloading;
@synthesize tableView =_tableView;
-(void)dealloc{
    [_tableView release];
    [super dealloc];
}
-(id)initWithTableView:(UITableView *)aTableView{
    self =[super init];
    if(self){
    _tableView = [aTableView retain];
    _tableView.dataSource =self;
    _tableView.delegate= self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return self;
    
}

-(void)setTableView:(UITableView *)aTableView{
    if(_tableView!=aTableView){
        [_tableView release];
        _tableView = [aTableView retain];
        _tableView.dataSource =self;
        _tableView.delegate= self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView reloadData];
    }
       
}

#pragma mark Table view methods

- (void)reloadTableViewDataSource{
	
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

@end
