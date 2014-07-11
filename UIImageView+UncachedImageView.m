//
//  UIImageView+UncachedImageView.m
//  Beestenbende
//
//  Created by Alper Cugun on 10/7/14.
//  Copyright (c) 2014 Hubbub. All rights reserved.
//

#import "UIImageView+UncachedImageView.h"

@implementation UIImageView (UncachedImageView)

/**
 * Here we catch the user defined runtime attribute for ImageViews where 
 * we don't want to use imageNamed because that cache is filling up.
 */
- (void)setUncachedImage:(NSString *)name {
    // TODO we're hardcoding it here to be retina because that is what we use
    NSString *retinaName = [NSString stringWithFormat:@"%@@2x", name];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:retinaName ofType:@"png"];
    
//    NSLog(@"Got path %@", path);

    self.image = [UIImage imageWithContentsOfFile:path];
}

@end
