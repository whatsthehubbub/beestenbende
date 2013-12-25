//
//  Team.h
//  Beestenbende
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FeaturePicture.h"

#define kTeam1Name @"Blauw"
#define kTeam2Name @"Geel"

//#define kTeamNumberKey @"teamNumberKey"

@interface Team : NSObject {
}

@property (readwrite) int number;
@property (strong) UIImage *picture;

@property (readwrite) bool tookFeaturePictures;
// We actually need to keep track of all used featurePictures to see whether we need to disable things
@property (nonatomic, retain) NSMutableArray *featurePictures;

@property (readwrite) int points;
@property (readwrite) int totalPoints;

@property (strong) NSMutableArray *dragonFeaturesGuessed;
@property (readwrite) int dragonClass;

@property (assign) BOOL fishEliminated;
@property (assign) BOOL mammalEliminated;
@property (assign) BOOL reptileEliminated;
@property (assign) BOOL birdEliminated;

-(id)initWithNumber:(int)teamNumber;
-(NSString *)getTeamColor;
-(NSString *)getTeamName;

- (void)addFeaturePicture:(FeaturePicture *)fp;

- (void)resetForNextIssue;

@end
