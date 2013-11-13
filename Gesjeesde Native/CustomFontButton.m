//
//  CustomFontButton.m
//  Beestenbende
//
//  Created by Alper Cugun on 13/11/13.
//  Copyright (c) 2013 Hubbub. All rights reserved.
//

#import "CustomFontButton.h"

@implementation CustomFontButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFontStyle];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setFontStyle];
    }
    
    return self;
}

- (void)setFontStyle {
    
    CGFloat fontSize = self.titleLabel.font.pointSize;
    
    [self.titleLabel setFont:[UIFont fontWithName:@"LindenHill" size:fontSize]];
}

@end
