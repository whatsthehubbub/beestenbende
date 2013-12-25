//
//  Game.h
//  Beestenbende
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
    FEATURE_NO_INCORRECT_AND_UNIQUE, // 10 points
    FEATURE_NO_CORRECT // 0 points
} FEATURE_RESULT;



@interface Game : NSObject {
}

@property (strong) Team *team1;
@property (strong) Team *team2;

@property (strong) NSArray *features;

@property (assign) int issue;

@property (strong) Team *currentTeam;

@property (assign) int required;

- (NSDictionary *)getFeatureWithName:(NSString *)name;
- (NSArray *)getOrderedFeaturesForGroup:(int)number;
- (NSArray *)getClasses;

- (FEATURE_RESULT)resultForFeaturePicture:(FeaturePicture *)fp;
- (BOOL)feature:(NSString *)fName presentInAnimal:(NSString *)animal;
- (NSString *)getCurrentAnimalName;
- (NSString *)getWrongAnimalClass;
- (NSString *)getCorrectAnimalClass;

- (BOOL)feature:(NSString *)fName usedSuccesfullyByTeam:(Team *)thisTeam;
- (BOOL)featureUsedSuccesfully:(NSString *)fName;

- (Team *)getCurrentTeam;
- (Team *)firstTeamForTurn;
- (Team *)secondTeamForTurn;
- (Team *)otherTeamForTeam:(Team *)thisTeam;

- (void)resetForNextIssue;

@end
