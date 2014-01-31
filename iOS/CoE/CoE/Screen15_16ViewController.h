//
//  Screen15_16ViewController.h
//  KickOff
//
//  Created by INKOVICS Ferenc on 15/06/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>

@interface Screen15_16UIImageViewButterfly: UIImageView

@property CGFloat xChange, yChange;
@property int xChangeType;

- (id)initWithFrame:(CGRect)frame;

@end

@interface Screen15_16ViewController : UIViewController <AVAudioPlayerDelegate> {
    NSTimer *cloudOnTheMoveTimer;
    CGFloat cloudOnTheMoveClock, cloudOnTheMoveClockChange;
    NSTimer *wavingTimer;
    CGFloat wavingClock, wavingClockChange, wavingClockMax, wavingClockMin;
    BOOL isWavingUpward;
    CGFloat wavingClock2, wavingClockChange2, wavingClockMax2, wavingClockMin2;
    BOOL isWavingUpward2;
    
    CGAffineTransform amihanHangOriginalTransform, kusiniHangOriginalTransform, talamhHangOriginalTransform, ziemeluHangOriginalTransform;
    int amihanRockingClock, amihanRockingClockChange, kusiniRockingClock, kusiniRockingClockChange, talamhRockingClock, talamhRockingClockChange, ziemeluRockingClock, ziemeluRockingClockChange;
    CGFloat cloudMovingTimerClockChange, cloudMovingTimerClock;
    NSTimer *amihanRockingTimer, *kusiniRockingTimer, *talamhRockingTimer, *ziemeluRockingTimer, *cloudMovingTimer, *birdsFlyingTimer, *butterfliesFlyingTimer;
    CGAffineTransform originalButterflyTransform;

    AVAudioPlayer *backgroundMusic;
}

@property (nonatomic, weak) IBOutlet UIImageView *screen15BackgroundImageView, *screen15Wave1ImageView, *screen15Wave2ImageView, *screen15Wave3ImageView, *screen15NightImageView, *screen15Cloud01ImageView, *screen15Cloud02ImageView, *screen15Cloud03ImageView, *screen15StarImageView, *screen15BlackImageView;
@property (nonatomic, weak) IBOutlet UIControl *screen15StarControl;

@property (nonatomic, weak) IBOutlet UIView *screen16View;


@property (nonatomic, weak) IBOutlet UIView *screen16CarouselView, *screen16CarouselTouchView, *screen16ButterfliesView;
@property (nonatomic, weak) IBOutlet UIImageView *screen16AmihanHangImageView, *screen16KusiniHangImageView, *screen16TalamhHangImageView, *screen16ZiemeluHangImageView, *screen16CarouselRisenImageView, *screen16CarouselTightImageView, *screen16CloudImageView, *screen16NightImageView;
@property (nonatomic, weak) IBOutlet UIView *screen16InoriControl;

- (IBAction)screen15_16BackToMainMenu:(id)sender;
- (IBAction)screen15_16StarControlTouched:(id)sender;
- (CGPoint)rotatePoint:(CGPoint)pointToRotate around:(CGPoint)center withDegree:(float)degree;
- (IBAction)screen15_16NextScreenButtonTouched:(id)sender;
- (IBAction)screen15_16PreviousScreenButtonTouched:(id)sender;

@end
