//
//  Bird.h
//  flyingV
//
//  Created by Malcolm Geldmacher on 6/29/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bird : NSObject
{
    UIImageView * image;
    BOOL dying;
    int index;
}

-(id) initWithImageAndIndex:(NSString*) imageName :(CGRect) newFrame :(int) newIndex;
-(BOOL) isDying;
-(int) getIndex;
-(void) setDying:(BOOL)isDying;
-(void) setIndex:(int)newIndex;
-(UIImageView*) getImage;

@end
