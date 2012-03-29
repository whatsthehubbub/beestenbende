//
//  Team.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "Team.h"

@implementation Team

@synthesize number;

- (id)initWithNumber:(int)teamNumber;
{
    self = [super init];
    if (self) {
        self.number = teamNumber;
    }
    return self;
}

-(NSString *)getTeamName {
    if (self.number == 1) {
        return kTeam1Name;
    } else {
        return kTeam2Name;
    }
}

//#pragma mark NSCoding
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeInt:self.number forKey:kTeamNumberKey];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        self.number = [aDecoder decodeIntForKey:kTeamNumberKey];
//    }
//    
//    return self;
//}

//#pragma mark -
//#pragma mark NSCopying
//
//- (id)copyWithZone:(NSZone *)zone {
//    Team *team = [[[self class] allocWithZone:zone] init];
//    team.number = self.number;
//    return team;
//}

@end
