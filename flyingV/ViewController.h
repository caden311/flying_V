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
    NSMutableArray * leftBirds;
    NSMutableArray * rightBirds;
    float sizeModifier;
    float newBirdSizeModifier;
    
    //array flying objects
    NSMutableArray * flyingBirdsArray;
    NSMutableArray * flyingObjectsArray;
    
        //animation variables
    
    int numBirdAnimations;
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
    
    bool birdClose;
    float animationSpeedModifier;

    int randX;
    int randY;
    int randDirection;
    
    NSTimer * gameTimer;
    int count;
    
    bool birdCaught;
    
    int birdCount;
    int highBirdCount;
    
    //collission animations
    float collisionSpeed;
    bool collisionAnimationInProgress;
    UIImageView * animatingObject;
    bool birdHit;
    int collisionRand;
    
}

-(void)animateBird1;

@property (strong, nonatomic) IBOutlet UIImageView *headBird;

@property (strong, nonatomic) IBOutlet UILabel *highScoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *currentScore;


@end
