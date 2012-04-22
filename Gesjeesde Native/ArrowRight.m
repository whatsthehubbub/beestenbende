//
//  ArrowRight.m
//  Beestenbende
//
//  Created by Alper Çuğun on 17/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "ArrowRight.h"

@implementation ArrowRight

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
    UIImage *backgroundImage  = [UIImage imageNamed:@"button-pijl-rechts.png"];
    UIImage *stretchableBackground = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 39, 21, 70)];
    
    [self setBackgroundImage:stretchableBackground forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.titleLabel setFont:[UIFont fontWithName:@"Vollkorn-Bold" size:self.titleLabel.font.pointSize]];
    
//    [self.titleLabel setShadowColor:[UIColor blackColor]];
//    [self.titleLabel setShadowOffset:CGSizeMake(0.0f, -1.0f)];
    
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
}


@end
