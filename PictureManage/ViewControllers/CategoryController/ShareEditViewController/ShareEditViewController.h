//
//  ShareEditViewController.h
//  PictureManage
//
//  Created by uzai on 11-9-2.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthController.h"
#import "WeiboClient.h"
#import "draft.h"
   @class OAuthEngine;
@interface ShareEditViewController : UIViewController<OAuthControllerDelegate,UITextViewDelegate> {
 
    UITextView* textview;
    UIImageView *imageView;
    OAuthEngine				*_engine;
	WeiboClient *weiboClient;
    Draft *draft;
}

@property(nonatomic, retain)UIImage *image;
-(void)postNewStatus;
- (void)cancel;
@end
