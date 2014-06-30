//
//  ViewController.m
//  flyingV
//
//  Created by Brittny Wright on 6/3/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import "ViewController.h"
#import "Bird.h"

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
    
    animatingBird=[[UIImageView alloc] initWithFrame:CGRectMake(widthOfViewController - 75, 0, _headBird.frame.size.width, _headBird.frame.size.height)];
    animatingBird.image=[UIImage imageNamed:@"dragon.png"];
    [self.view addSubview:animatingBird];
    [self.view sendSubviewToBack:animatingBird];

    
    
    animateTimer=[[NSTimer alloc] init];
  
    gameTimer=[NSTimer scheduledTimerWithTimeInterval:.016 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    
    
    
    count=0;
    leftBirds = [[NSMutableArray alloc]init];
    rightBirds = [[NSMutableArray alloc]init];
    //[birds addObject:_headBird];
    [super viewDidLoad];
    
    birdCount = 1;
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)gameLoop
{
    
  
    [self collisionChecking];
    [self upDateAnimations];
    [self moveBirds: _headBird.center];
    
    count += 1;
}

-(void)collisionChecking
{
    
    if(CGRectIntersectsRect(_headBird.frame, animatingBird.frame)&&birdCaught==NO)
    {
        [self createBirdForV];
        int birdLevel = (int)((leftBirds.count + rightBirds.count) / 5);
        newBirdSizeModifier = 1;
        for(int i = 0; i < birdLevel; i += 1)
        {
            newBirdSizeModifier *= 0.9;
        }
        for(int i = 0; i < leftBirds.count; i += 1)
        {
            Bird * tempBird = [leftBirds objectAtIndex:i];
            UIImageView * tempView = [tempBird getImage];
            [tempView setFrame:CGRectMake(tempView.frame.origin.x, tempView.frame.origin.y, _headBird.frame.size.width * newBirdSizeModifier, _headBird.frame.size.height * newBirdSizeModifier)];
        }
        for(int i = 0; i < rightBirds.count; i += 1)
        {
            
            Bird * tempBird = [rightBirds objectAtIndex:i];
            UIImageView * tempView = [tempBird getImage];
            [tempView setFrame:CGRectMake(tempView.frame.origin.x, tempView.frame.origin.y, _headBird.frame.size.width * newBirdSizeModifier, _headBird.frame.size.height * newBirdSizeModifier)];
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
    
    UIImageView * bird = [[UIImageView alloc] initWithFrame:CGRectMake(widthOfViewController/2, -(_headBird.frame.size.height), _headBird.frame.size.width * newBirdSizeModifier, _headBird.frame.size.height * newBirdSizeModifier)];
    bird.image=[UIImage imageNamed:@"dragon.png"];
    [self.view addSubview:bird];
    [self.view sendSubviewToBack:bird];
   // NSLog([NSString stringWithFormat:@"%f", newBirdSizeModifier]);
    CGPoint newBirdLocation = _headBird.center;
    //NSLog([NSString stringWithFormat:@"Passing:(%f, %f)", temp.center.x, temp.center.y]);
    [self moveBirds:newBirdLocation];
    return bird;
                            
}


-(void)createBirdForV
{
    Bird * newBird = [[Bird alloc]initWithImageAndIndex:@"dragon.png" :CGRectMake(animatingBird.frame.origin.x, animatingBird.frame.origin.y, _headBird.frame.size.width * newBirdSizeModifier, _headBird.frame.size.height * newBirdSizeModifier) :birdCount];
    if(birdCount % 2 == 1)
    {
        [leftBirds addObject:newBird];
    }
    else
    {
        [rightBirds addObject:newBird];
    }
    [self.view addSubview:[newBird getImage]];
    [self.view sendSubviewToBack:[newBird getImage]];
    CGPoint newBirdLocation = _headBird.center;
    [self moveBirds:newBirdLocation];
    birdCount += 1;
}

-(void)moveBirds:(CGPoint)location
{
    _headBird.center = location;
    CGPoint tempLocation = location;
    float moveDistX = 15 * newBirdSizeModifier;
    float moveDistY = 30 * newBirdSizeModifier;
    for(int i = 0; i < leftBirds.count; i += 1)
    {
        tempLocation.x -= moveDistX;
        tempLocation.y += moveDistY;
        Bird * tempBird = [leftBirds objectAtIndex:i];
        UIImageView * tempView = [tempBird getImage];
        float chaseX = (tempView.center.x - tempLocation.x) / 10;
        float chaseY = (tempView.center.y - tempLocation.y) / 10;
        CGPoint newPoint = location;
        newPoint.x = tempView.center.x - chaseX;
        newPoint.y = tempView.center.y - chaseY;
        tempView.center = newPoint;
        tempLocation = tempView.center;
    }
    tempLocation = location;
    for(int i = 0; i < rightBirds.count; i += 1)
    {
        tempLocation.x += moveDistX;
        tempLocation.y += moveDistY;
        Bird * tempBird = [rightBirds objectAtIndex:i];
        UIImageView * tempView = [tempBird getImage];
        float chaseX = (tempView.center.x - tempLocation.x) / 10;
        float chaseY = (tempView.center.y - tempLocation.y) / 10;
        CGPoint newPoint = location;
        newPoint.x = tempView.center.x - chaseX;
        newPoint.y = tempView.center.y - chaseY;
        tempView.center = newPoint;
        tempLocation = tempView.center;

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
