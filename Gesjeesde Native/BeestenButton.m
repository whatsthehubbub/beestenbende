//
//  BeestenButton.m
//  Beestenbende
//
//  Created by Alper Çuğun on 17/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "BeestenButton.h"

@implementation BeestenButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customizeButton];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self customizeButton];
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

- (void)customizeButton {
    UIImage *backgroundImage  = [UIImage imageNamed:@"button-vierkant.png"];
    UIImage *stretchableBackground = [backgroundImage stretchableImageWithLeftCapWidth:10 topCapHeight:0];
    
    [self setBackgroundImage:stretchableBackground forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.titleLabel setFont:[UIFont fontWithName:@"HoeflerText-Black" size:18]];
    
//    [self.titleLabel setShadowColor:[UIColor blackColor]];
//    [self.titleLabel setShadowOffset:CGSizeMake(0.0f, -1.0f)];
}

@end
