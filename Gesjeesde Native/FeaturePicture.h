//
//  FeaturePicture.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeaturePicture : NSObject {
    NSString *feature;
    
    UIImage *image;
}

@property (nonatomic, retain) NSString *feature;
@property (nonatomic, retain) UIImage *image;

-(id)initWithImage:(UIImage *)newImage;

@end
