//
//  Inori_AmihanIntroducesHimselfViewController.h
//  CoE
//
//  Created by Ferenc INKOVICS on 02/03/14.
//  Copyright (c) 2014 No company - private person. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface Inori_AmihanIntroducesHimselfViewController : UIViewController <AVAudioPlayerDelegate>
{
    AVAudioPlayer *backgroundMusic, *narration, *narration2, *sfxInoriPrays, *sfxWind, *sfxDistantCry, *sfxMiraculous;
    BOOL narrationToPlay;
    
    CGAffineTransform cloudOriginalTransform;
    CGFloat cloudFloatingTimerClock, cloudFloatingTimerClockChange;
    NSTimer *cloudFloatingTimer;

    CGFloat wavingClock, wavingClockChange, wavingClockMin, wavingClockMax, wavingClock2, wavingClockChange2, wavingClockMin2, wavingClockMax2;
    NSTimer *wavingTimer;
    BOOL isWavingUpward, isWavingUpward2;
}

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView, *backgroundImageView2, *hintLayerImageView, *menuImageView, *cloudImageView;
@property (nonatomic, weak) IBOutlet UIImageView *wave1ImageView, *wave2ImageView, *wavesImagevView;
@property (nonatomic, weak) IBOutlet UIImageView *inoriSittingImageView, *inoriStandingImageView;
@property (nonatomic, weak) IBOutlet UIImageView *amihanImageView;
@property (nonatomic, weak) IBOutlet UIImageView *sandImageView, *sand2ImageView;
@property (nonatomic, weak) IBOutlet UIControl *cloudControl;

- (IBAction)nextScreenButtonTouched:(UITapGestureRecognizer *)sender;
- (IBAction)previousScreenButtonTouched:(UITapGestureRecognizer *)sender;
- (IBAction)hintButtonTapped:(UITapGestureRecognizer *)sender;
- (IBAction)narrationButtonTapped:(UITapGestureRecognizer *)sender;
- (IBAction)musicButtonTapped:(UITapGestureRecognizer *) sender;
- (IBAction)inoriTapped:(UITapGestureRecognizer *) sender;
- (IBAction)cloudTapped:(UITapGestureRecognizer *) sender;

@end
