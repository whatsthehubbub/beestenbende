//
//  AppDelegate.h
//  Gesjeesde Native
//
//  Created by Alper Çuğun on 21/3/12.
//  Copyright (c) 2012 Aardverschuiving Media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Game.h"
#import "Flurry.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    Game *game;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) Game *game;

@end
