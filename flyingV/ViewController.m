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
  

    //animation variables
    numBirdAnimations=1;
   
    
   
   
    
    verticalGravityLine=widthOfViewController/2;
    horizontalGravityLine = lengthOfViewController / 2;
    
    
   
   
    
    
    birdClose=NO;
    
   


    
    
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
             if(birdCount>=[object getLivesWorth]+1)
            {
                birdCount -= [object getLivesWorth];
            }
             else
             {
                 birdCount=1;
             }
             count = 0;
           
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
       
      
    }
    else
    {
        
    
    
       for(int j=0; j<[flyingObjectsArray count]; j++)
        {
            flyingObject * object=[flyingObjectsArray objectAtIndex:j];
            
            if([object getAnimationNumber]>4)
            {
                [self animateBird5:object];
            }
            else if([object getAnimationNumber]>3)
            {
                [self animateBird4:object];
            }
            else if([object getAnimationNumber]>2)
            {
                [self animateBird3:object];
            }
            else if([object getAnimationNumber]>1)
            {
                [self animateBird2:object];
            }
            else if([object getAnimationNumber]>0)
            {
                [self animateBird1:object];
            }
           
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
      
        
        birdClose=NO;
        
      
        
       
       [self createBirdImage];
       
       

        
     
     
        
    }
    
   
        for(int i=0; i<[flyingBirdsArray count]; i++)
        {
        
            flyingObject * object=[flyingBirdsArray objectAtIndex:i];
            if([object getAnimationInProgress]==YES)
            {
                [self animatebirdAway6:object];
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
            [object setPassedGravityLine:NO];
            [flyingBirdsArray removeObjectAtIndex:[object getIndex]];
            
          
        }
        if([object isBird]==NO)
        {
            [object getImage].hidden=YES;
            [object setObjectHit:NO];
            [object setPassedGravityLine:NO];
            [flyingObjectsArray removeObjectAtIndex:[object getIndex]];
           
        }
    }

}
-(void)animateBird1:(flyingObject*) object
{
    
    if(count%50==0)
    {
        [object setAccel:[object getAccel]*(-1)];
    }
    [object getImage].frame=CGRectMake([object getImage].frame.origin.x+[object getAccel], [object getImage].frame.origin.y+[object getSpeed], [object getImage].frame.size.width, [object getImage].frame.size.height);
   
    [self endingAnimation:object];
    
  
    
    
}
-(void)animateBird2:(flyingObject*) object
{
    
    if([object getImage].center.x<verticalGravityLine)
    {
        if([object getPassedGravityLine]==NO)
        {
            float currGrav=[object getGravity];
            [object setGravity:currGrav*(-1)];
            [object setPassedGravityLine:YES];
        }
    }
    else if([object getImage].center.x>verticalGravityLine)
    {
        if([object getPassedGravityLine]==YES)
        {
            float currGrav=[object getGravity];
            [object setGravity:currGrav*(-1)];
            [object setPassedGravityLine:NO];
        }
    }
    //NSLog([NSString stringWithFormat:@"Y value %f",animatingBird.frame.origin.y]);
    //NSLog([NSString stringWithFormat:@"X value %f",animatingBird.frame.origin.x]);
    [object getImage].frame=CGRectMake([object getImage].frame.origin.x+[object getAccel], [object getImage].frame.origin.y+[object getSpeed], [object getImage].frame.size.width, [object getImage].frame.size.height);
    
    [object setAccel:([object getAccel]+[object getGravity])];
    //NSLog([NSString stringWithFormat:@"%f", accel]);
    
  [self endingAnimation:object];
}

-(void)animateBird3:(flyingObject*) object
{
    if([object getImage].center.y>horizontalGravityLine)
    {
        if([object getPassedGravityLine]==NO)
        {
          
            float currGrav=[object getGravity];
            [object setGravity:currGrav*(-1)];
            [object setPassedGravityLine:YES];
        }
    }
    else if([object getImage].center.y<horizontalGravityLine)
    {
        if([object getPassedGravityLine]==YES)
        {
          
            float currGrav=[object getGravity];
            [object setGravity:currGrav*(-1)];
            [object setPassedGravityLine:NO];
        }
    }
  

    [object getImage].frame=CGRectMake([object getImage].frame.origin.x-[object getSpeed], [object getImage].frame.origin.y+[object getAccel], [object getImage].frame.size.width, [object getImage].frame.size.height);
    
    
   [object setAccel:([object getAccel]+[object getGravity])];
 
    
    if([object getImage].frame.origin.x<(-widthOfViewController))
    {
        
        if([object isBird]==YES)
        {            [object getImage].hidden=YES;
            [object setObjectHit:NO];
            [object setPassedGravityLine:NO];
            [flyingBirdsArray removeObjectAtIndex:[object getIndex]];
            
            
        }
        if([object isBird]==NO)
        {
            [object getImage].hidden=YES;
            [object setObjectHit:NO];
            [object setPassedGravityLine:NO];
            [flyingObjectsArray removeObjectAtIndex:[object getIndex]];
            
        }
    }
}

