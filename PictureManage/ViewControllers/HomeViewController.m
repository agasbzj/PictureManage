//
//  HomeViewController.m
//  PictureManage
//
//  Created by uzai on 11-8-24.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewImageCell.h"
#import "CategoryViewController.h"
#import "CategoryDataSource.h"
#import "ImageImporterController.h"
#import "Picture.h"
#import "pictureDetailViewController.h"
#define toolImageLeftMagn 19
#define toolImageTopMagn 4
@implementation HomeViewController


- (void)dealloc
{
    [segmentedControl release];
    [_tableView release];
    [_scrollView release];
    [pictures release];
    
    
    [super dealloc];
    
}


#pragma mark - View lifecycle

-(void)viewDidLoad{
    [super viewDidLoad];
    pictures = [[NSMutableArray alloc]init];
    for (int i =0; i<29; i++) {
        [pictures addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",i]]];
    }
 
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 315) style:UITableViewStylePlain];
    _tableView.dataSource =self;
    _tableView.delegate= self;
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    afOpenFlowView = [[AFOpenFlowView alloc] initWithFrame:CGRectMake(0, 0, 320, 315)];
    afOpenFlowView.dataSource = self;
    afOpenFlowView.viewDelegate = self;
    
    [afOpenFlowView setNumberOfImages:[pictures count]];
    
    [afOpenFlowView defaultImage];
    [self.view addSubview:afOpenFlowView];
    
    [afOpenFlowView setHidden:YES];

    //openFlow
    
    
    UIView *buttonPoolView = [[UIView alloc]initWithFrame:CGRectMake(0, 316, 320, 52)];
    buttonPoolView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:buttonPoolView];
    
    UIButton *manageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [manageButton setTitle:@"管理" forState:UIControlStateNormal];
    [manageButton setFrame:CGRectMake(32, 10, 60, 32)];
    [manageButton addTarget:self action:@selector(doManageButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonPoolView addSubview:manageButton];
    
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [photoButton setTitle:@"照片" forState:UIControlStateNormal];
    [photoButton setFrame:CGRectMake(132, 10, 60, 32)];
    [photoButton addTarget:self action:@selector(doPhotoButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonPoolView addSubview:photoButton];
    
    UIButton *importButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [importButton setTitle:@"导入" forState:UIControlStateNormal];
    [importButton setFrame:CGRectMake(232, 10, 60, 32)];
    [importButton addTarget:self action:@selector(doImportButton) forControlEvents:UIControlEventTouchUpInside];
    [buttonPoolView addSubview:importButton];
    [buttonPoolView release];
    
    _scrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 316+52, 320, 68)];
    _scrollView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:_scrollView];
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 435, 320, 35)];
    footView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:footView];
    //  Label
    
    NSArray *items = [NSArray arrayWithObjects:@"samllTable", @"openFlow", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar; 
    [segmentedControl addTarget:self action:@selector(segmentAction) forControlEvents:UIControlEventValueChanged];
    [footView addSubview:segmentedControl];
    
    [segmentedControl release];
    [footView release];
    
    
       
    
    
}

-(void)segmentAction{
    NSInteger segIndex= segmentedControl.selectedSegmentIndex;
    if (segIndex == 0) {
        [afOpenFlowView setHidden:YES];
        [_tableView setHidden:NO];
        
    }
    else if(segIndex ==1){
        [afOpenFlowView setHidden:NO];
        [_tableView setHidden:YES];

    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden= YES;
    
    [self performSelector:@selector(initScrollView)];
    

    

}

-(void)doManageButton{
        
    CategoryViewController *categoryViewController = [[CategoryViewController alloc]init];
    
    [self.navigationController pushViewController:categoryViewController animated:YES];
    [categoryViewController release];
    
}

-(void)doPhotoButton{
    
}
-(void)doImportButton{
    ImageImporterController *importer = [[ImageImporterController alloc] initWithCamera:NO];
    importer.isUsingCamera = NO;
    importer.delegate = self;
    [self presentModalViewController:importer animated:YES];
    [importer release];
}

#pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(ImageImporterController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *img = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker.selectedImages addObject:img];
    
    
    if (!picker.isUsingCamera) {
        [picker updateToolBarInfo];
    }
    else {
        [picker showDialogView];
    }
    
}

- (void)imagePickerControllerDidCancel:(ImageImporterController *)picker {
    //    kPicker = nil;
    //    if (_selectedImage && [_selectedImage count]) {
    //        [_selectedImage removeAllObjects];
    //    }
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)initScrollView{
    _scrollView.pagingEnabled =YES;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.delegate=self;
    categorys = [CategoryDataSource categorys];
    NSInteger categorysNum = [categorys count];
    NSInteger pageNum = categorysNum/4;
    if (categorysNum %4 !=0) {
        pageNum ++;
    }
    CGSize newSize = CGSizeMake(self.view.frame.size.width * pageNum, 68);
    _scrollView.contentSize = newSize;
    
    for (int i = 0; i<categorysNum; i++) {
        UIImageView *imageView  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",i]]];
        [imageView setFrame:CGRectMake(toolImageLeftMagn+(i*toolImageLeftMagn)+i*60,toolImageTopMagn , 30, 30)];
        [_scrollView addSubview:imageView];
        [imageView release];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(toolImageLeftMagn+(i*toolImageLeftMagn)+i*60, toolImageTopMagn+30, 30, 30)];
        label.text = [categorys objectAtIndex:i];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment=UITextAlignmentCenter;
        [_scrollView addSubview:label];
        [label release];
      
        
    }
    
    
    
    
        
}



#pragma mark -  tableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger num =[pictures count]/3;
    
    if ([pictures count] %3 !=0) {
        num ++;
    }
    
    return num;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"imageCell";
    
    HomeViewImageCell *cell = (HomeViewImageCell *) [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell = [[[HomeViewImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
    }
    cell.puctures = pictures;
    cell.indexPath = indexPath;
    [cell fillCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

#pragma mark -
#pragma mark AFOpenFlowViewDataSource AFOpenFlowViewDelegate methods

- (void)openFlowView:(AFOpenFlowView *)openFlowView didSelectAtIndex:(int)index{
    
    PictureDetailViewController *pictureDetailViewController =[[PictureDetailViewController alloc]init];
    pictureDetailViewController.pictures =pictures;
    pictureDetailViewController.index = index;
    [self.navigationController pushViewController:pictureDetailViewController animated:YES];
    [pictureDetailViewController release];
    
}

- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index{
    
}


-(void)openFlowView:(AFOpenFlowView *)openFlowView requestImageForIndex:(int)index{
    
    UIImage *image = [pictures objectAtIndex:index];
    [openFlowView setImage:image  forIndex:index];
    
}

- (UIImage *)defaultImage{
	return [UIImage imageNamed:@"0.jpg"];
}




@end
