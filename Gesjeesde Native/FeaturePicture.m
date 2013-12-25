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

@synthesize presentAssertion;

@synthesize usedSuccesfully;

-(id)initWithImage:(UIImage *)newImage {
    self = [super init];
    
    if (self) {
        self.image = newImage;
        self.feature = @"";
        
        self.presentAssertion = YES;
        
        self.usedSuccesfully = NO;
    }
    return self;
}

+ (NSString *)featureForNegation:(NSString *)theFeature {
    // This returns the feature but strips off any indefinite article in front of it ('een ') to make it fit in texts better
    
    if ([theFeature hasPrefix:@"een "]) {
        return [theFeature substringFromIndex:4];
    } else {
        return theFeature;
    }
}

@end
