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
    animationSpeed=.5;
    animateInProgress=NO;
    animationCounter=0;
    animationModifier=.25;
    animatingBird=[[UIImageView alloc] init];
   
    
    
    gravity=-.01;
    accel=0;
    gravityLine=widthOfViewController/2;
    passedGravityLine=NO;
    
    Ygravity=.01;
    Yaccel=0;
    YgravityLine=lengthOfViewController/2;
    passedYgravityLine=NO;
    
    
    animateTimer=[[NSTimer alloc] init];
  
    gameTimer=[NSTimer scheduledTimerWithTimeInterval:.09 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    
    
    
    count=0;
    birds = [[NSMutableArray alloc]init];
    [birds addObject:_birdImage];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)gameLoop
{
    if(count%10==0)
    {
        UIImageView * bird=[self createBirdImage];
        //[self animateBird:bird];
        [birds addObject:bird];
        if(birds.count % 3 == 0)
        {
            for(int i = 0; i < birds.count; i += 1)
            {
                UIImageView * tempBird = [birds objectAtIndex:i];
                [tempBird setFrame:CGRectMake(tempBird.frame.origin.x, tempBird.frame.origin.y, tempBird.frame.size.width * sizeModifier, tempBird.frame.size.height * sizeModifier)];
            }
            newBirdSizeModifier *= sizeModifier;
        }
    }
    
 
        
        if(animateInProgress==NO)
        {
            passedGravityLine=NO;
            gravity=-.01;
            accel=0;
            animatingBird=[self createBirdImage];
            animateInProgress=YES;
        
            
            //animtaion 1&2
            //animatingBird.frame=CGRectMake(widthOfViewController, 0, animatingBird.frame.size.width, animatingBird.frame.size.height);
            
            //animtaion 3
             animatingBird.frame=CGRectMake(widthOfViewController, animatingBird.frame.size.height*2, animatingBird.frame.size.width, animatingBird.frame.size.height);
          
            
            
            // int y=animatingBird.frame.origin.y;
           // int x= animatingBird.frame.origin.x;
           // NSLog([NSString stringWithFormat:@"BEGGG Y %i",y]);
          //  NSLog([NSString stringWithFormat:@"BEGGG X %i",x]);
           
        }
    
        if(animateInProgress==YES)
        {
            animateTimer=[NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(animateBird3) userInfo:nil repeats:YES];
        }
        
    
    

    
    
}

-(void)animateBird1
{
    if(animationCounter%600==0)
    {
        animationModifier*=-1;
    }
    animatingBird.frame=CGRectMake(animatingBird.frame.origin.x+animationModifier, animatingBird.frame.origin.y+animationSpeed, animatingBird.frame.size.width, animatingBird.frame.size.height);
   
    
    if(animatingBird.center.y>lengthOfViewController)
    {
        
        animateInProgress=NO;
        [animateTimer invalidate];
    }
    animationCounter++;
}
-(void)animateBird2
{
    if(animatingBird.center.x<gravityLine)
    {
        if(passedGravityLine==NO)
        {
            accel=-1.8;
            gravity*=-1;
            passedGravityLine=YES;
        }
    }
    else if(animatingBird.center.x>gravityLine)
    {
        if(passedGravityLine==YES)
        {
            accel=1.8;
            gravity*=-1;
            passedGravityLine=NO;
        }
    }
    int y=animatingBird.frame.origin.y;
    int x= animatingBird.frame.origin.x;
    NSLog([NSString stringWithFormat:@"Y value %i",y]);
    NSLog([NSString stringWithFormat:@"X value %i",x]);
    animatingBird.frame=CGRectMake(animatingBird.frame.origin.x+accel, animatingBird.frame.origin.y+animationSpeed, animatingBird.frame.size.width, animatingBird.frame.size.height);
    
  
        accel=accel+gravity;
    
   // NSLog([NSString stringWithFormat:@"%f",accel]);
    
    if(animatingBird.center.y>lengthOfViewController)
    {
        //[animatingBird removeFromSuperview];
        animateInProgress=NO;
        [animateTimer invalidate];
        
    }
}

-(void)animateBird3
{
    if(animatingBird.center.y>YgravityLine)
    {
        if(passedYgravityLine==NO)
        {
            //Yaccel=-1.8;
            Ygravity*=-1;
            passedYgravityLine=YES;
        }
    }
    else if(animatingBird.center.y<YgravityLine)
    {
        if(passedYgravityLine==YES)
        {
            //Yaccel=1.8;
            Ygravity*=-1;
            passedYgravityLine=NO;
        }
    }
    //int y=animatingBird.frame.origin.y;
   // int x= animatingBird.frame.origin.x;

    animatingBird.frame=CGRectMake(animatingBird.frame.origin.x-animationSpeed, animatingBird.frame.origin.y+Yaccel, animatingBird.frame.size.width, animatingBird.frame.size.height);
    
    
    Yaccel=Yaccel+Ygravity;
 
    
    if(animatingBird.center.y<0)
    {
        //[animatingBird removeFromSuperview];
        animateInProgress=NO;
        [animateTimer invalidate];
        
    }
}



-(UIImageView*)createBirdImage
{
    
    UIImageView * bird = [[UIImageView alloc] initWithFrame:CGRectMake(widthOfViewController/2, -(_birdImage.frame.size.height), _birdImage.frame.size.width * newBirdSizeModifier, _birdImage.frame.size.height * newBirdSizeModifier)];
    bird.image=[UIImage imageNamed:@"dragon.png"];
    [self.view addSubview:bird];
    [self.view sendSubviewToBack:bird];
   // NSLog([NSString stringWithFormat:@"%f", newBirdSizeModifier]);
    return bird;
                            
}


-(void)moveBirds:(CGPoint)location
{
    UIImageView * bird = [birds objectAtIndex:0];
    bird.center = location;
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
    
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    
    location.y-=60;
    [self moveBirds: location];
    //_birdImage.center=location;
    
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event

{
    
    UITouch *touch = [[event allTouches] anyObject];
    
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
