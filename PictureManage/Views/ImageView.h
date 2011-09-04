//
//  ImageView.h
//  Uzai
//
//  Created by rex on 11-8-25.
//  Copyright 2011年 UZAI. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol ImageViewDelegate;
@interface ImageView : UIView
{
    UIImageView*                imageView;  
    
    Boolean                     isPressOperate;           
                     
   }

@property (nonatomic, assign)UIImageView*               imageView;
@property (nonatomic, assign)id                         imageObject;
@property (nonatomic, assign)id<ImageViewDelegate>      imageViewDelegate;
@property (nonatomic, assign)int      tag;


- (id)initWithFrame:(CGRect)frame
          imageURL:(NSString*)aImageURL
          ;
    

- (void)setupImageView:(NSString*)aImageURL;

-(void)setUpimage:(UIImage*)aImage;
@end


// ImageView代理
@protocol ImageViewDelegate<NSObject>

@optional
// 点击图片回调
- (void)onClickEvent:(ImageView*)aImageView imageObject:(id)aImageObject;



@end
