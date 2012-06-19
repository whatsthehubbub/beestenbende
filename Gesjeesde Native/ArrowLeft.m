//
//  ArrowLeft.m
//  Beestenbende
//
//  Created by Alper Çuğun on 17/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "ArrowLeft.h"

@implementation ArrowLeft

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
    UIImage *backgroundImage  = [UIImage imageNamed:@"button-pijl-links.png"];
    UIImage *stretchableBackground = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(19, 70, 19, 39)];
    
    [self setBackgroundImage:stretchableBackground forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.titleLabel setFont:[UIFont fontWithName:@"HoeflerText-Black" size:self.titleLabel.font.pointSize]];
    
//    [self.titleLabel setShadowColor:[UIColor blackColor]];
//    [self.titleLabel setShadowOffset:CGSizeMake(0.0f, -1.0f)];
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.contentEdgeInsets = UIEdgeInsetsMake(5, 30, 0, 0);
}


@end
