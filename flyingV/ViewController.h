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
    
    float gravity;
    float accel;
    float gravityLine;
    bool passedGravityLine;
    
    float Ygravity;
    float Yaccel;
    float YgravityLine;
    bool passedYgravityLine;
    
    NSTimer * gameTimer;
    int count;
    
    
}

-(void)animateBird1;

@property (strong, nonatomic) IBOutlet UIImageView *birdImage;




@end
