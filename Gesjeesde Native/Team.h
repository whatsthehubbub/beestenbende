//
//  Team.h
//  Gesjeesde Beesten
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
    int number;
    UIImage *picture;
    
    bool tookFeaturePictures;
    NSMutableArray *featurePictures;
    
    int points;
    int totalPoints;
    
    int dragonProofs;
    int dragonClass;
    
    // For Dragon animal elimination
    BOOL fishEliminated;
    BOOL mammalEliminated;
    BOOL reptileEliminated;
    BOOL birdEliminated;
}

@property (readwrite) int number;
@property (nonatomic, retain) UIImage *picture;

@property (readwrite) bool tookFeaturePictures;
@property (nonatomic, retain) NSMutableArray *featurePictures;

@property (readwrite) int points;
@property (readwrite) int totalPoints;

@property (readwrite) int dragonProofs;
@property (readwrite) int dragonClass;

@property (assign) BOOL fishEliminated;
@property (assign) BOOL mammalEliminated;
@property (assign) BOOL reptileEliminated;
@property (assign) BOOL birdEliminated;

-(id)initWithNumber:(int)teamNumber;
-(NSString *)getTeamName;
-(NSString *)getPicturePath;

- (FeaturePicture *)featurePictureForTurn:(int)turn;
- (bool)allFeaturePicturesLabelledOrDeleted;
- (void)purgeDeletedFeaturePictures;
- (void)purgeUsedFeaturePictures;

- (void)resetForNextIssue;

@end
