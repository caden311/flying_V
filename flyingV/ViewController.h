//
//  ViewController.h
//  flyingV
//
//  Created by Brittny Wright on 6/3/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartPageController.h"
#import "dataBase.h"
@interface ViewController : UIViewController
{
    NSDate *Date;
    
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
    int timeToCompleteAnimationDuck;
    int distanceBeforeBirdRuns;
    int speedAwayBirdRuns;
    NSTimer * animateTimer;
    
    float verticalGravityLine;
    float horizontalGravityLine;
    
 
    
    NSTimer * gameTimer;
    int count;
    
    //level increase
    int levelIncrease;
    bool startAwayBirds;
    int birdCount;
    int highBirdCount;
    bool stopDumbBirds;
    
    //collission animations
    int numCollisionAnimations;
       int collisionRand;
    
    bool blindSpotsEnabled;
  
    float timeToCompleteAnimation;
    
    int bgImageCount;
    int bgImageIndex;
    UIImageView * background1;
    UIImageView * background2;
    NSMutableArray * bgImageArray;
    BOOL bgInTransition;
    
    int levelDuration;
    BOOL levelIndicatorIsDisplaying;
    int levelNumber;
    BOOL veryFirstLoop;
    CGPoint headBirdChasePoint;
}

@property (strong, nonatomic) database * db;
@property (strong, nonatomic) IBOutlet UIImageView *headBird;

@property (strong, nonatomic) IBOutlet UILabel *highScoreLabel;

@property (strong, nonatomic) IBOutlet UILabel *currentScore;
@property (weak, nonatomic) IBOutlet UILabel *levelIndicator;

@property (strong, nonatomic) IBOutlet UILabel *currentTime;

- (IBAction)pausePlayButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *pausePlayOutlet;

@end
