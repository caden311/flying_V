//
//  tutorialPageController.h
//  flyingV
//
//  Created by Malcolm Geldmacher on 7/18/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tutorialPageController : UIViewController
{
    BOOL nextPressed;
    BOOL animating;
    BOOL goOn;
    NSTimer * gameLoopTimer;
    int animationCount;
}
@property (weak, nonatomic) IBOutlet UILabel *descriptionBox;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
- (IBAction)nextButtonPressed:(id)sender;
- (IBAction)menuButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *speechBox;
@end
