//
//  FeaturePicture.h
//  Beestenbende
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeaturePicture : NSObject {
}

@property (nonatomic, retain) NSString *feature;
@property (nonatomic, retain) UIImage *image;

@property (assign) BOOL presentAssertion;

@property (assign) BOOL usedSuccesfully;

-(id)initWithImage:(UIImage *)newImage;

+ (NSString *)featureForNegation:(NSString *)theFeature;

@end
