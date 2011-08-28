//
//  TestViewController.h
//  PictureManage
//
//  Created by uzai on 11-8-26.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFOpenFlowView.h"

@interface TestViewController : UIViewController<AFOpenFlowViewDelegate,AFOpenFlowViewDataSource> {
    AFOpenFlowView * afOpenFlowView;

      NSMutableArray *coverImageData;

}

@end
