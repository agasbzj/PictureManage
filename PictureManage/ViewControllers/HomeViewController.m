//
//  HomeViewController.m
//  PictureManage
//
//  Created by uzai on 11-8-24.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "HomeViewController.h"
#import "CategoryViewController.h"
#import "CategoryDataSource.h"
#import "Picture.h"
#import "pictureDetailViewController.h"
#import "HomeViewDataSource.h"
#import "CategoryEditViewController.h"
#import "PathHelper.h"
#import "ImageImporterController.h"

#import "UIImage+Compress.h"
#import "UIImage+Resize.h"

#define toolImageLeftMagn 19
#define toolImageTopMagn 4

@implementation HomeViewController


- (void)dealloc
{
    [segmentedControl release];
    [_tableView release];
    [_scrollView release];
    [pictures release];
    [toolImages release];
    [categorys release];
    [segmentedControl release];
    [picture release];
    
    [super dealloc];
    
}


#pragma mark - View lifecycle

-(void)viewDidLoad{
    [super viewDidLoad];
    pictures = [[NSMutableArray alloc]init];

    
    NSArray *arr  = [[HomeViewDataSource imagesInfoWithCategory:@"default"] retain];
    if ([[CategoryDataSource categorys] count] == 0) {
        [PathHelper createPathIfNecessary:@"default"];
    }
    
    for (int i =0; i<[arr count]; i++) {
        picture = [[Picture alloc]init];
        picture.imageUrl = [[arr objectAtIndex:i] objectForKey:@"name"];
        picture.imageDescript = [NSString stringWithFormat:@"%i图片哦",i];
        picture.belongCategory = [[arr objectAtIndex:i] objectForKey:@"category"];
        [pictures addObject:picture];
        [picture release];
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
    [_tableView reloadData];
   }

-(void)doManageButton{
    CategoryViewController *categoryViewController = [[CategoryViewController alloc]init];
    
    [self.navigationController pushViewController:categoryViewController animated:YES];
    [categoryViewController release];
    
}

-(void)doPhotoButton{
    if ([ImageImporterController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        ImageImporterController *picker = [[ImageImporterController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.navigationController pushViewController:picker animated:YES];
        [picker release];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您的设备不支持照相机" message:nil delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        
    }
}
-(void)doImportButton{
        
    ImageImporterController *importer = [[ImageImporterController alloc] initWithCamera:NO];
    importer.delegate = self;
    [self presentModalViewController:importer animated:YES];
    [importer release];
}

#pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(ImageImporterController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [picker.selectedImages addObject:image];
    if(!picker.isUsingCamera){
        [picker updateToolBarInfo];
    }

}
-(void)ImageImporterFinsh:(NSString *)categateName{
    [pictures removeAllObjects];
    NSArray *arr  = [[HomeViewDataSource imagesInfoWithCategory:categateName] retain];
    for (int i =0; i<[arr count]; i++) {
        picture = [[Picture alloc]init];
        picture.imageUrl = [[arr objectAtIndex:i] objectForKey:@"name"];
        picture.imageDescript = [NSString stringWithFormat:@"%i图片哦",i];
        picture.belongCategory = [[arr objectAtIndex:i] objectForKey:@"category"];
        [pictures addObject:picture];
        [picture release];
    }
    [_tableView reloadData];

}

- (void)imagePickerControllerDidCancel:(ImageImporterController *)picker {
    
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
        ImageView *imageView  = [[ImageView alloc] initWithFrame:CGRectMake(toolImageLeftMagn+(i*toolImageLeftMagn)+i*60,toolImageTopMagn , 30, 30) imageURL:@"add.png"];
        
        [_scrollView addSubview:imageView];
        imageView.imageObject = [categorys objectAtIndex:i];
        imageView.imageViewDelegate =self;
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
    cell.imageCellDidSelectImage =self;
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


-(void)openFlowView:(AFOpenFlowView *)openFlowView requestImageForIndex:(int)index{    
    NSString *imageUrl = [[pictures objectAtIndex:index] imageUrl];
    UIImage *image = [UIImage imageWithContentsOfFile:imageUrl];
    
    UIImage *newImage = [image resizeImageWithNewSize:CGSizeMake(255, 255)]; //把图片大小设成255＊255
    
//    UIImage *newImage = [image resizedImage:CGSizeMake(255, 255) interpolationQuality:2]; on device test !
    
    [openFlowView setImage: newImage forIndex:index];
    
}
- (UIImage *)defaultImage{
	return [UIImage imageNamed:@"0.jpg"];
}


- (void)onClickEvent:(ImageView*)aImageView imageObject:(id)aImageObject{
    [pictures removeAllObjects];
    NSArray *arr  = [[HomeViewDataSource imagesInfoWithCategory:aImageObject] retain];
    for (int i =0; i<[arr count]; i++) {
        picture = [[Picture alloc]init];
        picture.imageUrl = [[arr objectAtIndex:i] objectForKey:@"name"];
        picture.imageDescript = [NSString stringWithFormat:@"%i图片哦",i];
        picture.belongCategory = [[arr objectAtIndex:i] objectForKey:@"category"];
        [pictures addObject:picture];
        [picture release];
    }
    [_tableView reloadData];
            
}


#pragma mark-- ImageCell Delegate
-(void)imageDidSelectIndex:(NSInteger)index{
    PictureDetailViewController *pictureDetailViewController =[[PictureDetailViewController alloc]init];
    pictureDetailViewController.pictures =pictures;
    pictureDetailViewController.index = index;
    [self.navigationController pushViewController:pictureDetailViewController animated:YES];
    [pictureDetailViewController release];
}

@end
