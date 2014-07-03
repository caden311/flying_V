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
        livesWorth=0;
        animationInProgress=NO;
        
    }
    return self;
}

-(UIImageView *)getImage
{
    return image;
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

@end
