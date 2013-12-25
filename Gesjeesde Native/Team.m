//
//  Team.m
//  Beestenbende
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "Team.h"

@implementation Team

@synthesize number;
@synthesize picture;

@synthesize tookFeaturePictures;
@synthesize featurePictures;

@synthesize points;
@synthesize totalPoints;

@synthesize dragonFeaturesGuessed;
@synthesize dragonClass;

@synthesize fishEliminated;
@synthesize mammalEliminated;
@synthesize reptileEliminated;
@synthesize birdEliminated;

- (id)initWithNumber:(int)teamNumber;
{
    self = [super init];
    if (self) {
        self.number = teamNumber;
        
        tookFeaturePictures = NO;
        featurePictures = [[NSMutableArray alloc] init];
        
        self.points = 0;
        self.totalPoints = 0;
        
        // Features are added to this array if they have been used to gain points with, which makes them reusable
        self.dragonFeaturesGuessed = [[NSMutableArray alloc] init];
        self.dragonClass = 0;
        
        
        self.fishEliminated = NO;
        self.mammalEliminated = NO;
        self.reptileEliminated = NO;
        self.birdEliminated = NO;
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

- (NSString *)getTeamColor {
    if (self.number == 1) {
        return @"blue";
    } else {
        return @"yellow";
    }
}

- (void)addFeaturePicture:(FeaturePicture *)fp {
    [self.featurePictures addObject:fp];
    NSLog(@"Feature picture added");
    NSLog(@"%@", fp.image);
}

- (void)resetForNextIssue {
    tookFeaturePictures = NO;
    featurePictures = [[NSMutableArray alloc] init];
}

@end
