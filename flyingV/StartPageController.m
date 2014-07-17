//
//  StartPageController.m
//  flyingV
//
//  Created by Brittny Wright on 7/10/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

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
@end
