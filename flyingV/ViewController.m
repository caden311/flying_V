//
//  ViewController.m
//  flyingV
//
//  Created by Brittny Wright on 6/3/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import "ViewController.h"
#import "Bird.h"
#import "flyingObject.h"

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
    
    //animating collision objects
    flyingObjectsArray=[[NSMutableArray alloc] init];
    flyingBirdsArray=[[NSMutableArray alloc] init];
    numCollisionAnimations=1;
    
    collisionRand=0;
    birdHit=NO;
    collisionSpeed=3;
    collisionAnimationInProgress=NO;
    animatingObject=[[UIImageView alloc] initWithFrame:CGRectMake(widthOfViewController, 0, 25, 25)];
    animatingObject.image=[UIImage imageNamed:@"ball.png"];
    [self.view addSubview:animatingObject];
    [self.view sendSubviewToBack:animatingObject];
    
    //animation variables
    numBirdAnimations=1;
    animationSpeedModifier=1;
    randAnimation=0;
    animationSpeed=3;
    animationCounter=0;
    animationModifier=5;
    animatingBird=[[UIImageView alloc] init];
    animatingBird=[[UIImageView alloc] initWithFrame:CGRectMake(widthOfViewController - 75, 0, _headBird.frame.size.width, _headBird.frame.size.height)];
    animatingBird.image=[UIImage imageNamed:@"dragon.png"];
    [self.view addSubview:animatingBird];
    [self.view sendSubviewToBack:animatingBird];
   
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
    randDirection=1;
    
    birdCaught=NO;
    birdClose=NO;
    
    passedGravity2Line=NO;
    passedGravityLine4=NO;
    passedgravity3Line=NO;
    


    
    
    animateTimer=[[NSTimer alloc] init];
  
    gameTimer=[NSTimer scheduledTimerWithTimeInterval:.016 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    
    
    
    count=0;
    leftBirds = [[NSMutableArray alloc]init];
    rightBirds = [[NSMutableArray alloc]init];
    //[birds addObject:_headBird];
    [super viewDidLoad];
    
    birdCount = 1;
    highBirdCount=1;
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)gameLoop
{
   
    [self upDateCollisionAnimations];
    [self updateLabels];
    [self collisionChecking];
    [self upDateAnimations];
    [self moveBirds: _headBird.center];
    
    count += 1;
}
-(void)updateLabels
{
    if(birdCount>highBirdCount)
    {
        highBirdCount=birdCount;
    }
    _highScoreLabel.text=[NSString stringWithFormat:@"%i",highBirdCount];
    _currentScore.text=[NSString stringWithFormat:@"%i",birdCount];
}
-(void)collisionChecking
{

    for(int i=0; i<[flyingBirdsArray count]; i++)
    {
        flyingObject * object =[flyingBirdsArray objectAtIndex:i];
        if(CGRectIntersectsRect(_headBird.frame, [object getImage].frame)&&[object getObjectHit]==NO)
        {
            CGPoint point=CGPointMake([object getImage].center.x, [object getImage].center.y);
            [self createBirdForV:point];
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
                [object setObjectHit:YES];
                [object getImage].hidden=YES;
            
            
        
   
        }
    }
    for(int i=0; i<[flyingObjectsArray count]; i++)
     {
         flyingObject * object =[flyingObjectsArray objectAtIndex:i];
         if(CGRectIntersectsRect(_headBird.frame, [object getImage].frame)&&[object getObjectHit]==NO)
         {
             if(birdCount>=4)
            {
                birdCount -= 3;
            }
             else
             {
                 birdCount=1;
             }
             count = 0;
             birdCaught=YES;
             [object getImage].hidden=YES;
             [object setObjectHit:YES];
     }
     
     }


    
}
-(void)upDateCollisionAnimations
{
    int tempNumAnimation=0;
    for(int i=0; i<[flyingObjectsArray count]; i++)
    {
        flyingObject * temp=[flyingObjectsArray objectAtIndex:i];
       if([temp getAnimationInProgress]==YES)
        {
            tempNumAnimation+=1;
        }
        
        
    }
    if(tempNumAnimation<numCollisionAnimations)
    {
        
        [self createCollisionImage];
       
      
        collisionRand=arc4random()%9;
    }
    else
    {
        
       /* if(collisionRand>7)
        {
            [self animateBird1:animatingObject];
        }
        else if(collisionRand>5)
        {
            [self animateBird2:animatingObject];
        }
        else if(collisionRand>4)
        {
            [self animateBird3:animatingObject];
        }
        else if(collisionRand>3)
        {
            [self animateBird4:animatingObject];
        }
        else if(collisionRand>2)
        {
            [self animateBird5:animatingObject];
        }
        */
       for(int j=0; j<[flyingObjectsArray count]; j++)
        {
            flyingObject * object=[flyingObjectsArray objectAtIndex:j];
            
            [self animateBird1:object];
        }
    }
    
    
    
}
-(void)upDateAnimations
{
    int tempNumAnimation=0;
    for(int i=0; i<[flyingBirdsArray count]; i++)
    {
        flyingObject * temp=[flyingBirdsArray objectAtIndex:i];
        if([temp getAnimationInProgress]==YES)
        {
            tempNumAnimation+=1;
        }
        
    }
    if(tempNumAnimation<numBirdAnimations)
    {
        passedGravity2Line=NO;
        
        birdClose=NO;
        
        accel2=0;
        accel3=0;
        
        accel4=0;
        gravity4= .05;
        
       
       [self createBirdImage];
       
       
        
        randDirection=(arc4random() % 2 ? 1 : -1);
        
        
        randY=arc4random()%7+1;
        randX=(1+arc4random()%5)*randDirection;
        
        /*if(randX>=0)
        {
            animatingBird.frame=CGRectMake(0, -(animatingBird.frame.size.height), animatingBird.frame.size.width, animatingBird.frame.size.height);
        }
        else
        {
            animatingBird.frame=CGRectMake(lengthOfViewController, -(animatingBird.frame.size.height), animatingBird.frame.size.width, animatingBird.frame.size.height);
        }
        */
        
        //animate away
       // animatingBird.frame=CGRectMake(widthOfViewController/2, 0, animatingBird.frame.size.width, animatingBird.frame.size.height);
        
        
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
    
   
        for(int i=0; i<[flyingBirdsArray count]; i++)
        {
        
            flyingObject * object=[flyingBirdsArray objectAtIndex:i];
            if([object getAnimationInProgress]==YES)
            {
                [self animatebirdAway:object];
            }
                //[self animateBird1];
    
        }
    
}
-(void)endingAnimation:(flyingObject*) object
{
    
    
    if([object getImage].frame.origin.y>lengthOfViewController)
    {
        
        if([object isBird]==YES)
        {            [object getImage].hidden=YES;
            [object setObjectHit:NO];
            [flyingBirdsArray removeObjectAtIndex:[object getIndex]];
            passedGravityLine4=NO;
          
        }
        if([object isBird]==NO)
        {
             [flyingObjectsArray removeObjectAtIndex:[object getIndex]];
            [object getImage].hidden=YES;
            [object setObjectHit:NO];
        }
    }

}
-(void)animateBird1:(flyingObject*) object
{
    
    if(animationCounter%50==0)
    {
        animationModifier*=-1;
    }
    [object getImage].frame=CGRectMake([object getImage].frame.origin.x+animationModifier, [object getImage].frame.origin.y+[object getSpeed], [object getImage].frame.size.width, [object getImage].frame.size.height);
   
    [self endingAnimation:object];
    
  
    animationCounter++;
}
-(void)animateBird2:(flyingObject*) object
{
    
    if([object getImage].center.x<gravity2Line)
    {
        if(passedGravity2Line==NO)
        {
            gravity2*=-1;
            passedGravity2Line=YES;
        }
    }
    else if([object getImage].center.x>gravity2Line)
    {
        if(passedGravity2Line==YES)
        {
            gravity2*=-1;
            passedGravity2Line=NO;
        }
    }
    //NSLog([NSString stringWithFormat:@"Y value %f",animatingBird.frame.origin.y]);
    //NSLog([NSString stringWithFormat:@"X value %f",animatingBird.frame.origin.x]);
    [object getImage].frame=CGRectMake([object getImage].frame.origin.x+accel2, [object getImage].frame.origin.y+animationSpeed, [object getImage].frame.size.width, [object getImage].frame.size.height);
    
    accel2=accel2+gravity2;
    //NSLog([NSString stringWithFormat:@"%f", accel]);
    
  [self endingAnimation:object];
}

-(void)animateBird3:(flyingObject*) object
{
    if([object getImage].center.y>gravity3Line)
    {
        if(passedgravity3Line==NO)
        {
          
            gravity3*=-1;
            passedgravity3Line=YES;
        }
    }
    else if([object getImage].center.y<gravity3Line)
    {
        if(passedgravity3Line==YES)
        {
          
            gravity3*=-1;
            passedgravity3Line=NO;
        }
    }
  

    [object getImage].frame=CGRectMake([object getImage].frame.origin.x-animationSpeed, [object getImage].frame.origin.y+accel3, [object getImage].frame.size.width, [object getImage].frame.size.height);
    
    
    accel3=accel3+gravity3;
 
    
 [self endingAnimation:object];
}

-(void)animateBird4:(flyingObject*) object
{
    
    if(passedGravityLine4==NO)
    {
        if([object getImage].center.y>gravity4Line)
        {
        
           // object.center=CGPointMake(gravity4Line, object.center.y);
            gravity4*=-1;
            accel4*=-1;
            passedGravityLine4=YES;
        
        }
    }
    
     [object getImage].frame=CGRectMake([object getImage].frame.origin.x-accel4, [object getImage].frame.origin.y+animationSpeed, [object getImage].frame.size.width, [object getImage].frame.size.height);
 
    accel4=accel4+gravity4;
    
  [self endingAnimation:object];
    
}
-(void)animateBird5:(flyingObject*) object
{
    [object getImage].frame=CGRectMake([object getImage].frame.origin.x+randX, [object getImage].frame.origin.y+randY, [object getImage].frame.size.width, [object getImage].frame.size.height);
    
[self endingAnimation:object];
}

-(void)animatebirdAway:(flyingObject *)object
{
    UIImageView * bird= [object getImage];
    
    float distance=sqrt(pow((_headBird.frame.origin.x-bird.frame.origin.x),2.0)+pow((_headBird.frame.origin.y-bird.frame.origin.y),2.0));
    
   // NSLog([NSString stringWithFormat:@"distance: %f",distance ]);
    
   
    
    if(distance<100)
    {
        birdClose=YES;
        [object setSpeed:5];
        
    }
    else if(distance<50)
    {
        [object setSpeed:10];
    }
    else if(distance<10)
    {
        [object setSpeed:20];
    }
    
    
    
    if(birdClose==NO)
    {
        bird.frame=CGRectMake(bird.frame.origin.x, bird.frame.origin.y+[object getSpeed], bird.frame.size.width, bird.frame.size.height);
    }
    else if(randDirection<1)
    {
       bird.frame=CGRectMake(bird.frame.origin.x-([object getSpeed]), bird.frame.origin.y-([object getSpeed]), bird.frame.size.width, bird.frame.size.height);
    }
    else
    {
        bird.frame=CGRectMake(bird.frame.origin.x+([object getSpeed]), bird.frame.origin.y-([object getSpeed]), bird.frame.size.width, bird.frame.size.height);
    }
    
    if(distance>lengthOfViewController)
    {
        [object setAnimationInProgress:NO];
        [object getImage].hidden=YES;
       
        bird.hidden=YES;
        birdCaught=NO;
        if([object isBird]==YES)
        {
            [flyingBirdsArray removeObjectAtIndex:[object getIndex]];
        }
    }
    
}


-(void)createBirdImage
{
    flyingObject *object=[[flyingObject alloc] initWithImageAndIndex:@"dragon.png" :CGRectMake(widthOfViewController/2, -(_headBird.frame.size.height), _headBird.frame.size.width, _headBird.frame.size.height) :[flyingBirdsArray count] :3];
    [object setIsBird:YES];
   
    [flyingBirdsArray addObject:object];
    
    
    [self.view addSubview:[object getImage]];
    [self.view sendSubviewToBack:[object getImage]];
   // NSLog([NSString stringWithFormat:@"%f", newBirdSizeModifier]);
   // CGPoint newBirdLocation = _headBird.center;
    //NSLog([NSString stringWithFormat:@"Passing:(%f, %f)", temp.center.x, temp.center.y]);
  //  [self moveBirds:newBirdLocation];
  
                            
}

-(void)createCollisionImage
{
    
    flyingObject *object=[[flyingObject alloc] initWithImageAndIndex:@"ball.png" :CGRectMake(widthOfViewController/2, -25, 25, 25) :[flyingObjectsArray count] :3];
    [object setIsBird:NO];
    [flyingObjectsArray addObject:object];
    [self.view addSubview:[object getImage]];
    [self.view sendSubviewToBack:[object getImage]];
   
   
    
}


-(void)createBirdForV:(CGPoint) animatingBird
{
    birdCount += 1;
    Bird * newBird = [[Bird alloc]initWithImageAndIndex:@"dragon.png" :CGRectMake(animatingBird.x, animatingBird.y, _headBird.frame.size.width * newBirdSizeModifier, _headBird.frame.size.height * newBirdSizeModifier) :birdCount];
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
}

-(void)moveBirds:(CGPoint)location
{
    _headBird.center = location;
    CGPoint tempLocation = location;
    float moveDistX = 15 * newBirdSizeModifier;
    float moveDistY = 30 * newBirdSizeModifier;
    for(int i = 0; i < leftBirds.count; i += 1)
    {
        Bird * tempBird = [leftBirds objectAtIndex:i];
        UIImageView * tempView = [tempBird getImage];
        CGPoint newPoint = location;
        if([tempBird isDying] == NO)
        {
            if([tempBird getIndex] <= birdCount)
            {
                tempLocation.x -= moveDistX;
                tempLocation.y += moveDistY;
                float chaseX = (tempView.center.x - tempLocation.x) / 10;
                float chaseY = (tempView.center.y - tempLocation.y) / 10;
                newPoint.x = tempView.center.x - chaseX;
                newPoint.y = tempView.center.y - chaseY;
                tempView.center = newPoint;
                tempLocation = tempView.center;
            }
            else
            {
                [tempBird setDying:YES];
            }
        }
        else
        {
            newPoint.x = tempView.center.x;
            newPoint.y = tempView.center.y + 3;
            tempView.center = newPoint;
            if(tempView.frame.origin.y > lengthOfViewController)
            {
                tempView.hidden = YES;
                [leftBirds removeObjectAtIndex:i];
                i -= 1;
            }
        }
    }
    tempLocation = location;
    for(int i = 0; i < rightBirds.count; i += 1)
    {
        Bird * tempBird = [rightBirds objectAtIndex:i];
        UIImageView * tempView = [tempBird getImage];
        CGPoint newPoint = location;
        if([tempBird isDying] == NO)
        {
            if([tempBird getIndex] <= birdCount)
            {
                tempLocation.x += moveDistX;
                tempLocation.y += moveDistY;
                float chaseX = (tempView.center.x - tempLocation.x) / 10;
                float chaseY = (tempView.center.y - tempLocation.y) / 10;
                newPoint.x = tempView.center.x - chaseX;
                newPoint.y = tempView.center.y - chaseY;
                tempView.center = newPoint;
                tempLocation = tempView.center;
            }
            else
            {
                [tempBird setDying:YES];
            }
        }
        else
        {
            newPoint.x = tempView.center.x;
            newPoint.y = tempView.center.y + 3;
            tempView.center = newPoint;
            if(tempView.frame.origin.y > lengthOfViewController)
            {
                tempView.hidden = YES;
                [rightBirds removeObjectAtIndex:i];
                i -= 1;
            }

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
