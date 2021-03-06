//
//  flyingObject.h
//  flyingV
//
//  Created by Brittny Wright on 7/2/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface flyingObject : NSObject
{
    UIImageView * image;
    UIImageView * toImage;
    BOOL isBird;
    int index;
    float speed;
    BOOL objectHit;
    int livesWorth;
    bool animationInProgress;
    int animationNumber;
    
    //rand's
    int randX;
    int randY;
    int randDirection;
    
    //gravity/accel

    bool objectCloseToHeadBird;
}

-(id) initWithImageAndIndex:(NSString*) imageName :(CGRect) newFrame :(int) newIndex :(float)newSpeed;
-(BOOL) isBird;
-(int) getIndex;
-(void) setIsBird:(BOOL)isBird;
-(void) setIndex:(int)newIndex;
-(float)getSpeed;
-(void)setSpeed:(float)speed;
-(UIImageView*) getImage;
-(void)setImage:(UIImageView*)img;
-(void)setObjectHit:(bool)hit;
-(bool)getObjectHit;
-(int)getLivesWorth;
-(void)setLivesWorth:(int)lives;
-(bool)getAnimationInProgress;
-(void)setAnimationInProgress:(bool)inProg;
-(void)setAnimationNumber:(int)num;
-(int)getAnimationNumber;
-(int)getRandX;
-(void)setRandX:(int)x;
-(int)getRandY;
-(void)setRandY:(int)x;
-(int)getRandDirection;
-(void)setRandDirection:(int)x;


-(bool)getObjectCloseToHeadBird;
-(void)setObjectCloseToHeadBird:(bool)x;

-(UIImageView*)getToImage;
-(void)setToImage:(CGRect) rect :(NSString*)imName;


@end
