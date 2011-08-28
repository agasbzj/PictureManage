//
//  PictureManageAppDelegate.m
//  PictureManage
//
//  Created by uzai on 11-8-24.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "PictureManageAppDelegate.h"

#import "HomeViewController.h"

@implementation PictureManageAppDelegate


@synthesize window=_window;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    homeViewController = [[HomeViewController alloc]init];
    navController = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)dealloc
{
    [_window release];
    [navController release];
    [homeViewController release];
    [super dealloc];
}

@end
