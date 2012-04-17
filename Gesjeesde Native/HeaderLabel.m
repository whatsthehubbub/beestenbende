//
//  HeaderLabel.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 16/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "HeaderLabel.h"

@implementation HeaderLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customizeLabel];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self customizeLabel];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)customizeLabel {
    [self setFont:[UIFont fontWithName:@"Vollkorn-Regular" size:self.font.pointSize]];
}

@end
