//
//  ViewController.m
//  flyingV
//
//  Created by Brittny Wright on 6/3/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    lengthOfViewController=568;
    widthOfViewController=320;
    
  
    
    
    gameTimer=[[NSTimer alloc] init];
    
    gameTimer=[NSTimer scheduledTimerWithTimeInterval:.09 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    count=0;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)gameLoop
{
    if(count%100==0)
    {
        UIImageView * bird=[self createBirdImage];
        [self animateBird:bird];
        
    }
    
    NSLog([NSString stringWithFormat:@"%i",count] );
    count++;
    
}

-(void)animateBird: (UIImageView*) bird
{
    [UIView animateWithDuration:0.01 animations:^(void)
    {
        bird.frame=CGRectMake(widthOfViewController/2, lengthOfViewController, bird.frame.size.width, bird.frame.size.height);
    }
completion:^(BOOL finished){}];
}
-(UIImageView*)createBirdImage
{
    
    UIImageView * bird = [[UIImageView alloc] initWithFrame:CGRectMake(widthOfViewController/2, -(_birdImage.frame.size.height), _birdImage.frame.size.width, _birdImage.frame.size.height)];
    bird.image=[UIImage imageNamed:@"dragon.png"];
    [self.view addSubview:bird];
    [self.view sendSubviewToBack:bird];
    
    return bird;
                            
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    
    location.y-=60;
    
    _birdImage.center=location;
    
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    
    location.y-=60;
    
    _birdImage.center=location;
    
}














- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
