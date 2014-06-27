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
    lengthOfViewController=self.view.frame.size.height;
    widthOfViewController=self.view.frame.size.width;
    
    gameTimer=[[NSTimer alloc] init];
    sizeModifier = 0.9;
    newBirdSizeModifier = 1.0;
    
    //animation variables
    randAnimation=0;
    animationSpeed=3;
    animateInProgress=NO;
    animationCounter=0;
    animationModifier=5;
    animatingBird=[[UIImageView alloc] init];
   
    gravity2=-.75;
    gravity3= .75;
    gravity4= .002;
    
    accel2=0;
    accel3=0;
    accel4=0;
    
    gravity2Line=widthOfViewController/2;
    gravity3Line = lengthOfViewController / 2;
    gravity4Line=lengthOfViewController/2;
    
    randX=0;
    randY=0;
    
    birdCaught=NO;
    
    passedGravity2Line=NO;
    passedGravityLine4=NO;
    passedgravity3Line=NO;
    
    animatingBird=[[UIImageView alloc] initWithFrame:CGRectMake(widthOfViewController - 75, 0, _birdImage.frame.size.width, _birdImage.frame.size.height)];
    animatingBird.image=[UIImage imageNamed:@"dragon.png"];
    [self.view addSubview:animatingBird];
    [self.view sendSubviewToBack:animatingBird];

    
    
    animateTimer=[[NSTimer alloc] init];
  
    gameTimer=[NSTimer scheduledTimerWithTimeInterval:.016 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    
    
    
    count=0;
    birds = [[NSMutableArray alloc]init];
    [birds addObject:_birdImage];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)gameLoop
{
    
  
    [self collisionChecking];
    [self upDateAnimations];
    
    
    count += 1;
}

-(void)collisionChecking
{
    
    if(CGRectIntersectsRect(_birdImage.frame, animatingBird.frame)&&birdCaught==NO)
    {
        UIImageView * bird=[self createBirdImage];
        [birds addObject:bird];
        if(birds.count % 5 == 0)
        {
            for(int i = 1; i < birds.count; i += 1)
            {
                UIImageView * tempBird = [birds objectAtIndex:i];
                [tempBird setFrame:CGRectMake(tempBird.frame.origin.x, tempBird.frame.origin.y, tempBird.frame.size.width * sizeModifier, tempBird.frame.size.height * sizeModifier)];
            }
            newBirdSizeModifier *= sizeModifier;
        }
        count = 0;
        birdCaught=YES;
        animatingBird.hidden=YES;
    }
    
}

-(void)upDateAnimations
{
    
    if(animateInProgress==NO)
    {
        passedGravity2Line=NO;
        
        accel2=0;
        accel3=0;
        
        accel4=0;
        gravity4= .05;
        
        animateInProgress=YES;
        animatingBird=[self createBirdImage];
        animateInProgress=YES;
        
        int randDirection=(arc4random() % 2 ? 1 : -1);
        
        randY=arc4random()%7+1;
        randX=(1+arc4random()%5)*randDirection;
        if(randX>=0)
        {
            animatingBird.frame=CGRectMake(0, -(animatingBird.frame.size.height), animatingBird.frame.size.width, animatingBird.frame.size.height);
        }
        else
        {
            animatingBird.frame=CGRectMake(lengthOfViewController, -(animatingBird.frame.size.height), animatingBird.frame.size.width, animatingBird.frame.size.height);
        }
        
        
        
        
        //animtaion 1&2
         //animatingBird.frame=CGRectMake(widthOfViewController, 0, animatingBird.frame.size.width, animatingBird.frame.size.height);
        
        //animtaion 3
        //animatingBird.frame=CGRectMake(widthOfViewController, animatingBird.frame.size.height*3, animatingBird.frame.size.width, animatingBird.frame.size.height);
        
        //animmation 4
        //animatingBird.frame=CGRectMake(widthOfViewController-animatingBird.frame.size.width, 0, animatingBird.frame.size.width, animatingBird.frame.size.height);
        
        // int y=animatingBird.frame.origin.y;
        // int x= animatingBird.frame.origin.x;
        // NSLog([NSString stringWithFormat:@"BEGGG Y %i",y]);
        //  NSLog([NSString stringWithFormat:@"BEGGG X %i",x]);
        
    }
    
    if(animateInProgress==YES)
    {
        [self animateBird5];
        //[self animateBird1];
    }
}
-(void)endingAnimation
{
    if(animatingBird.frame.origin.y>lengthOfViewController)
    {
        animateInProgress=NO;
        animatingBird.hidden=YES;
        birdCaught=NO;
        passedGravityLine4=NO;
        
        
    }
    
}
-(void)animateBird1
{
    if(animationCounter%50==0)
    {
        animationModifier*=-1;
    }
    animatingBird.frame=CGRectMake(animatingBird.frame.origin.x+animationModifier, animatingBird.frame.origin.y+animationSpeed, animatingBird.frame.size.width, animatingBird.frame.size.height);
   
    [self endingAnimation];
  
    animationCounter++;
}
-(void)animateBird2
{
    if(animatingBird.center.x<gravity2Line)
    {
        if(passedGravity2Line==NO)
        {
            gravity2*=-1;
            passedGravity2Line=YES;
        }
    }
    else if(animatingBird.center.x>gravity2Line)
    {
        if(passedGravity2Line==YES)
        {
            gravity2*=-1;
            passedGravity2Line=NO;
        }
    }
    //NSLog([NSString stringWithFormat:@"Y value %f",animatingBird.frame.origin.y]);
    //NSLog([NSString stringWithFormat:@"X value %f",animatingBird.frame.origin.x]);
    animatingBird.frame=CGRectMake(animatingBird.frame.origin.x+accel2, animatingBird.frame.origin.y+animationSpeed, animatingBird.frame.size.width, animatingBird.frame.size.height);
    
    accel2=accel2+gravity2;
    //NSLog([NSString stringWithFormat:@"%f", accel]);
    
  [self endingAnimation];
}

