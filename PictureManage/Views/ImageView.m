//
//  ImageView.m
//  Uzai
//
//  Created by yh on 11-5-25.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "ImageView.h"

@implementation ImageView
@synthesize imageView;
@synthesize imageObject;
@synthesize imageViewDelegate,tag;

-(id)initWithFrame:(CGRect)frame imageURL:(NSString *)aImageURL{
    self = [super initWithFrame:frame];
    if(self){
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        imageView.image = [UIImage imageNamed:aImageURL];
        [self addSubview:imageView];
        
    }
    return self;
    
}
-(void)setupImageView:(NSString *)aImageURL{
    if(aImageURL !=@"" && aImageURL){
        [imageView setImage:[UIImage imageNamed:aImageURL]];
    }
    
}

-(void)setUpimage:(UIImage*)aImage{
    [imageView setImage:aImage];
}


-(void)dealloc{
    [imageView release];
    [super dealloc];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    isPressOperate =YES;
    [super touchesBegan:touches withEvent:event];
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (isPressOperate) {
        if (self.imageViewDelegate && [self.imageViewDelegate respondsToSelector:@selector(onClickEvent:imageObject:)]) {
                [self.imageViewDelegate onClickEvent:self imageObject:self.imageObject];
        }
    }
     [super touchesEnded:touches withEvent:event];
}



@end
