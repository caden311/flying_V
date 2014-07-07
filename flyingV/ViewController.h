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
   

    NSTimer * animateTimer;
    
    float verticalGravityLine;
    float horizontalGravityLine;
    
 
    
    NSTimer * gameTimer;
    int count;
    
  
    
    int birdCount;
    int highBirdCount;
    
    //collission animations
    int numCollisionAnimations;
       int collisionRand;
  
    
}


@property (strong, nonatomic) IBOutlet UIImageView *headBird;

@property (strong, nonatomic) IBOutlet UILabel *highScoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *currentScore;


@end
