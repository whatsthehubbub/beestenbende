//
//  UIImageView+UncachedImageView.m
//  Beestenbende
//
//  Created by Alper Cugun on 10/7/14.
//  Copyright (c) 2014 Hubbub. All rights reserved.
//

#import "UIImageView+UncachedImageView.h"

@implementation UIImageView (UncachedImageView)

- (void)setPlaatje:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];

//    self.image = [UIImage imageWithContentsOfFile:path];
    self.image = [UIImage imageNamed:name];
}

@end
