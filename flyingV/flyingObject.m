//
//  flyingObject.m
//  flyingV
//
//  Created by Brittny Wright on 7/2/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import "flyingObject.h"

@implementation flyingObject

-(id)initWithImageAndIndex:(NSString *)imageName :(CGRect)newFrame :(int)newIndex :(float)newSpeed
{
    self = [super init];
    if(self)
    {
        image = [[UIImageView alloc]initWithFrame:newFrame];
        image.image = [UIImage imageNamed:imageName];
        
        isBird = NO;
        index = newIndex;
        speed=newSpeed;
        objectHit=NO;
        livesWorth=3;
        animationInProgress=YES;
        randX=arc4random()%4;
        randY=1;
        randDirection=1;
        objectCloseToHeadBird=NO;
        animationNumber=0;
        
    }
    return self;
}

-(UIImageView *)getImage
{
    return image;
}
-(void)setImage:(UIImageView*)img
{
    image=img;
}
-(void)setIsBird:(BOOL)bird
{
    isBird = bird;
}

-(BOOL)isBird
{
    return isBird;
}

-(void)setIndex:(int)newIndex
{
    index = newIndex;
}

-(int)getIndex
{
    return index;
}
-(float)getSpeed
{
    return speed;
}
-(void)setSpeed:(float)newSpeed
{
    speed=newSpeed;
}
-(void)setObjectHit:(bool)hit
{
    objectHit=hit;
}
-(bool)getObjectHit
{
    return objectHit;
}
-(int)getLivesWorth
{
    return livesWorth;
}
-(void)setLivesWorth:(int)lives
{
    livesWorth=lives;
}
-(bool)getAnimationInProgress
{
    return animationInProgress;
}
-(void)setAnimationInProgress:(bool)inProg
{
    animationInProgress=inProg;
}
-(void)setAnimationNumber:(int)num
{
    animationNumber=num;
}
-(int)getAnimationNumber
{
    return animationNumber;
}

-(int)getRandX
{
    return randX;
}
-(void)setRandX:(int)x
{
    randX=x;
}
-(int)getRandY
{
    return randY;
}
-(void)setRandY:(int)x
{
    randY=x;
}
-(int)getRandDirection
{
    return randDirection;
}
-(void)setRandDirection:(int)x
{
    randDirection=x;
}

-(bool)getObjectCloseToHeadBird
{
    return objectCloseToHeadBird;
}
-(void)setObjectCloseToHeadBird:(bool)x
{
    objectCloseToHeadBird=x;
}
-(UIImageView*)getToImage
{
    return toImage;
}
-(void)setToImage:(CGRect) rect :(NSString *)imageName
{
    toImage = [[UIImageView alloc]initWithFrame:rect];
    toImage.image = [UIImage imageNamed:imageName];
}

@end
