//
//  ViewController.h
//  flyingV
//
//  Created by Brittny Wright on 6/3/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    int lengthOfViewController;
    int widthOfViewController;
    NSMutableArray * birds;
    float sizeModifier;
    float newBirdSizeModifier;
    
    
    
    
    NSTimer * gameTimer;
    int count;
    
}



@property (strong, nonatomic) IBOutlet UIImageView *birdImage;




@end
