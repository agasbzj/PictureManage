//
//  ShareEditViewController.m
//  PictureManage
//
//  Created by uzai on 11-9-2.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "ShareEditViewController.h"

#import <QuartzCore/QuartzCore.h>
#define kOAuthConsumerKey				@"3983859935"		//REPLACE ME
#define kOAuthConsumerSecret			@"201fea7b1e1203a76a10f3be570f5abb"		//REPLACE ME
@implementation ShareEditViewController
@synthesize image;
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStyleBordered target:self action:@selector(shareSina)];
    self.navigationItem.rightBarButtonItem=rightBarButton;
    [rightBarButton release];
    textview = [[UITextView alloc]initWithFrame:CGRectMake(20, 10, 280, 100)];
    textview.backgroundColor = [UIColor whiteColor];
    textview.text = @"我的照片分享";
    textview.tag = 1;
    [textview setFont:[UIFont systemFontOfSize:14.0]];

       textview.layer.borderWidth = 1;
        textview.layer.cornerRadius = 6;
        textview.layer.masksToBounds = YES; 
    textview.delegate = self;
    [self.view addSubview:textview];
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 120,280,280)];
    [self.view addSubview:imageView];
    draft = [[Draft alloc]initWithType:DraftTypeNewTweet];
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationItem.title=@"新浪分享";
    if (!_engine){
		_engine = [[OAuthEngine alloc] initOAuthWithDelegate: self];
		_engine.consumerKey = kOAuthConsumerKey;
		_engine.consumerSecret = kOAuthConsumerSecret;
	}
    [imageView setImage:self.image];
     [self performSelector:@selector(loadTimeline) withObject:nil afterDelay:0.5f];
}


-(void)dealloc{
    [textview release];
    [imageView release];
    [_engine release];
    [draft release];
    [image release];
	[weiboClient release];
    [super dealloc];
}

-(void)shareSina{
    draft.text=textview.text;
    draft.attachmentImage = self.image;
    [self postNewStatus];
}

-(void)loadTimeline{
    UIViewController *controller = [OAuthController controllerToEnterCredentialsWithEngine: _engine delegate: self];
    if (controller)
		[self presentModalViewController: controller animated: YES];
    else{
		[OAuthEngine setCurrentOAuthEngine:_engine];
        
    }
}

- (void)postNewStatus
{
	WeiboClient *client = [[WeiboClient alloc] initWithTarget:self 
													   engine:[OAuthEngine currentOAuthEngine]
													   action:@selector(postStatusDidSucceed:obj:)];
	client.context = [draft retain];
	draft.draftStatus = DraftStatusSending;
	if (draft.attachmentImage) {
		[client upload:draft.attachmentData status:draft.text];
	}
	else {
		[client post:draft.text];
	}
}

- (void)postStatusDidSucceed:(WeiboClient*)sender obj:(NSObject*)obj;
{
	Draft *sentDraft = nil;
	if (sender.context && [sender.context isKindOfClass:[Draft class]]) {
		sentDraft = (Draft *)sender.context;
		[sentDraft autorelease];
	}
	
    if (sender.hasError) {
        [sender alert];	
        return;
    }
    
    NSDictionary *dic = nil;
    if (obj && [obj isKindOfClass:[NSDictionary class]]) {
        dic = (NSDictionary*)obj;    
    }
	
    if (dic) {
        Status* sts = [Status statusWithJsonDictionary:dic];
		if (sts) {
			//delete draft!
			if (sentDraft) {
				
			}
		}
    }
	[self cancel];
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"分享成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}
#pragma AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
       
}

- (void)cancel {
	textview.text = @"";
	imageView.image = nil;	
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}



#pragma mark-- TextView Delegate

- (void)textViewDidChange:(UITextView *)textView
{
    
}


#pragma mark -- OAuthEngineDelegate
- (void) storeCachedOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

- (void)removeCachedOAuthDataForUsername:(NSString *) username{
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	[defaults removeObjectForKey: @"authData"];
	[defaults synchronize];
}


#pragma mark OAuthSinaWeiboControllerDelegate
- (void) OAuthController: (OAuthController *) controller authenticatedWithUsername: (NSString *) username {
	[self loadTimeline];
}

- (void) OAuthControllerFailed: (OAuthController *) controller {
	
	if (controller) 
		[self presentModalViewController: controller animated: YES];
	
}

- (void) OAuthControllerCanceled: (OAuthController *) controller {
	NSLog(@"Authentication Canceled.");
	if (controller) 
		[self presentModalViewController: controller animated: YES];
	
}

@end
