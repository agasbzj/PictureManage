//
//  ImageImporterController.m
//  almondz
//
//  Created by 卞中杰 on 11-7-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ImageImporterController.h"
#import "Hash.h"
#import "ImageSavingOperation.h"

@implementation ImageImporterController
@synthesize dialogView = _dialogView;
@synthesize imageNumber = _imageNumber;
@synthesize selectedImages = _selectedImages;
@synthesize isUsingCamera = _isUsingCamera;
static UIActionSheet *kProgressSheet = nil;
static UIProgressView *kProgressView = nil;
static float kProgressValue = 0.f;
//显示导入对话框
- (void)showDialogView {

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:.5f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:_dialogView cache:YES];
    _dialogView.alpha = 1.f;
    [UIView commitAnimations];
}

- (void)clearSelected {
    if (_selectedImages) {
        [_selectedImages removeAllObjects];
    }
    [self updateToolBarInfo];
}

- (id)initWithCamera:(BOOL)isUsingCamera {
    if ((self = [super init])) {
        _saveQueue = [[NSOperationQueue alloc] init];
        
        
        _selectedImages = [[NSMutableArray alloc] init];
        if (!isUsingCamera) {
            UIToolbar *toolBar = [[UIToolbar alloc] init];
            toolBar.barStyle = UIBarStyleBlackTranslucent;
            toolBar.frame = CGRectMake(0, 436, 320, 44);
            [self.view addSubview:toolBar];
            UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"导入" style:UIBarButtonItemStyleDone target:self action:@selector(showDialogView)];
            
            _imageNumber = 0;
            
            UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithTitle:@"清零" style:UIBarButtonItemStyleBordered target:self action:@selector(clearSelected)];
            
            NSString *info = [NSString stringWithFormat:@"您选择了%d张照片", _imageNumber];
            _imageSelectedInfo = [[UIButton alloc] initWithFrame:CGRectMake(12, 7, 149, 31)];
            [_imageSelectedInfo setTitle:info forState:UIControlStateNormal];
            _imageSelectedInfo.userInteractionEnabled = NO;
            UIBarButtonItem *imageInfo = [[UIBarButtonItem alloc] initWithCustomView:_imageSelectedInfo];
            
            
            UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            [toolBar setItems:[NSArray arrayWithObjects:clearButton, flex, imageInfo, flex, okButton, nil] animated:YES];
            [toolBar release];
            [flex release];
            [imageInfo release];
            [okButton release];
            [clearButton release];

        }
        else {
            
            
        }
        
                

        
        //DialogView
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DialogView" owner:self options:nil];
        _dialogView = [array objectAtIndex:0];
        _dialogView.delegate = self;
        _dialogView.alpha = 0.f;
        CGPoint point = CGPointMake(160, 200);
        _dialogView.center = point;
        [self.view addSubview:_dialogView];
//        [_dialogView release];

    }
    return self;
}

//更新toolbar上的文字信息
- (void)updateToolBarInfo {
    NSString *info = [NSString stringWithFormat:@"您选择了%d张照片", [_selectedImages count]];
    [_imageSelectedInfo setTitle:info forState:UIControlStateNormal];
}



- (void)dealloc {
    [_selectedImages release];
    [super dealloc];
}



#pragma mark - DialogView Delegate


//根据把选择的照片保存到分类中
- (void)importImageswithCategory:(NSString *)categoryName detial:(NSString *)detail {

    if ([categoryName isEqualToString:@""]) {
        return;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), categoryName];
    NSString *detailFile = [NSString stringWithFormat:@"%@/Details.plist", path];


    NSMutableArray *detailArray;

    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:detailFile];
    if ([array count])
        detailArray = [[NSMutableArray alloc] initWithArray:array copyItems:YES];
    else
        detailArray = [[NSMutableArray alloc] init];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    UIActionSheet *progressSheet = [[UIActionSheet alloc] initWithTitle:@"正在导入图片..." delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    progressSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    CGRect progressViewFrame = progressView.frame;
    progressViewFrame.size.width = [[UIScreen mainScreen] bounds].size.width;
    progressView.frame = progressViewFrame;
    kProgressView = progressView;
    kProgressSheet = progressSheet;
    progressView.progress = 0;
    [progressSheet addSubview:progressView];
    [progressView release];
    [progressSheet showInView:self.view];
    [progressSheet release];
    
    kProgressValue = 1.f / (float)[_selectedImages count];
    
    for (int i = 0; i < [_selectedImages count]; i++) {
        UIImage *image = [_selectedImages objectAtIndex:i];
        NSString *date = [NSString stringWithFormat:@"%@%d", [[NSDate date] description], i];
        NSString *name = [Hash md5:date];
        ImageSavingOperation *operation = [[[ImageSavingOperation alloc] init] autorelease];
        operation.image = image;
        operation.path = path;
        operation.name = name;
        operation.detail = detail;
        operation.parent = self;
        [_saveQueue addOperation:operation];
    }
    [self clearSelected];
    [detailArray release];
}

- (void)changeImportProgress {
    if (kProgressValue > 0) {
        kProgressView.progress += kProgressValue;
        NSLog(@"Progress:%f", kProgressView.progress);
    }
    if (kProgressView.progress + kProgressValue > 1.f) {
        [kProgressSheet dismissWithClickedButtonIndex:0 animated:YES];
        kProgressSheet = nil;
        kProgressValue = 0.f;
        kProgressView = nil;
    }
    if (_isUsingCamera) {
        [self dismissModalViewControllerAnimated:YES];
    }
}

@end
