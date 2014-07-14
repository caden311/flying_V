//
//  ViewController.m
//  flyingV
//
//  Created by Brittny Wright on 6/3/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import "StartPageController.h"
#import "ViewController.h"
#import "Bird.h"
#import "flyingObject.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize db=_db;

- (void)viewDidLoad
{
    Date = [NSDate date];
    
    lengthOfViewController=self.view.frame.size.height;
    widthOfViewController=self.view.frame.size.width;
    
    gameTimer=[[NSTimer alloc] init];
    sizeModifier = 0.9;
    newBirdSizeModifier = 1.0;
    
    //animating collision objects
    flyingObjectsArray=[[NSMutableArray alloc] init];
    flyingBirdsArray=[[NSMutableArray alloc] init];
    numCollisionAnimations=1;
    
    //level Variables
    levelIncrease=0;
    numBirdAnimations=2;
    timeToCompleteAnimationDuck=2.0f;
    distanceBeforeBirdRuns=100;
    blindSpotsEnabled=NO;
    timeToCompleteAnimation=2.0;
    speedAwayBirdRuns=5;
    startAwayBirds=NO;
    stopDumbBirds=NO;
  
   
    verticalGravityLine=widthOfViewController/2;
    horizontalGravityLine = lengthOfViewController / 2;

    
    animateTimer=[[NSTimer alloc] init];
  
    gameTimer=[NSTimer scheduledTimerWithTimeInterval:.016 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    
    
    
    count=0;
    leftBirds = [[NSMutableArray alloc]init];
    rightBirds = [[NSMutableArray alloc]init];
    //[birds addObject:_headBird];
  
    
    birdCount = 1;
    highBirdCount=1;
    _headBird.hidden=NO;
    
    //Set up background images
    
    
    
    background1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, widthOfViewController, lengthOfViewController)];
    background1.image = [UIImage imageNamed:@"BG1.png"];
    
    [self.view addSubview:background1];
    [self.view sendSubviewToBack:background1];
    
    background2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, -1 * lengthOfViewController, widthOfViewController, lengthOfViewController)];
    background2.image = [UIImage imageNamed:@"BG1.png"];
    
    [self.view addSubview:background2];
    [self.view sendSubviewToBack:background2];
    
    bgInTransition = NO;
    bgImageCount = 2;
    bgImageIndex = 0;
    
    bgImageArray = [[NSMutableArray alloc]initWithObjects:@"BG1.png", @"1-2.png", @"BG2.png", @"2-3.png", @"BG3.png", @"3-4.png", @"BG4.png", @"4-5.png", @"BG5.png", nil];
    
    levelDuration = 3;
	// Do any additional setup after loading the view, typically from a nib.
    
    
    [self loadPlist];
    [super viewDidLoad];
}

-(void)gameLoop
{
    [self updateTime:gameTimer];
    [self upDateCollisionAnimations];
    [self updateLabels];
    [self collisionChecking];
    [self upDateAnimations];
    [self moveBirds: _headBird.center];
    [self updateBackground];
    
    count += 1;
}
- (void)updateTime:(NSTimer *)timer
{
    NSInteger secondsSinceStart = (NSInteger)[[NSDate date] timeIntervalSinceDate:Date];
    
    NSInteger seconds = secondsSinceStart % 60;
    NSInteger minutes = (secondsSinceStart / 60) % 60;
    NSInteger hours = secondsSinceStart / (60 * 60);
    NSString *result = nil;
    if (hours > 0) {
        result = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }
    else {
        result = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    }
    _currentTime.text=result;
}

