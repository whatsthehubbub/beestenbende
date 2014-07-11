//
//  UINavigationController+ClearViewControllers.m
//  Beestenbende
//
//  Created by Alper Cugun on 11/7/14.
//  Copyright (c) 2014 Hubbub. All rights reserved.
//

#import "UINavigationController+ClearViewControllers.h"

@implementation UINavigationController (ClearViewControllers)

- (void)clearViewControllerStack {
    NSArray *vcArray = [[NSArray alloc] initWithObjects:self.viewControllers.firstObject, self.viewControllers.lastObject, nil];
    [self setViewControllers:vcArray];
}

@end
