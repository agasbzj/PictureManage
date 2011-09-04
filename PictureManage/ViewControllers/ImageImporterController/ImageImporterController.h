//
//  ImageImporterController.h
//  almondz
//
//  Created by 卞中杰 on 11-7-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DialogView.h"
@protocol ImageImporterDelegate <NSObject>

-(void)ImageImporterFinsh:(NSString *)categateName;

@end

@interface ImageImporterController : UIImagePickerController<UIImagePickerControllerDelegate,DialogViewDelegate>{
    NSInteger _imageNumber; //使用图库导入时选中照片的张数
    UIButton *_imageSelectedInfo;
    NSMutableArray *_selectedImages;
    BOOL _isUsingCamera;    //是否是使用照相机导入，必须设置
    DialogView *_dialogView;
      NSOperationQueue *_saveQueue;

}
@property (nonatomic, retain) NSMutableArray *selectedImages;
@property(nonatomic,assign) BOOL isUsingCamera;
@property(nonatomic,assign)id<ImageImporterDelegate> delegate;

- (id)initWithCamera:(BOOL)isUsingCamera;
-(void)updateToolBarInfo;

@end

