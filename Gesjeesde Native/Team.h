//
//  Team.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTeam1Name @"Morat"
#define kTeam2Name @"Bold"

//#define kTeamNumberKey @"teamNumberKey"

@interface Team : NSObject {
    int number;
}

@property (nonatomic) int number;

-(id)initWithNumber:(int)teamNumber;
-(NSString *)getTeamName;

@end
