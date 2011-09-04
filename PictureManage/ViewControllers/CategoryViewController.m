//
//  CategoryViewController.m
//  PictureManage
//
//  Created by uzai on 11-8-27.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryEditViewController.h"
#import "CategoryDataSource.h"

@implementation CategoryViewController

- (void)dealloc
{
    [_tableView release];
    [_categorys release];

    [super dealloc];
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
      _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 480) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    
    [self.view addSubview:_tableView];
   // _categorys = [[NSMutableArray alloc]initWithObjects:@"时尚",@"风景",@"安吉漂流", nil];
    UIBarButtonItem *rightBarItem  = [[UIBarButtonItem alloc]initWithTitle:@"新分组" style:UIBarButtonSystemItemAdd target:self action:@selector(addCategory)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [rightBarItem release];
    
           
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

        self.navigationItem.title = @"分类管理";
    
    
    self.navigationController.navigationBarHidden = NO;
       [_categorys removeAllObjects];
    _categorys = nil;
    [_categorys release];
     _categorys = [[CategoryDataSource categorys] retain]; 
    [_tableView reloadData];
}

-(void)addCategory{
    CategoryEditViewController *categortEditViewController = [[CategoryEditViewController alloc]init];
    [self.navigationController pushViewController:categortEditViewController animated:YES];
    [categortEditViewController release];
    
}



#pragma mark - tableView DataSource and Degelate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_categorys count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"catagoryCellId";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
    }
    
    cell.textLabel.text = [_categorys objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
       
}

@end
