//
//  Game.m
//  Gesjeesde Beesten
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

@synthesize turn;
@synthesize required;

- (id)init
{
    self = [super init];
    if (self) {
        self.team1 = [[Team alloc] initWithNumber:1];
        self.team2 = [[Team alloc] initWithNumber:2];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Features" ofType:@"plist"];
        self.features = [[NSArray alloc] initWithContentsOfFile:plistPath];
        
        self.turn = 1;
        self.required = 4;
    }
    return self;
}

- (FEATURE_RESULT)resultForFeaturePicture:(FeaturePicture *)fp {
    NSDictionary *featureDict = [self getFeatureWithName:fp.feature];
    
    NSString *wrongAnimal = @"";
    NSString *correctAnimal = @"";
    
    if (issue == 1) {
        wrongAnimal = @"Bird";
        correctAnimal = @"Mammal";
    } else if (issue == 2) {
        wrongAnimal = @"Reptile";
        correctAnimal = @"Fish";
    }

    int featureForWrongAnimal = [[featureDict objectForKey:wrongAnimal] intValue];
    int featureForCorrectAnimal = [[featureDict objectForKey:correctAnimal] intValue];

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
            return FEATURE_NO_INCORRECT;
        } else {
            return FEATURE_NO_CORRECT;
        }
    }
    
    return FEATURE_NO_CORRECT; // Default return with minimal value
}

- (BOOL)feature:(FeaturePicture *)fp presentInAnimal:(NSString *)animal {
    NSDictionary *feature = [self getFeatureWithName:fp.feature];
    
    int featureValue = [[feature objectForKey:animal] intValue];
    
    return featureValue == 0 || featureValue == 1;
}

- (NSString *)getCurrentAnimal {
    // TODO refactor to getCurrentAnimalName
    if (self.issue == 1) {
        return @"Eekhoorn";
    } else if (self.issue == 2) {
        return @"Zeepaling";
    } else {
        return @"Draak";
    }
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

- (Team *)firstTeamForTurn {
    // First issue we start with team 1, and then alternate
    if (issue != 3) {
        if ((turn + issue - 1) % 2 == 0) {
            return team2;
        } else {
            return team1;
        }
    } else {
        // For issue 3 the team with the most points is allowed to start (and a minor advantage)
        if (team1.totalPoints > team2.totalPoints) {
            // Behaviour undefined for tie
            return team1;
        } else {
            return team2;
        }
    }
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
    turn = 1;
    required = 4;
    
    [self.team1 resetForNextIssue];
    [self.team2 resetForNextIssue];
}

//#pragma mark NSCoding
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:self.team1 forKey:kTeam1Key];
//    [aCoder encodeObject:self.team2 forKey:kTeam2Key];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        self.team1 = [aDecoder decodeObjectForKey:kTeam1Key];
//        self.team2 = [aDecoder decodeObjectForKey:kTeam2Key];
//    }
//    
//    return self;
//}
//
//#pragma mark - 
//#pragma mark NSCopying
//
//- (id)copyWithZone:(NSZone *)zone {
//    Game *copy = [[[self class] allocWithZone:zone] init];
//    
//    copy.team1 = [self.team1 copyWithZone:zone];
//    copy.team2 = [self.team2 copyWithZone:zone];
//    
//    return copy;
//}

@end
