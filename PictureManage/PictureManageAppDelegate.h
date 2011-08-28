//
//  PictureManageAppDelegate.h
//  PictureManage
//
//  Created by uzai on 11-8-24.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewController;

@interface PictureManageAppDelegate : NSObject <UIApplicationDelegate> {
    HomeViewController *homeViewController;
    UINavigationController *navController;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;



@end
