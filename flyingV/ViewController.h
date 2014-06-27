//
//  ViewController.h
//  flyingV
//
//  Created by Brittny Wright on 6/3/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    int lengthOfViewController;
    int widthOfViewController;
    NSMutableArray * birds;
    float sizeModifier;
    float newBirdSizeModifier;
    
        //animation variables
    int randAnimation;
    float animationSpeed;
    bool animateInProgress;
    int animationCounter;
    float animationModifier;
    UIImageView *animatingBird;

    NSTimer * animateTimer;
    
    float gravity2;
    float accel2;
    float gravity2Line;
    bool passedGravity2Line;
    
    float gravity3;
    float accel3;
    float gravity3Line;
    bool passedgravity3Line;
    
    float gravity4;
    float accel4;
    float gravity4Line;
    bool passedGravityLine4;

    int randX;
    int randY;
    
    NSTimer * gameTimer;
    int count;
    
    bool birdCaught;
    
    
}

-(void)animateBird1;

@property (strong, nonatomic) IBOutlet UIImageView *birdImage;




@end
