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

- (id)init
{
    self = [super init];
    if (self) {
        self.team1 = [[Team alloc] initWithNumber:1];
        self.team2 = [[Team alloc] initWithNumber:2];
        
        self.features = [NSArray arrayWithObjects:@"1 rij tanden", @"Verschillende soorten tanden (kiezen/snijtanden)", @"Snavel", @"Geen tanden", @"Tanden in meerdere rijen", @"Overal tanden in de bek", @"Allemaal dezelfde tanden (geen kiezen/snijtanden)", nil];
    }
    return self;
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
