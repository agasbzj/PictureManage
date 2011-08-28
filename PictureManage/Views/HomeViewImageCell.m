//
//  HomeViewImageCell.m
//  PictureManage
//
//  Created by uzai on 11-8-25.
//  Copyright 2011年 UZAI. All rights reserved.
//

#import "HomeViewImageCell.h"
#import "Picture.h"

#define kLeftImageRect   CGRectMake(20, 10, 80, 80)
#define kMiddleImageRect CGRectMake(120, 10, 80, 80)
#define kRighteImageRect CGRectMake(220, 10, 80, 80)

@implementation HomeViewImageCell
@synthesize puctures,indexPath;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        leftImageView =[[ImageView alloc]initWithFrame:kLeftImageRect imageURL:@"1.jpg"];
        leftImageView.imageViewDelegate =self;
        
        middleImageView =[[ImageView alloc]initWithFrame:kMiddleImageRect imageURL:@"2.jpg"];
        middleImageView.imageViewDelegate =self;
        
        rightImageView =[[ImageView alloc]initWithFrame:kRighteImageRect imageURL:@"3.jpg"];
        rightImageView.imageViewDelegate =self;
        
        
        [self addSubview:leftImageView];
        [self addSubview:middleImageView];
        [self addSubview:rightImageView];
    }
    return  self;
    
}

-(void)fillCell{
    if([self.puctures count]>0){
        NSInteger startIndex = self.indexPath.row * 3;
        NSInteger pictuesCount = [self.puctures count];
        
        for(int i = 0 ;i<3;i++)
        {
            if(i == 0){
                if(startIndex <pictuesCount){
                    [leftImageView setUpimage: [UIImage imageNamed:[[self.puctures objectAtIndex:startIndex] imageUrl]]];
                }
            }
            
            else if (i ==1 ){
                if(startIndex +1 < pictuesCount){
                    [middleImageView setHidden:NO];
                    [middleImageView setUpimage: [UIImage imageNamed:[[self.puctures objectAtIndex:startIndex+1] imageUrl]]];
                }
                else{
                    [middleImageView setHidden:YES];
                }
                
                
            }
            else if (i==2 )
                if(startIndex +2 < pictuesCount){
                    [rightImageView setHidden:NO];
                    [rightImageView setUpimage:[UIImage imageNamed:[[self.puctures objectAtIndex:startIndex+2] imageUrl]]];
                }
                else  {
                    [rightImageView setHidden:YES];
                }
            
            
        }
    }
}

- (void)dealloc
{
    [leftImageView release];
    [middleImageView release];
    [rightImageView release];
    
    [super dealloc];
}

- (void)onClickEvent:(ImageView*)aImageView imageObject:(id)aImageObject{
    NSLog(@"%@",aImageView);
}

@end
