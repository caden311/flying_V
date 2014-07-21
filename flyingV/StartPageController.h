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

@interface StartPageController : UIViewController
{
    NSTimer * startPageGameTimer;
    CGPoint startPageHeadBirdChasePoint;
}


@property (strong, nonatomic) database * db;
@property (strong, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *longestTimeLabel;


@end
