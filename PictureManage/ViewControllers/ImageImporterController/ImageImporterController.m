//
//  ImageImporterController.m
//  almondz
//
//  Created by 卞中杰 on 11-7-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImageImporterController.h"
#import "CategoryViewController.h"
#import "CategoryDataSource.h"
#import "PathHelper.h"
#import "ImageSavingOperation.h"
#import "Hash.h"
#import "RotateUIImage.h"
@implementation ImageImporterController
@synthesize  selectedImages= _selectedImages ,isUsingCamera=_isUsingCamera,delegate;
-(id)initWithCamera:(BOOL)isUsingCamera
{
    self = [super init];
    if(self){
        _isUsingCamera =isUsingCamera;
        _selectedImages = [[NSMutableArray alloc]init];
        _imageNumber = 0;
        if (!_isUsingCamera) {
            UIToolbar *tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, 320, 44)];
            tool.barStyle = UIBarStyleBlackOpaque;
            [self.view addSubview:tool];
                        UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"导入" style:UIBarButtonSystemItemPlay target:self action:@selector(showDialogView)];
                        UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithTitle:@"清零" style:UIBarButtonItemStyleBordered target:self action:@selector(clearSelected)];
                        NSString *info = [NSString stringWithFormat:@"您选择了%d张照片", _imageNumber];
            _imageSelectedInfo = [[UIButton alloc] initWithFrame:CGRectMake(12, 7, 149, 31)];
            [_imageSelectedInfo setTitle:info forState:UIControlStateNormal];
            _imageSelectedInfo.userInteractionEnabled = NO;
            UIBarButtonItem *imageInfo = [[UIBarButtonItem alloc] initWithCustomView:_imageSelectedInfo];
            UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            [tool setItems:[NSArray arrayWithObjects:clearButton, flex, imageInfo, flex, okButton, nil] animated:YES];
            [tool release];
            [flex release];
            [imageInfo release];
            [okButton release];
            [clearButton release];
            
            
            //DialogView
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DialogView" owner:self options:nil];
            _dialogView = [array objectAtIndex:0];
            _dialogView.delegate = self;
            _dialogView.alpha = 0.f;
            CGPoint point = CGPointMake(160, 270);
            _dialogView.center = point;
            [self.view addSubview:_dialogView];
            
            UITextField *field = (UITextField *)[_dialogView viewWithTag:99];
            NSArray *_categorys = [CategoryDataSource categorys];
            if ([_categorys count]>0) {
                field.text = [_categorys objectAtIndex:0];
            }
            else{
                //提示需要添加分组
            }
        }

    }
    return self;
}


-(void)dealloc{
    delegate = nil;
    [_selectedImages release];
    [_imageSelectedInfo release];
    [super dealloc];
}

-(void)showDialogView{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.5f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_dialogView cache:YES];
    _dialogView.alpha = 1.f;
    [UIView commitAnimations];
}

-(void)clearSelected{
    [_selectedImages removeAllObjects];
    [self updateToolBarInfo];
}

- (void)updateToolBarInfo {
    NSString *info = [NSString stringWithFormat:@"您选择了%d张照片", [_selectedImages count]];
    [_imageSelectedInfo setTitle:info forState:UIControlStateNormal];
}

#pragma mark-- DialogView Delegate
- (void)importImageswithCategory:(NSString *)categoryName detial:(NSString *)detail{
    if ([categoryName isEqualToString:@""]) {
        return;
    }
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), categoryName];
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        for (int i = 0; i < [_selectedImages count]; i++) {
        UIImage *image =  [_selectedImages objectAtIndex:i];
        NSData *imgData = UIImagePNGRepresentation(image);
            NSString *date = [NSString stringWithFormat:@"%@%d", [[NSDate date] description], i];
            NSString *name = [Hash md5:date];
            NSString *imgPath = [NSString stringWithFormat:@"%@/%@.png", path, name];
            [imgData writeToFile:imgPath atomically:YES];
            NSString *detailFile = [NSString stringWithFormat:@"%@/Details.plist", path];
            NSMutableArray *detailArray;
            NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:detailFile];
            if ([array count])
                detailArray = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
            else
                detailArray = [[NSMutableArray alloc] init];
            NSDictionary *detailDic = [NSDictionary dictionaryWithObjectsAndKeys:imgPath, @"name", [detail isEqualToString:@""] ? @"点击以修改详细信息" : detail, @"detail", categoryName, @"category", nil];
            [detailArray addObject:detailDic];
            [detailArray writeToFile:detailFile atomically:YES];
        }
    
    if([self.delegate respondsToSelector:@selector(ImageImporterFinsh:)]){
        [self.delegate ImageImporterFinsh:categoryName];
    }
    [self dismissModalViewControllerAnimated:YES]; 
    
}




@end
