//
//  PictureDetailViewController.h
//  PictureManage
//
//  Created by uzai on 11-8-28.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Picture.h"


@interface PictureDetailViewController : UIViewController<UIScrollViewDelegate> {
    UIScrollView * scrollView;
}

@property(nonatomic,retain)NSMutableArray * pictures;
@property(nonatomic,assign)NSInteger index;




@end
