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
        NSDictionary *root = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        self.features = (NSArray *)[root objectForKey:@"Root"];
        
        issue = 2; // We start at the first issue
        
        self.turn = 1;
        self.required = 4;
    }
    return self;
}

- (NSDictionary *)getFeatureWithName:(NSString *)name {
    for (NSDictionary *dict in self.features) {
        if ([name isEqualToString:[dict objectForKey:@"Label"]]) {
            return dict;
        }
    }
    return nil;
}

- (Team *)firstTeamForTurn {
    // First issue we start with team 1, and then alternate
    if ((turn + issue - 1) % 2 == 0) {
        return team2;
    } else {
        return team1;
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
