//
//  ImageImporterController.h
//  almondz
//
//  Created by 卞中杰 on 11-7-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DialogView.h"
@interface ImageImporterController : UIImagePickerController <DialogViewDelegate, UIActionSheetDelegate> {
    DialogView *_dialogView;
    NSInteger _imageNumber; //使用图库导入时选中照片的张数
    UIButton *_imageSelectedInfo;
    NSMutableArray *_selectedImages;
    NSOperationQueue *_saveQueue;
    BOOL _isUsingCamera;    //是否是使用照相机导入，必须设置
}
@property (nonatomic, retain) DialogView *dialogView;
@property (nonatomic, assign) NSInteger imageNumber;
@property (nonatomic, retain) NSMutableArray *selectedImages;
@property (nonatomic, assign) BOOL isUsingCamera;
- (id)initWithCamera:(BOOL)isUsingCamera;
- (void)updateToolBarInfo;
- (void)showDialogView;
@end
