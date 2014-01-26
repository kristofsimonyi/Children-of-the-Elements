//
//  EViewController.h
//  KickOff
//
//  Created by INKOVICS Ferenc on 04/06/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EViewController : UIViewController <UIAccelerometerDelegate> {
    double alphaValue;
    CGAffineTransform carouselTightOriginalTransform, carouselRisenOriginalTransform, amihanHangOriginalTransform, kusiniHangOriginalTransform, talamhHangOriginalTransform, ziemeluHangOriginalTransform;
    int amihanRockingClock, amihanRockingClockChange, kusiniRockingClock, kusiniRockingClockChange, talamhRockingClock, talamhRockingClockChange, ziemeluRockingClock, ziemeluRockingClockChange, delayedStartClock;
    NSTimer *amihanRockingTimer, *kusiniRockingTimer, *talamhRockingTimer, *ziemeluRockingTimer, *delayedStartTimer;
    CGFloat carouselAccelerationX;
    BOOL canAccelerometerBeStarted, isCarouselSliderActive, cloudSliderOntheMove, blockChildrenTransform, isTelescopeComeIn, isTelescopeRocking, isInoriTelescopeViewModeActive;
    CGPoint firstTranslatedPoint, previousTranslatedPoint, firstCloud01Center;
    CGAffineTransform newTelescopeTransform, previousTelescopeTransform;
    CGFloat originalDegree, rotation, actualrotation, previousRotation, newDegree, oldDegree;
    NSUInteger blurRadius,previousBlurRadius;
    UIImage *screenETelescopeOrigialImage;
    NSArray *inoriBluredImageArray;
    NSTimer *telescopeRotatesTimer;
    CGFloat telescopeRotatesTimerClock;
    
    NSTimer *childrenComeInTimer;
    NSInteger childrenComeInTimerClock;
}

@property (nonatomic, retain) IBOutlet UIImageView *screenEBackgroundViewImageView, *screenEcloud01ImageView, *screenEcloud02ImageView, *screenEcloud03ImageView, *screenEAmihanImageView, *screenEKusiniImageView, *screenETalamhImageView, *screenEZiemeluImageView, *screenECarouselTightImageView, *screenECarouselRisenImageView, *screenEAmihanHangImageView, *screenEKusiniHangImageView, *screenETalamhHangImageView, *screenEZiemeluHangImageView, *screenETelescopeImageView, *screenETelescopeViewImageView, *screenEInoriTelescopeViewImageView;
@property (nonatomic, retain) IBOutlet UIView *screenECarouselView, *screenECarouselTouchView, *screenECarouselSliderView, *screenETelescopeView, *screenETelescopeViewView;
@property (nonatomic, retain) IBOutlet UIControl *screenECompassControl, *screenETelescopeTouchControl;

-(IBAction)screenEBackToMainMenu:(id)sender;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(IBAction)screenETelescopeTouched:(id)sender;

@end
