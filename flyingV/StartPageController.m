//
//  StartPageController.m
//  flyingV
//
//  Created by Brittny Wright on 7/10/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//
bool gameCenterEnabled;
NSString *leaderBoard;
int highScoreLeaderBoard;
#include "StartPageController.h"
#include "dataBase.h"

@implementation StartPageController

@synthesize db=_db;

@synthesize highScoreLabel=_highScoreLabel;



-(void)viewDidAppear:(BOOL)animated
{
    
     [self loadScore];
}

- (void)viewDidLoad
{
    
   
    [super viewDidLoad];
    [self authenticateLocalPlayer];
    startPageGameTimer=[NSTimer scheduledTimerWithTimeInterval:.016 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    startPageHeadBirdChasePoint = _playButton.center;
    
}
-(void)gameLoop
{
    [self moveBirds: startPageHeadBirdChasePoint];
    [self updateBackground];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    location.y-=60;
    startPageHeadBirdChasePoint = location;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:touch.view];
    location.y-=60;
    startPageHeadBirdChasePoint = location;
}
-(void)moveBirds: (CGPoint) location
{
    //Move Play Button
    float chaseX = (_playButton.center.x - location.x) / 15;
    float chaseY = (_playButton.center.y - location.y) / 15;
    CGPoint newPoint = location;
    newPoint.x = _playButton.center.x - chaseX;
    newPoint.y = _playButton.center.y - chaseY;
    _playButton.center = newPoint;
    CGPoint tempLocation = _playButton.center;
    float moveDistX = 50;
    float moveDistY = 90;
    
    //Move tutorial button
    tempLocation.x -= moveDistX;
    tempLocation.y += moveDistY;
    chaseX = (_tutorialButton.center.x - tempLocation.x) / 15;
    chaseY = (_tutorialButton.center.y - tempLocation.y) / 15;
    newPoint.x = _tutorialButton.center.x - chaseX;
    newPoint.y = _tutorialButton.center.y - chaseY;
    _tutorialButton.center = newPoint;
    tempLocation = _tutorialButton.center;
    
    //Move Stats button
    tempLocation.x -= moveDistX;
    tempLocation.y += moveDistY;
    chaseX = (_statsButton.center.x - tempLocation.x) / 15;
    chaseY = (_statsButton.center.y - tempLocation.y) / 15;
    newPoint.x = _statsButton.center.x - chaseX;
    newPoint.y = _statsButton.center.y - chaseY;
    _statsButton.center = newPoint;
    tempLocation = _statsButton.center;
    
    //Move Settings Button
    tempLocation = _playButton.center;
    tempLocation.x += moveDistX;
    tempLocation.y += moveDistY;
    chaseX = (_settingsButton.center.x - tempLocation.x) / 15;
    chaseY = (_settingsButton.center.y - tempLocation.y) / 15;
    newPoint.x = _settingsButton.center.x - chaseX;
    newPoint.y = _settingsButton.center.y - chaseY;
    _settingsButton.center = newPoint;
    tempLocation = _settingsButton.center;
    
    //Move Game Center Button
    tempLocation.x += moveDistX;
    tempLocation.y += moveDistY;
    chaseX = (_gameCenterButton.center.x - tempLocation.x) / 15;
    chaseY = (_gameCenterButton.center.y - tempLocation.y) / 15;
    newPoint.x = _gameCenterButton.center.x - chaseX;
    newPoint.y = _gameCenterButton.center.y - chaseY;
    _gameCenterButton.center = newPoint;
}
-(void)updateBackground
{
    
}
-(void)loadScore
{
    [self loadPlist];
    
    int highTime=0;
    NSArray *timeArray = [_longestTimeLabel.text componentsSeparatedByString:@":"];
    if([timeArray count]>2)
    {
        int hour=[timeArray[0] intValue];
        int min=[timeArray[1] intValue];
        int seconds=[timeArray[2] intValue];
        highTime=seconds+(min*60)+(hour*60*60);
    }
    else if([timeArray count] >1)
    {
        int min=[timeArray[0] intValue];
        int seconds=[timeArray[1] intValue];
        highTime=seconds+(min*60);
        
    }
    
     int highScore=[_highScoreLabel.text intValue];
    NSMutableArray * sizeOfData=[_db getDB];
    if([sizeOfData count]>3)
    {
        NSString *tempHigh=[_db getUser:1];
        int tempScore=[tempHigh intValue];
        highScoreLeaderBoard=highScore;
         [self reportScore];
            if(tempScore<highScore)
            {
                
                [_db removeUser:1];
                [_db addUser:tempHigh atIndex:1];
            }
        
        NSString *time=[_db getUser:2];
        NSString *sec=[_db getUser:3];
        int second=[sec intValue];
        if(second>highTime)
        {
            [_db removeUser:(2)];
            [_db addUser:time atIndex:(2)];
        }
        
    }
    else
    {
        NSString *zero=[NSString stringWithFormat:@"%i",0];
        [_db addUser:zero atIndex:0];   // first time player (0=new, 1=not new)
        [_db addUser:zero atIndex:1];       // high score birds
        [_db addUser:zero atIndex:2];    // high score Time
        [_db addUser:zero atIndex:3];   
        
    }
    
    
    
    
    [_db savePlist:[_db getDB]];
    _highScoreLabel.text=[_db getUser:1];
    _longestTimeLabel.text=[_db getUser:2];
    
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
- (IBAction)playButtonPressed:(id)sender {
}

- (IBAction)tutorialButtonPressed:(id)sender {
}

- (IBAction)settingsButtonPressed:(id)sender {
}

- (IBAction)statsButtonPressed:(id)sender {
}

- (IBAction)gameCenterButtonPressed:(id)sender
{
    if(gameCenterEnabled==YES)
    {
        [self showLeaderboardAndAchievements:YES];

    }
}

-(void)authenticateLocalPlayer{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if (viewController != nil) {
            [self presentViewController:viewController animated:YES completion:nil];
        }
        else{
            if ([GKLocalPlayer localPlayer].authenticated) {
                gameCenterEnabled = YES;
                
                // Get the default leaderboard identifier.
                [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                    
                    if (error != nil) {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else{
                        leaderBoard = leaderboardIdentifier;
                    }
                }];
            }
            
            else{
                gameCenterEnabled = NO;
            }
        }
    };
}

-(void)reportScore{
   
    
    GKScore *reportScore = [[GKScore alloc] initWithLeaderboardIdentifier:@"leaderBoardI"];
    reportScore.value = highScoreLeaderBoard;
    
    NSArray *scores = @[reportScore];
    
    [GKScore reportScores:scores withCompletionHandler:nil];
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard{
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = leaderBoard;
    }
    else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    
    [self presentViewController:gcViewController animated:YES completion:nil];
}
@end
