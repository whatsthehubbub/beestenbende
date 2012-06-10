//
//  Game.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"

@interface Game : NSObject {
    Team *team1;
    Team *team2;
    
    NSArray *features;
    
    // The issue we are currently playing
    int issue;
    
    // For resolving the turns
    int turn;
    int required;
}

@property (strong) Team *team1;
@property (strong) Team *team2;

@property (strong) NSArray *features;

@property (assign) int issue;

@property (assign) int turn;
@property (assign) int required;

- (NSDictionary *)getFeatureWithName:(NSString *)name;
- (NSArray *)getOrderedFeaturesForGroup:(int)number;
- (NSArray *)getClasses;

- (int)pointsForFeaturePicture:(FeaturePicture *)fp;
- (NSString *)getCurrentAnimal;

- (Team *)firstTeamForTurn;
- (Team *)secondTeamForTurn;
- (Team *)otherTeamForTeam:(Team *)thisTeam;

- (void)resetForNextIssue;

@end
