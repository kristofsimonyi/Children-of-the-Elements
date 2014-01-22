//
//  DesatView.m
//  KickOff
//
//  Created by Ferenc INKOVICS on 20/01/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import "DesatView.h"

@implementation DesatView
@synthesize image, desaturation;

-(void)setSaturation:(float)sat;
{
    saturation = sat;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor]; // else background is black
        desaturation = 0.0; // default is no effect
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height); // flip image right side up
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, rect, self.image.CGImage);
    CGContextSetBlendMode(context, kCGBlendModeSaturation);
    CGContextClipToMask(context, self.bounds, image.CGImage); // restricts drawing to within alpha channel
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, desaturation);
    CGContextFillRect(context, rect);
    
    CGContextRestoreGState(context); // restore state to reset blend mode
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
