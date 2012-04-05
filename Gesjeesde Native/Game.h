//
//  Game.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"

//#define kTeam1Key @"team1key"
//#define kTeam2Key @"team2key"

@interface Game : NSObject {
    Team *team1;
    Team *team2;
    
    NSArray *features;
    
    // For resolving the turns
    int turn;
    int required;
}

@property (strong) Team *team1;
@property (strong) Team *team2;

@property (strong) NSArray *features;

@property (assign) int turn;
@property (assign) int required;

- (NSDictionary *)getFeatureWithName:(NSString *)name;

@end