-(void)updateBackground
{
    [background1 setFrame:CGRectMake(0, background1.frame.origin.y + 1, widthOfViewController, lengthOfViewController)];
    [background2 setFrame:CGRectMake(0, background2.frame.origin.y + 1, widthOfViewController, lengthOfViewController)];
    if(background1.frame.origin.y >= lengthOfViewController)
    {
        [background1 setFrame:CGRectMake(0, -1 * lengthOfViewController, widthOfViewController, lengthOfViewController)];
        if(bgImageIndex < bgImageArray.count - 1)
        {
            bgImageCount += 1;
            if(bgInTransition)
            {
                bgImageIndex += 1;
                bgInTransition = NO;
            }
            if(bgImageCount % levelDuration == 0)
            {
                bgImageIndex += 1;
                bgInTransition = YES;
            }
            else if((bgImageCount - (levelDuration + 1)) % levelDuration == 0)
            {
                //HERE IS WHERE THE LEVEL GOES UP
                levelIncrease++;
                [self levelIncrease];
                
            }
        }
        background1.image = [UIImage imageNamed:[bgImageArray objectAtIndex:bgImageIndex]];
    }
    if(background2.frame.origin.y >= lengthOfViewController)
    {
        [background2 setFrame:CGRectMake(0, -1 * lengthOfViewController, widthOfViewController, lengthOfViewController)];
        if(bgImageIndex < bgImageArray.count - 1)
        {
            bgImageCount += 1;
            if(bgInTransition)
            {
                bgImageIndex += 1;
                bgInTransition = NO;
            }
            if(bgImageCount % levelDuration == 0)
            {
                bgImageIndex += 1;
                bgInTransition = YES;
            }
            else if((bgImageCount - (levelDuration + 1)) % levelDuration == 0)
            {
                //HERE IS WHERE THE LEVEL GOES UP
                levelIncrease++;
                [self levelIncrease];
                
            }
        }
        background2.image = [UIImage imageNamed:[bgImageArray objectAtIndex:bgImageIndex]];
    }
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
        CALayer *layer = [object getImage].layer.presentationLayer;
        CGRect layerFrame = layer.frame;
        if(CGRectIntersectsRect(_headBird.frame, layerFrame)&&[object getObjectHit]==NO)
        {
            CGPoint point=CGPointMake(layerFrame.origin.x, layerFrame.origin.y);
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
         CALayer *layer = [object getImage].layer.presentationLayer;
         CGRect layerFrame = layer.frame;
        
         if(CGRectIntersectsRect(_headBird.frame, layerFrame)&&[object getObjectHit]==NO)
         {
             if(birdCount>=[object getLivesWorth]+1)
            {
                birdCount -= [object getLivesWorth];
            }
             else
             {
                 birdCount=1;
                 [self showScore];
                 [gameTimer invalidate];
                     [self dismissViewControllerAnimated:NO completion:nil];
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
        if(startAwayBirds==YES)
        {
            if(stopDumbBirds==NO)
            {
                int rand=arc4random()%2;
                if(rand>0)
                {
                    [self createBirdImage];
                }
                else
                {
                    [self createDumbBirdImage];
                }
        
            }
            else
            {
                 [self createBirdImage];
                
            }
            
            
            
        }
        else
        {
            [self createDumbBirdImage];
        }
    }
    
   
        for(int i=0; i<[flyingBirdsArray count]; i++)
        {
        
            flyingObject * object=[flyingBirdsArray objectAtIndex:i];
            if([object getAnimationInProgress]==YES)
            {
                if([object getAnimationNumber]==0)
                {
                    [self animatebirdAway:object];
            
                }
                //[self animateBird1];
            }
        }
    
}

-(void)levelIncrease
{
    
    if(levelIncrease<2)
    {
        
        numCollisionAnimations=2;
        
        distanceBeforeBirdRuns=100;
      
       
        
    }
    else if(levelIncrease<3)
    {
        numBirdAnimations=1;
        startAwayBirds=YES;
     
        speedAwayBirdRuns=3;
    }
    else if(levelIncrease<4)
    {
        speedAwayBirdRuns=5;
        blindSpotsEnabled=YES;
         stopDumbBirds=YES;
        timeToCompleteAnimationDuck=1.75f;
           numCollisionAnimations=3;
    }
    else if(levelIncrease<5)
    {
    
        speedAwayBirdRuns=6;
        numCollisionAnimations=4;
       
         timeToCompleteAnimation=1.5f;
    }

    
}
-(void)animateObject:(flyingObject*)object
{
     UIImageView * toImg=[object getToImage];
    
    [UIView animateWithDuration:timeToCompleteAnimation
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [object getImage].frame = toImg.frame;
                         
                     }
                     completion:^(BOOL finished){
                      if(finished)
                      {
                          [object setAnimationInProgress:NO];
                          int currIndex=[object getIndex];
                          [flyingObjectsArray removeObjectAtIndex:[object getIndex]];
                          for(int i=0; i<[flyingObjectsArray count]; i++)
                          {
                              flyingObject *temp=[flyingObjectsArray objectAtIndex:i];
                              if([temp getIndex]>currIndex)
                              {
                                  [temp setIndex:([temp getIndex]-1)];
                              }
                          }
                      }
                    
                     }];
   

    
}

-(void)animateDumbDuck:(flyingObject*)object
{
    UIImageView * toImg=[object getToImage];
    
    [UIView animateWithDuration:timeToCompleteAnimationDuck
                          delay:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [object getImage].frame = toImg.frame;
                        
                     }
                     completion:^(BOOL finished){
                         if(finished)
                         {
                             [object setAnimationInProgress:NO];
                             int currIndex=[object getIndex];
                             [flyingBirdsArray removeObjectAtIndex:[object getIndex]];
                             for(int i=0; i<[flyingBirdsArray count]; i++)
                             {
                                 flyingObject *temp=[flyingBirdsArray objectAtIndex:i];
                                 if([temp getIndex]>currIndex)
                                 {
                                     [temp setIndex:([temp getIndex]-1)];
                                 }
                             }
                         }
                         
                     }];
 
}




