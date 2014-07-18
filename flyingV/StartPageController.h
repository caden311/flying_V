//
//  StartPageController.h
//  flyingV
//
//  Created by Brittny Wright on 7/10/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ViewController.h"
#include "dataBase.h"

@interface StartPageController : ViewController
{
    NSTimer * startPageGameTimer;
    CGPoint startPageHeadBirdChasePoint;
}


@property (strong, nonatomic) database * db;
@property (strong, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *longestTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *highSeconds;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *tutorialButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIButton *statsButton;
@property (weak, nonatomic) IBOutlet UIButton *gameCenterButton;
- (IBAction)playButtonPressed:(id)sender;
- (IBAction)tutorialButtonPressed:(id)sender;
- (IBAction)settingsButtonPressed:(id)sender;
- (IBAction)statsButtonPressed:(id)sender;
- (IBAction)gameCenterButtonPressed:(id)sender;

@end
