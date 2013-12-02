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

-(NSString *)getPicturePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Team-%@-image", [self getTeamName]]];
    
    return fullPathToFile;
}

- (FeaturePicture *)featurePictureForTurn:(int)turn {
    for (FeaturePicture *fp in self.featurePictures) {
        if (fp.presentedTurn == turn) {
            return fp;
        }
    }
    return nil;
}

- (bool)allFeaturePicturesLabelledOrDeleted {
    for (FeaturePicture *fp in self.featurePictures) {
        if ([fp.feature isEqualToString:@""] && !fp.deleted) {
            return false;
        }
    }
    
    return true;
}

- (void)purgeDeletedFeaturePictures {
    NSMutableArray *save = [[NSMutableArray alloc] init];
    
    for (FeaturePicture *fp in self.featurePictures) {
        if (!fp.deleted) {
            [save addObject:fp];
        }
    }
    self.featurePictures = save;
}

- (void)purgeUsedFeaturePictures {
    NSMutableArray *save = [[NSMutableArray alloc] init];
    
    for (FeaturePicture *fp in self.featurePictures) {
        if (fp.presentedTurn == -1) {
            [save addObject:fp];
        }
    }
    
    self.featurePictures = save;
}

- (void)resetForNextIssue {
    tookFeaturePictures = NO;
    featurePictures = [[NSMutableArray alloc] init];
}

@end
