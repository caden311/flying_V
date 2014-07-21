//
//  SettingsPage.m
//  flyingV
//
//  Created by Brittny Wright on 7/16/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import "SettingsPage.h"

@implementation SettingsPage

- (IBAction)resumeGameButton:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SettingsViewControllerDismissed"
                                                        object:nil
                                                      userInfo:nil];
        [self dismissViewControllerAnimated:NO completion:nil];
}
@end
