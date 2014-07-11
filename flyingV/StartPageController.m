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
    int highScore=[_highScoreLabel.text intValue];
    NSMutableArray * sizeOfData=[_db getDB];
    if([sizeOfData count]>2)
    {
        

        
    }
    else
    {
        NSString *zero=[NSString stringWithFormat:@"%i",0];
        [_db addUser:zero atIndex:0];   // first time player (0=new, 1=not new)
        [_db addUser:zero atIndex:1];       // high score birds
        [_db addUser:zero atIndex:2];       // high score Time
    
        
        
    }
    
    
    
    
    [_db savePlist:[_db getDB]];
    _highScoreLabel.text=[_db getUser:1];
    
    
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
