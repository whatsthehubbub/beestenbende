//
//  CustomItalicFontLabel.m
//  Beestenbende
//
//  Created by Alper Cugun on 14/11/13.
//  Copyright (c) 2013 Hubbub. All rights reserved.
//

#import "CustomItalicFontLabel.h"

@implementation CustomItalicFontLabel

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
    CGFloat fontSize = self.font.pointSize;
    
    [self setFont:[UIFont fontWithName:@"LindenHill-Italic" size:fontSize]];
}

@end
