//
//  FeaturePicture.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "FeaturePicture.h"

@implementation FeaturePicture

@synthesize feature;
@synthesize image;

-(id)initWithImage:(UIImage *)newImage {
    self = [super init];
    
    if (self) {
        self.image = newImage;
        self.feature = @"";
    }
    return self;
}

@end
