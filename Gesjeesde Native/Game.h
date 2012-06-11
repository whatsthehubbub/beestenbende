//
//  Game.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"

typedef enum {
    FEATURE_YES_UNIQUE, // 10 points
    FEATURE_YES_CORRECT_AND_DIFFERENTIATING, // 5 points
    FEATURE_YES_CORRECT_NOT_DIFFERENTIATING, // 0 points
    FEATURE_YES_INCORRECT, // 0 points
    
    FEATURE_NO_INCORRECT, // 5 points
    FEATURE_NO_CORRECT // 0 points
} FEATURE_RESULT;



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

- (FEATURE_RESULT)resultForFeaturePicture:(FeaturePicture *)fp;
- (BOOL)feature:(FeaturePicture *)fp presentInAnimal:(NSString *)animal;
- (NSString *)getCurrentAnimal;

- (Team *)firstTeamForTurn;
- (Team *)secondTeamForTurn;
- (Team *)otherTeamForTeam:(Team *)thisTeam;

- (void)resetForNextIssue;

@end
