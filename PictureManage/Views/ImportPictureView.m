//
//  ImportPictureView.m
//  PictureManage
//
//  Created by uzai on 11-9-1.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "ImportPictureView.h"


@implementation ImportPictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self addSubview:_tableView];
       _tableView.backgroundColor=[UIColor grayColor];
    }
    
    return self;
}



- (void)dealloc
{
    [_tableView release];
    [super dealloc];
}

#pragma mark- tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cagetoryCell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell ==nil){
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId]autorelease];
        
    }
    cell.textLabel.text=@"aaa";
    return cell;
    
    
    
}



@end
