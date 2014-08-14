//
//  tutorialPageController.m
//  flyingV
//
//  Created by Malcolm Geldmacher on 7/18/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import "tutorialPageController.h"
#import "Bird.h"
@interface tutorialPageController ()

@end

@implementation tutorialPageController

- (void)viewDidLoad
{
    [super viewDidLoad];
   lengthOfViewController=self.view.frame.size.height;
    widthOfViewController=self.view.frame.size.width;
    // Do any additional setup after loading the view.
    nextPressed = NO;
    animating = NO;
    goOn = YES;
    //[self animation1];
    animationCount = 1;
    gameLoopTimer=[NSTimer scheduledTimerWithTimeInterval:.016 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
   
    
    
    

    

  
}

-(void)gameLoop
{
    if(goOn)
    {
        goOn = NO;
        switch (animationCount)
        {
            case 1:
                [self animation1];
                [self animateFirstBird];
                break;
            case 2:
                [self animation2];
                break;
            case 3:
                [self animation3];
                break;
            case 4:
                [self animation4];
                break;
            case 5:
                [self animation5];
                break;
            default:
                break;
        }
        animationCount += 1;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)takeTime
{
    NSLog(@"Waiting...");
}

-(void)animateBox
{

   
    [UIView animateWithDuration:0.5
            animations:^void
            {
                [_speechBox setAlpha:1.0];
            }
            completion:^(BOOL finished)
            {
                if(finished)
                {
                    if(!nextPressed)
                    {
                        [self animateBoxUp];
                    }
                    else
                    {
                        [self animateBoxOut];
                    }
                }
            }
     ];
}
-(void)animateFirstBird
{
    _headBird.frame=CGRectMake(widthOfViewController/2, -(lengthOfViewController*2), _headBird.frame.size.width, _headBird.frame.size.height);
    
    [UIView animateWithDuration:2.0
                     animations:^void
        {
            _speechLabel.text=@"This is your Bird.. You can move him around with your finger!";
            [_headBird setFrame:CGRectMake((widthOfViewController/2-(_headBird.frame.size.width/2)), lengthOfViewController/2, _headBird.frame.size.width, _headBird.frame.size.height)];
        }
                     completion:^(BOOL finished)
     {
   
     }
     ];

}
-(void)animateBoxUp
{
    [UIView animateWithDuration:0.5
            animations:^void
            {
                 _speechLabel.frame=CGRectMake(_speechLabel.frame.origin.x, _speechLabel.frame.origin.y-10, _speechLabel.frame.size.width, _speechLabel.frame.size.height);
                [_speechBox setFrame:CGRectMake(_speechBox.frame.origin.x, _speechBox.frame.origin.y - 10, _speechBox.frame.size.width, _speechBox.frame.size.height)];
            }
            completion:^(BOOL finished)
            {
                if(finished)
                {
                    if(!nextPressed)
                    {
                        [self animateBoxDown];
                    }
                    else
                    {
                        [self animateBoxOut];
                    }
                }
            }
     ];
}

-(void)animateBoxDown
{
    [UIView animateWithDuration:0.5
            animations:^void
            {
                [_speechBox setFrame:CGRectMake(_speechBox.frame.origin.x, _speechBox.frame.origin.y + 10, _speechBox.frame.size.width, _speechBox.frame.size.height)];
                 _speechLabel.frame=CGRectMake(_speechLabel.frame.origin.x, _speechLabel.frame.origin.y+10, _speechLabel.frame.size.width, _speechLabel.frame.size.height);
            }
            completion:^(BOOL finished)
            {
                if(finished)
                {
                    if(!nextPressed)
                    {
                        [self animateBoxUp];
                    }
                    else
                    {
                        [self animateBoxOut];
                    }
                }
            }
     ];
}

-(void)animateBoxOut
{
    nextPressed = NO;
    [UIView animateWithDuration:0.5
            animations:^void
            {
                [_speechBox setAlpha:0.0];
            }
            completion:^(BOOL finished)
            {
                if(finished)
                {
                    goOn = YES;
                }
            }
     ];
}

-(void)animation1
{
    
    //Do animation stuff
    [self animateBox];
    
    
    
    
    
    
}

-(void)animation2
{
    //Do animation stuff
    [self animateBox];
}

-(void)animation3
{
    //Do animation stuff
    [self animateBox];
}

-(void)animation4
{
    //Do animation stuff
    [self animateBox];
}

-(void)animation5
{
    //Do animation stuff
    [self animateBox];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    location.y-=60;
    _headBird.center = location;
   // [self moveBirds: location];
    //_birdImage.center=location;
    
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    location.y-=60;
    _headBird.center = location;
    //[self moveBirds: location];
    //_birdImage.center=location;
    
}


- (IBAction)nextButtonPressed:(id)sender
{
    nextPressed = YES;

    //[self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)menuButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
