//
//  DesatView.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 20/01/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DesatView : UIView {
    UIImage *image;
    float saturation;
}
@property (nonatomic, retain) UIImage *image;
@property (nonatomic) float desaturation;
@end