-(void)animateBird3
{
    if(animatingBird.center.y>gravity3Line)
    {
        if(passedgravity3Line==NO)
        {
          
            gravity3*=-1;
            passedgravity3Line=YES;
        }
    }
    else if(animatingBird.center.y<gravity3Line)
    {
        if(passedgravity3Line==YES)
        {
          
            gravity3*=-1;
            passedgravity3Line=NO;
        }
    }
  

    animatingBird.frame=CGRectMake(animatingBird.frame.origin.x-animationSpeed, animatingBird.frame.origin.y+accel3, animatingBird.frame.size.width, animatingBird.frame.size.height);
    
    
    accel3=accel3+gravity3;
 
    
  [self endingAnimation];
}

-(void)animateBird4
{
    
    if(passedGravityLine4==NO)
    {
        if(animatingBird.center.y>gravity4Line)
        {
        
           // animatingBird.center=CGPointMake(gravity4Line, animatingBird.center.y);
            gravity4*=-1;
            accel4*=-1;
            passedGravityLine4=YES;
        
        }
    }
    
     animatingBird.frame=CGRectMake(animatingBird.frame.origin.x-accel4, animatingBird.frame.origin.y+animationSpeed, animatingBird.frame.size.width, animatingBird.frame.size.height);
 
    accel4=accel4+gravity4;
    
   [self endingAnimation];
    
}
-(void)animateBird5
{
        animatingBird.frame=CGRectMake(animatingBird.frame.origin.x+randX, animatingBird.frame.origin.y+randY, animatingBird.frame.size.width, animatingBird.frame.size.height);
 
[self endingAnimation];
}


-(UIImageView*)createBirdImage
{
    
    UIImageView * bird = [[UIImageView alloc] initWithFrame:CGRectMake(widthOfViewController/2, -(_birdImage.frame.size.height), _birdImage.frame.size.width * newBirdSizeModifier, _birdImage.frame.size.height * newBirdSizeModifier)];
    bird.image=[UIImage imageNamed:@"dragon.png"];
    [self.view addSubview:bird];
    [self.view sendSubviewToBack:bird];
   // NSLog([NSString stringWithFormat:@"%f", newBirdSizeModifier]);
    UIImageView * temp = [birds objectAtIndex:0];
    CGPoint newBirdLocation = temp.center;
    //NSLog([NSString stringWithFormat:@"Passing:(%f, %f)", temp.center.x, temp.center.y]);
    [self moveBirds:newBirdLocation];
    return bird;
                            
}


-(void)moveBirds:(CGPoint)location
{
    UIImageView * bird = [birds objectAtIndex:0];
    //NSLog([NSString stringWithFormat:@"Received:(%f, %f)", location.x, location.y]);
    bird.center = location;
    //NSLog([NSString stringWithFormat:@"Set:(%f, %f)", bird.center.x, bird.center.y]);
  //  NSLog([NSString stringWithFormat:@"%d", birds.count]);
    if(birds.count > 1)
    {
        int leftOrRight = -1;
        for(int i = 0; i < birds.count - 1; i++)
        {
            CGPoint movePoint = location;
            bird = [birds objectAtIndex:i + 1];
            float moveDistY = 30 * newBirdSizeModifier;
            float moveDistX = 15 * newBirdSizeModifier;
            movePoint.y += moveDistY + (moveDistY * (i / 2));
            movePoint.x += (moveDistX * leftOrRight) + (moveDistX * leftOrRight * (i/2));
            bird.center = movePoint;
            leftOrRight *= -1;
        }
    }
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    
    location.y-=60;
    [self moveBirds: location];
    //_birdImage.center=location;
    
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    
    location.y-=60;
    [self moveBirds: location];
    //_birdImage.center=location;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