-(void)animatebirdAway:(flyingObject *)object
{
    UIImageView * bird= [object getImage];
    
    float distance=sqrt(pow((_headBird.frame.origin.x-bird.frame.origin.x),2.0)+pow((_headBird.frame.origin.y-bird.frame.origin.y),2.0));
    
    // NSLog([NSString stringWithFormat:@"distance: %f",distance ]);
    
    
    
    if(distance<distanceBeforeBirdRuns)
    {
        [object setObjectCloseToHeadBird:YES];
     
        
     
            [object setSpeed:speedAwayBirdRuns];
        
    }
    else if(distance<distanceBeforeBirdRuns-50)
    {
       
        
    
            [object setSpeed:speedAwayBirdRuns+5];
        
    }
    else if(distance<10)
    {
       
        
      
            [object setSpeed:speedAwayBirdRuns+speedAwayBirdRuns];
        
    }
    
    
    
    if([object getObjectCloseToHeadBird]==NO)
    {
        bird.frame=CGRectMake(bird.frame.origin.x+([object getRandX]), bird.frame.origin.y+([object getSpeed]*[object getRandDirection]), bird.frame.size.width, bird.frame.size.height);
    }//go up and left
    else if([object getImage].frame.origin.x<_headBird.frame.origin.x&&[object getImage].frame.origin.y<_headBird.frame.origin.y)
    {
        bird.frame=CGRectMake(bird.frame.origin.x-([object getSpeed]), bird.frame.origin.y-([object getSpeed]), bird.frame.size.width, bird.frame.size.height);
    }// go up and right
    else if([object getImage].frame.origin.x>_headBird.frame.origin.x&&[object getImage].frame.origin.y<_headBird.frame.origin.y)
    {
        bird.frame=CGRectMake(bird.frame.origin.x+([object getSpeed]), bird.frame.origin.y-([object getSpeed]), bird.frame.size.width, bird.frame.size.height);
    }//go down and left
    else if([object getImage].frame.origin.x<_headBird.frame.origin.x&&[object getImage].frame.origin.y>_headBird.frame.origin.y)
    {
          bird.frame=CGRectMake(bird.frame.origin.x-([object getSpeed]), bird.frame.origin.y+([object getSpeed]), bird.frame.size.width, bird.frame.size.height);
    }//go down and right;
    else if([object getImage].frame.origin.x>_headBird.frame.origin.x&&[object getImage].frame.origin.y>_headBird.frame.origin.y)
    {
        bird.frame=CGRectMake(bird.frame.origin.x+([object getSpeed]), bird.frame.origin.y+([object getSpeed]), bird.frame.size.width, bird.frame.size.height);
    }//go up and left if nothing else....
    else
    {
         bird.frame=CGRectMake(bird.frame.origin.x-([object getSpeed]), bird.frame.origin.y-([object getSpeed]), bird.frame.size.width, bird.frame.size.height);
    }
    
    if([object getObjectHit]==YES)
    {
        [object setAnimationInProgress:NO];
        [object getImage].hidden=YES;

        if([object isBird]==YES)
        {
            [flyingBirdsArray removeObjectAtIndex:[object getIndex]];
        }
    }
    else if(distance>lengthOfViewController+(widthOfViewController/2))
    {
        [object setAnimationInProgress:NO];
        [object getImage].hidden=YES;
        
    
        
        
        if([object isBird]==YES)
        {
            int currIndex=[object getIndex];
            [flyingBirdsArray removeObjectAtIndex:[object getIndex]];
            for(int i=0; i<[flyingBirdsArray count]; i++)
            {
                flyingObject *temp=[flyingBirdsArray objectAtIndex:i];
                if([temp getIndex]>currIndex)
                {
                    [temp setIndex:([temp getIndex]-1)];
                }
            }
        }
    }
    
}
-(void)createDumbBirdImage
{
    NSString * ImageName=@"dragon.png";
    flyingObject *object=[[flyingObject alloc] init];
  object=([[flyingObject alloc] initWithImageAndIndex:@"dragon.png" :CGRectMake(widthOfViewController/2,-[object getImage].frame.size.height , _headBird.frame.size.width, _headBird.frame.size.height) :[flyingBirdsArray count] :3]);
    int rand=(arc4random() % 4);
    
    
   
    [object setIsBird:YES];
    [object setAnimationNumber:1];
    [object setRandDirection:(arc4random() % 2 ? 1 : -1)];
    [object setRandY:arc4random()%(lengthOfViewController/2)];
    [object setRandX:arc4random()%((widthOfViewController)/2)];
    
    if(rand>=3)
    {
   
        //start image at the top and positive
        if([object getRandDirection]>=0)
        {
            [object getImage].frame=CGRectMake(((widthOfViewController/2)+[object getRandX]), -([object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height);
            [object setToImage:CGRectMake(((widthOfViewController/2)-[object getRandX]), (lengthOfViewController+[object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
        }//start image at top negative
        else
        {
            [object getImage].frame=CGRectMake(((widthOfViewController/2)-[object getRandX]), -([object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height);
            [object setToImage:CGRectMake(((widthOfViewController/2)+[object getRandX]), (lengthOfViewController+[object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
        }
        
    }
    else if(rand >=2)
    {
        
            //start image at bottom negative X
            if([object getRandDirection]>=0)
            {
                [object getImage].frame=CGRectMake(((widthOfViewController/2)-[object getRandX]), (lengthOfViewController+[object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height);
                [object setToImage:CGRectMake(((widthOfViewController/2)+[object getRandX]), -([object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
            }//start image at bottom positive X;
            else
            {
                [object getImage].frame=CGRectMake(((widthOfViewController/2)+[object getRandX]), (lengthOfViewController+[object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height);
                [object setToImage:CGRectMake(((widthOfViewController/2)-[object getRandX]), -([object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
            }
        
     
    }
    else if(rand>=1)
    {
        //start image on the right and positive
        if([object getRandDirection]>=0)
        {
         
                
                [object getImage].frame=CGRectMake(((widthOfViewController)+[object getImage].frame.size.width), ((lengthOfViewController/2)+[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height);
                [object setToImage:CGRectMake(-([object getImage].frame.size.width), ((lengthOfViewController/2)-[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
            
        }//start image on the right negative
        else
        {
            [object getImage].frame=CGRectMake(((widthOfViewController)+[object getImage].frame.size.width), ((lengthOfViewController/2)-[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height);
            [object setToImage:CGRectMake(-([object getImage].frame.size.width), ((lengthOfViewController/2)+[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
            
            
        }
    }
    else if(rand>=0)
    {
        //start image on the left and negative
        if([object getRandDirection]>=0)
        {
            
            [object getImage].frame=CGRectMake(-([object getImage].frame.size.width), ((lengthOfViewController/2)-[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height);
            [object setToImage:CGRectMake((widthOfViewController+[object getImage].frame.size.width), ((lengthOfViewController/2)+[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
        }//start image on the left and positive
        else
        {
          
                [object getImage].frame=CGRectMake(-([object getImage].frame.size.width), ((lengthOfViewController/2)+[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height);
                [object setToImage:CGRectMake((widthOfViewController+[object getImage].frame.size.width), ((lengthOfViewController/2)-[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
            
            
        }
    }
    
    [flyingBirdsArray addObject:object];
    [self.view addSubview:[object getImage]];
    //[self.view sendSubviewToBack:[object getImage]];
    [self animateDumbDuck:object];
}
-(void)createBirdImage
{
    
    int randX=arc4random()%(widthOfViewController/2);
    int randHeight=0;
    int randDirection=(arc4random() % 2 ? 1 : -1);
    float speed=4;
    flyingObject *object=[[flyingObject alloc]init];
    [object setAnimationNumber:0];
    //places image on top
    if(randDirection>=0)
    {
         randHeight=-(_headBird.frame.size.height);
        if(randDirection>=0)
        {
       
          object=[[flyingObject alloc] initWithImageAndIndex:@"dragon.png" :CGRectMake((widthOfViewController/2)+randX, randHeight, _headBird.frame.size.width, _headBird.frame.size.height) :[flyingBirdsArray count] :3];
        }
        else
        {
            object=[[flyingObject alloc] initWithImageAndIndex:@"dragon.png" :CGRectMake((widthOfViewController/2)-randX, randHeight, _headBird.frame.size.width, _headBird.frame.size.height) :[flyingBirdsArray count] :3];
        }
    
    }//places image on bottom
    else
    {
            randHeight=lengthOfViewController+_headBird.frame.size.height;
        if(randDirection>=0)
        {
    
         object=[[flyingObject alloc] initWithImageAndIndex:@"dragon.png" :CGRectMake((widthOfViewController/2)-randX, randHeight, _headBird.frame.size.width, _headBird.frame.size.height) :[flyingBirdsArray count] :3];
        }
        else
        {
        object=[[flyingObject alloc] initWithImageAndIndex:@"dragon.png" :CGRectMake((widthOfViewController/2)+randX, randHeight, _headBird.frame.size.width, _headBird.frame.size.height) :[flyingBirdsArray count] :3];
        }
       
    }
   
    [object setSpeed:speed];
    [object setRandX:(arc4random()%1+1)*(arc4random() % 2 ? 1 : -1)];
    [object setRandDirection:randDirection];
    [object setIsBird:YES];
    //[object setAnimationNumber:rand];
   
    [flyingBirdsArray addObject:object];
    
    
    [self.view addSubview:[object getImage]];
    //[self.view sendSubviewToBack:[object getImage]];
   

    
}

-(void)createCollisionImage
{

    int rand=(arc4random() % 4);
    
  
    //image selection
    int tempLifesWorth=0;
    NSString * ImageName;
    int randImage=arc4random()%2;
    if(randImage>=1)
    {
        ImageName=@"carrot.png";
        tempLifesWorth=3;
    }
    else if(randImage>=0)
    {
        ImageName=@"ball.png";
        tempLifesWorth=1;
    }
    
   
    flyingObject *object=[[flyingObject alloc] initWithImageAndIndex: [NSString stringWithFormat:@"%@",ImageName] :CGRectMake(widthOfViewController/2, -25, 25, 25) :[flyingObjectsArray count] :3];
    
    [object setIsBird:NO];
    [object setAnimationNumber:5];
     [object setLivesWorth:tempLifesWorth];
    [object setRandDirection:(arc4random() % 2 ? 1 : -1)];
    [object setRandY:arc4random()%(lengthOfViewController/2)];
    [object setRandX:arc4random()%((widthOfViewController)/2)];
    
    
    
    
    if(rand>=3)
    {
    saveMe1:
        //start image at the top and positive
        if([object getRandDirection]>=0)
        {
            [object getImage].frame=CGRectMake(((widthOfViewController/2)+[object getRandX]), -([object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height);
            [object setToImage:CGRectMake(((widthOfViewController/2)-[object getRandX]), (lengthOfViewController+[object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
        }//start image at top negative
        else
        {
            [object getImage].frame=CGRectMake(((widthOfViewController/2)-[object getRandX]), -([object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height);
            [object setToImage:CGRectMake(((widthOfViewController/2)+[object getRandX]), (lengthOfViewController+[object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
        }

    }
    else if(rand >=2)
    {
        if(blindSpotsEnabled)
        {
        //start image at bottom negative X
            if([object getRandDirection]>=0)
            {
                [object getImage].frame=CGRectMake(((widthOfViewController/2)-[object getRandX]), (lengthOfViewController+[object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height);
                [object setToImage:CGRectMake(((widthOfViewController/2)+[object getRandX]), -([object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
            }//start image at bottom positive X;
            else
            {
                [object getImage].frame=CGRectMake(((widthOfViewController/2)+[object getRandX]), (lengthOfViewController+[object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height);
                [object setToImage:CGRectMake(((widthOfViewController/2)-[object getRandX]), -([object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
            }
        }
        else
        {
            goto saveMe;
        }
    }
    else if(rand>=1)
    {
                //start image on the right and positive
        if([object getRandDirection]>=0)
        {
            if(blindSpotsEnabled==NO)
            {
                goto saveMe1;
            }
            else
            {
            
            [object getImage].frame=CGRectMake(((widthOfViewController)+[object getImage].frame.size.width), ((lengthOfViewController/2)+[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height);
            [object setToImage:CGRectMake(-([object getImage].frame.size.width), ((lengthOfViewController/2)-[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
            }
        }//start image on the right negative
        else
        {
            [object getImage].frame=CGRectMake(((widthOfViewController)+[object getImage].frame.size.width), ((lengthOfViewController/2)-[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height);
            [object setToImage:CGRectMake(-([object getImage].frame.size.width), ((lengthOfViewController/2)+[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
            
         
        }
    }
    else if(rand>=0)
    {
        //start image on the left and negative
        if([object getRandDirection]>=0)
        {
            
            [object getImage].frame=CGRectMake(-([object getImage].frame.size.width), ((lengthOfViewController/2)-[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height);
            [object setToImage:CGRectMake((widthOfViewController+[object getImage].frame.size.width), ((lengthOfViewController/2)+[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
        }//start image on the left and positive
        else
        {
            if(blindSpotsEnabled==NO)
            {
                goto saveMe1;
            }
            else
            {
            [object getImage].frame=CGRectMake(-([object getImage].frame.size.width), ((lengthOfViewController/2)+[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height);
            [object setToImage:CGRectMake((widthOfViewController+[object getImage].frame.size.width), ((lengthOfViewController/2)-[object getRandY]), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
            }
            
        }
    }
 

    
    if(0)
    {
    saveMe:
        [object getImage].frame=CGRectMake(((widthOfViewController/2)+([object getImage].frame.size.width/2)), -([object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height);
        [object setToImage:CGRectMake(((widthOfViewController/2)+([object getImage].frame.size.width/2)), (lengthOfViewController+[object getImage].frame.size.height), [object getImage].frame.size.width, [object getImage].frame.size.height) : [NSString stringWithFormat:@"%@",ImageName]];
    }
 

    [flyingObjectsArray addObject:object];
    [self.view addSubview:[object getImage]];
    //[self.view sendSubviewToBack:[object getImage]];
    
    [self animateObject:object];
 
    
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
    //[self.view sendSubviewToBack:[newBird getImage]];
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


-(void)loadPlist
{
    NSString * plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"database.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    
    _db = [[database alloc] initWithArray:(NSMutableArray *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc]];
}

-(void)showScore
{

    NSInteger secondsSinceStart = (NSInteger)[[NSDate date] timeIntervalSinceDate:Date];
    
    NSInteger seconds = secondsSinceStart % 60;
    NSInteger minutes = (secondsSinceStart / 60) % 60;
    NSInteger hours = secondsSinceStart / (60 * 60);
    NSString *result = nil;
    if (hours > 0) {
        result = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
    }
    else {
        result = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    }

    
    int highScore=[_highScoreLabel.text intValue];
    NSMutableArray * sizeOfData=[_db getDB];
    if([sizeOfData count]>3)
    {
        
       
        NSString * val= [_db getUser:(1)];
        int value=[val intValue];
        
       if(highScore>value)
       {
            [_db removeUser:(1)];
            val=[NSString stringWithFormat:@"%i",highScore];
            [_db addUser:val atIndex:(1)];
           
        }
        
        NSString *time=[_db getUser:3];
        int timeInt=[time intValue];
        
        if(seconds>timeInt)
        {
            [_db removeUser:(2)];
            [_db addUser:result atIndex:(2)];
            [_db removeUser:(3)];
            NSString *sec=[NSString stringWithFormat:@"%i",timeInt];
            [_db addUser:sec atIndex:(3)];
        }
        
    }
    else
    {
        NSString *zero=[NSString stringWithFormat:@"%i",0];
        [_db addUser:zero atIndex:0];   // first time player (0=new, 1=not new)
        [_db addUser:zero atIndex:1];       // high score birds
        [_db addUser:zero atIndex:2];   // high score Time
        [_db addUser:zero atIndex:3];
        NSString * val=[NSString stringWithFormat:@"%i",highScore];
        [_db removeUser:(1)]; //set FIRST high score
        [_db addUser:val atIndex:(1)];
 
       
    
    }
    
   
    

    [_db savePlist:[_db getDB]];
  
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
