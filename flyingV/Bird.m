//
//  Bird.m
//  flyingV
//
//  Created by Malcolm Geldmacher on 6/29/14.
//  Copyright (c) 2014 vientapps. All rights reserved.
//

#import "Bird.h"

@implementation Bird

-(id)initWithImageAndIndex:(NSString *)imageName :(CGRect)newFrame :(int)newIndex
{
    self = [super init];
    if(self)
    {
        image = [[UIImageView alloc]initWithFrame:newFrame];
        image.image = [UIImage imageNamed:imageName];
        dying = NO;
        index = newIndex;
    }
    return self;
}

-(UIImageView *)getImage
{
    return image;
}

-(void)setDying:(BOOL)isDying
{
    dying = isDying;
}

-(BOOL)isDying
{
    return dying;
}

-(void)setIndex:(int)newIndex
{
    index = newIndex;
}

-(int)getIndex
{
    return index;
}

@end
