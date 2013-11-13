#import "CustomFontLabel.h"

@implementation CustomFontLabel

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
    
    [self setFont:[UIFont fontWithName:@"LindenHill" size:fontSize]];
}

@end
