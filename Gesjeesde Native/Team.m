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
@synthesize featurePictures;

- (id)initWithNumber:(int)teamNumber;
{
    self = [super init];
    if (self) {
        self.number = teamNumber;
        
        self.featurePictures = [[NSMutableArray alloc] init];
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

-(NSString *)getPicturePath {
    
    // TODO maybe save to caches
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"Team-%@-image", [self getTeamName]]];
    
    return fullPathToFile;
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
