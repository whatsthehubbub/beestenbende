//
//  FeaturePicture.m
//  Beestenbende
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "FeaturePicture.h"

@implementation FeaturePicture

@synthesize feature;
@synthesize image;
@synthesize deleted;
@synthesize presentedTurn;
@synthesize presentAssertion;

-(id)initWithImage:(UIImage *)newImage {
    self = [super init];
    
    if (self) {
        self.image = newImage;
        self.feature = @"";
        self.deleted = NO;
        
        self.presentedTurn = -1;
        self.presentAssertion = YES;
    }
    return self;
}

@end
