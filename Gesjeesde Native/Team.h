//
//  Team.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTeam1Name @"Marot"
#define kTeam2Name @"Seba"

//#define kTeamNumberKey @"teamNumberKey"

@interface Team : NSObject {
    int number;
    
    NSMutableArray *featurePictures;
}

@property (nonatomic) int number;
@property (nonatomic, retain) NSMutableArray *featurePictures;

-(id)initWithNumber:(int)teamNumber;
-(NSString *)getTeamName;
-(NSString *)getPicturePath;

@end
