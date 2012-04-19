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
    
    NSMutableArray *featurePictures;
    
    int points;
}

@property (readwrite) int number;
@property (nonatomic, retain) UIImage *picture;

@property (nonatomic, retain) NSMutableArray *featurePictures;

@property (readwrite) int points;

-(id)initWithNumber:(int)teamNumber;
-(NSString *)getTeamName;
-(NSString *)getPicturePath;

- (void)purgeDeletedFeaturePictures;
- (void)purgeUsedFeaturePictures;

@end
