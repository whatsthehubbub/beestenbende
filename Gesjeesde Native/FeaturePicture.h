//
//  FeaturePicture.h
//  Beestenbende
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeaturePicture : NSObject {
    NSString *feature;
    
    UIImage *image;
    bool deleted;
    
    int presentedTurn; // The turn that this feature picture was presented in
    bool presentAssertion; // True is Wel, False is Geen
}

@property (nonatomic, retain) NSString *feature;
@property (nonatomic, retain) UIImage *image;
@property (assign) bool deleted;

@property (assign) int presentedTurn;
@property (assign) bool presentAssertion;

-(id)initWithImage:(UIImage *)newImage;


@end
