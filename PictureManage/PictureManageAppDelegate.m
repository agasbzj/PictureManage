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

+(PictureManageAppDelegate  *)getAppDelegate{
    return (PictureManageAppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark -
#pragma mark Alert

static UIAlertView *sAlert = nil;

- (void)alert:(NSString*)title message:(NSString*)message
{
    if (sAlert) return;
    
    sAlert = [[UIAlertView alloc] initWithTitle:title
                                        message:message
									   delegate:self
							  cancelButtonTitle:@"Close"
							  otherButtonTitles:nil];
    [sAlert show];
    [sAlert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonInde
{
    sAlert = nil;
}




@end