-(void)animateBird4:(flyingObject*) object
{
    
    if([object getPassedGravityLine]==NO)
    {
        if([object getImage].center.y>horizontalGravityLine)
        {
        
           // object.center=CGPointMake(horizontalGravityLine, object.center.y);
            float currGrav=[object getGravity];
            [object setGravity:currGrav*(-1)];
            float currAccel=[object getAccel];
            [object setAccel:currAccel*(-1)];
            [object setPassedGravityLine:YES];
        
        }
    }
    
     [object getImage].frame=CGRectMake([object getImage].frame.origin.x-[object getAccel], [object getImage].frame.origin.y+[object getSpeed], [object getImage].frame.size.width, [object getImage].frame.size.height);
 
    [object setAccel:([object getAccel]+[object getGravity])];

  [self endingAnimation:object];
    
}
-(void)animateBird5:(flyingObject*) object
{
    [object getImage].frame=CGRectMake([object getImage].frame.origin.x+[object getRandX], [object getImage].frame.origin.y+[object getRandY], [object getImage].frame.size.width, [object getImage].frame.size.height);
    
[self endingAnimation:object];
}

-(void)animatebirdAway6:(flyingObject *)object
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
    else if([object getRandDirection]<1)
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
   
        
        if([object isBird]==YES)
        {
            [flyingBirdsArray removeObjectAtIndex:[object getIndex]];
        }
    }
    
}


-(void)createBirdImage
{
  
    flyingObject *object=[[flyingObject alloc] initWithImageAndIndex:@"dragon.png" :CGRectMake(widthOfViewController/2, -(_headBird.frame.size.height), _headBird.frame.size.width, _headBird.frame.size.height) :[flyingBirdsArray count] :3];
    [object setRandDirection:(arc4random() % 2 ? 1 : -1)];
    [object setIsBird:YES];
    //[object setAnimationNumber:rand];
   
    [flyingBirdsArray addObject:object];
    
    
    [self.view addSubview:[object getImage]];
    [self.view sendSubviewToBack:[object getImage]];
   
    
    

    
    //animate away
    // animatingBird.frame=CGRectMake(widthOfViewController/2, 0, animatingBird.frame.size.width, animatingBird.frame.size.height);
    
  
  
    
}

-(void)createCollisionImage
{
    int rand=(arc4random()%5)+1;
    
    flyingObject *object=[[flyingObject alloc] initWithImageAndIndex:@"ball.png" :CGRectMake(widthOfViewController/2, -25, 25, 25) :[flyingObjectsArray count] :3];
    [object setLivesWorth:3];
    [object setIsBird:NO];
    [object setAnimationNumber:rand];

    [object setRandDirection:(arc4random() % 2 ? 1 : -1)];
    [object setRandY:arc4random()%7+4];
    [object setRandX:(3+arc4random()%5)*[object getRandDirection]];
    if([object getAnimationNumber]>4)
    {
        if([object getRandX]>=0)
        {
            [object getImage].frame=CGRectMake(0, -([object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height);
        }
        else
        {
            [object getImage].frame=CGRectMake(lengthOfViewController, -([object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height);
        }
    }
    else if([object getAnimationNumber]>3)
    {
 //       [object setGravity:.002];
        [object setGravity:.05];
      [object getImage].frame=CGRectMake(widthOfViewController-[object getImage].frame.size.width, 0, [object getImage].frame.size.width, [object getImage].frame.size.height);
    }
    else if([object getAnimationNumber]>2)
    {
        [object setGravity:.75];
       [object getImage].frame=CGRectMake(widthOfViewController, [object getImage].frame.size.height*3, [object getImage].frame.size.width, [object getImage].frame.size.height);
    }
    else if([object getAnimationNumber]>1)
    {
        [object setGravity:.75];
        [object getImage].frame=CGRectMake(widthOfViewController, 0, [object getImage].frame.size.width, [object getImage].frame.size.height);
    }
    else if([object getAnimationNumber]>0)
    {
        [object setAccel:5];
       [object getImage].frame=CGRectMake(widthOfViewController/2, 0, [object getImage].frame.size.width, [object getImage].frame.size.height);
    }
    

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
