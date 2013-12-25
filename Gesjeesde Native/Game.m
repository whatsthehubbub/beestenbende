//
//  Game.m
//  Beestenbende
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize team1;
@synthesize team2;

@synthesize features;

@synthesize issue;

@synthesize currentTeam;

@synthesize required;

- (id)init
{
    self = [super init];
    if (self) {
        self.team1 = [[Team alloc] initWithNumber:1];
        self.team2 = [[Team alloc] initWithNumber:2];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Features" ofType:@"plist"];
        self.features = [[NSArray alloc] initWithContentsOfFile:plistPath];
        
        self.currentTeam = nil;
        
        self.required = 4;
    }
    return self;
}

- (FEATURE_RESULT)resultForFeaturePicture:(FeaturePicture *)fp {
    NSDictionary *featureDict = [self getFeatureWithName:fp.feature];
    
    int featureForWrongAnimal = [[featureDict objectForKey:[self getWrongAnimalClass]] intValue];
    int featureForCorrectAnimal = [[featureDict objectForKey:[self getCorrectAnimalClass]] intValue];

    if (fp.presentAssertion) {
        if (featureForCorrectAnimal == 0) {
            return FEATURE_YES_UNIQUE;
        } else if (featureForCorrectAnimal == 1) {
            if (featureForWrongAnimal != 1) {
                return FEATURE_YES_CORRECT_AND_DIFFERENTIATING;
            } else {
                return FEATURE_YES_CORRECT_NOT_DIFFERENTIATING;
            }
        } else if (featureForCorrectAnimal == 2) {
            return FEATURE_YES_INCORRECT;
        }
    } else {
        if (featureForCorrectAnimal == 2) {
            if (featureForWrongAnimal == 0) {
                return FEATURE_NO_INCORRECT_AND_UNIQUE;
            } else {
                return FEATURE_NO_INCORRECT;
            }
        } else {
            return FEATURE_NO_CORRECT;
        }
    }
    
    return FEATURE_NO_CORRECT; // Default return with minimal value
}

- (BOOL)feature:(NSString *)fName presentInAnimal:(NSString *)animal {
    if (animal) {
        NSDictionary *feature = [self getFeatureWithName:fName];

        int featureValue = [[feature objectForKey:animal] intValue];

        return featureValue == 0 || featureValue == 1;
    }
    return NO;
}

- (NSString *)getCurrentAnimalName {
    if (self.issue == 1) {
        return @"Eekhoorn";
    } else if (self.issue == 2) {
        return @"Zeepaling";
    } else {
        return @"Draakje";
    }
}

- (NSString *)getWrongAnimalClass {
    NSString *animalClass = nil;
    
    if (issue == 1) {
        animalClass = @"Vogel";
    } else if (issue == 2) {
        animalClass = @"Reptiel";
    }
    
    return animalClass;
}

- (NSString *)getCorrectAnimalClass {
    NSString *animalClass = nil;
    
    if (issue == 1) {
        animalClass = @"Zoogdier";
    } else if (issue == 2) {
        animalClass = @"Vis";
    }
    
    return animalClass;
}

- (NSDictionary *)getFeatureWithName:(NSString *)name {
    for (NSDictionary *group in self.features) {
        NSArray *groupFeatures = [group objectForKey:@"Features"];
        for (NSDictionary *feature in groupFeatures) {
            if ([name isEqualToString:[feature objectForKey:@"Label"]]) {
                return feature;
            }
        }
    }
    return nil;
}

- (NSArray *)getOrderedFeaturesForGroup:(int)number {
    return [[[self.features objectAtIndex:number] objectForKey:@"Features"] sortedArrayUsingComparator: ^(id a, id b) {
        NSString *first = [a objectForKey:@"Label"];
        NSString *second = [b objectForKey:@"Label"];
        
        return [first compare:second];
    }];
}

- (NSArray *)getClasses { 
    return [[NSArray alloc] initWithObjects:@"Vis", @"Zoogdier", @"Reptiel", @"Vogel", nil];
}


- (Team *)getCurrentTeam {
    if (!self.currentTeam) {
        // Flip a coin for who is allowed to start
        int randomTeam = (arc4random() % 2) + 1;
        
        if (randomTeam == 1) {
            self.currentTeam = team1;
        } else {
            self.currentTeam = team2;
        }
    }
    
    return self.currentTeam;
}

- (BOOL)featureUsedSuccesfully:(NSString *)fName {
    return [self feature:fName usedSuccesfullyByTeam:self.team1] || [self feature:fName usedSuccesfullyByTeam:self.team2];
}

- (BOOL)feature:(NSString *)fName usedSuccesfullyByTeam:(Team *)thisTeam {
    for (FeaturePicture *fp in thisTeam.featurePictures) {
        if ([fp.feature isEqualToString:fName] && fp.usedSuccesfully) {
            return YES;
        }
    }
        
    return NO;
}

// Remove this method altogether TODO
- (Team *)firstTeamForTurn {
    // This function is only called by the Dragon issue so no check for issue is required anymore
//    if (issue == 3) {
    
    // For issue 3 the team with the most points is allowed to start (and a minor advantage)
    if (team1.totalPoints > team2.totalPoints) {
        // Behaviour undefined for tie
        return team1;
    } else {
        return team2;
    }
    
//    }
}

- (Team *)secondTeamForTurn {
    return [self otherTeamForTeam:[self firstTeamForTurn]];
}

- (Team *)otherTeamForTeam:(Team *)thisTeam {
    if (thisTeam.number == 1) {
        return self.team2;
    } else {
        return self.team1;
    }
}

- (void)resetForNextIssue {
    required = 4;
    
    [self.team1 resetForNextIssue];
    [self.team2 resetForNextIssue];
}

@end
