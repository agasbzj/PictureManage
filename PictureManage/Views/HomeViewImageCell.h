//
//  HomeViewImageCell.h
//  PictureManage
//
//  Created by uzai on 11-8-25.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageView.h"

@interface HomeViewImageCell : UITableViewCell <ImageViewDelegate>{
    ImageView *leftImageView;
    ImageView *middleImageView;
    ImageView *rightImageView;
}

@property(nonatomic,retain) NSMutableArray *puctures;
@property(nonatomic,retain) NSIndexPath * indexPath;
-(void)fillCell;
@end
