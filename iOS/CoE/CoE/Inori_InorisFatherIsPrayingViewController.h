//
//  Screen01ViewController.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 11/02/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "ViewController.h"
@interface Inori_InorisFatherIsPrayingViewController : UIViewController <AVAudioPlayerDelegate>
{
    NSTimer *phase01Timer, *phase02Timer, *night02Timer, *teaPotTimer, *fatherTimer;
    NSInteger phase01TimerClock, phase02TimerClock;
    BOOL isFatherRotationClockwise, isTeaPotRockingClockwise;
    CGFloat fatherTimerClock, fatherTimerClockChange;
    CGAffineTransform teaPotOriginalTransform;
    CGFloat teaPotTimerClock, teaPotTimerChangeCurrentMax, teaPotTimerClockMax, teaPotTimerClockMin, teaPotTimerClockChange;
    AVAudioPlayer *backgroundMusic, *sfxHouse, *sfxTeaPot, *sfxFather, *narration;
    BOOL fatherInteractionFound, teaPotInteractionFound;
}

@property (nonatomic, weak) IBOutlet UIView *phase01View, *phase02View;
@property (nonatomic, weak) IBOutlet UIImageView *riceFieldBaseImageView, *windowImageView, *bedImageView, *baseImageView, *fatherImageView, *night1ImageView, *night2ImageView, *teaPotImageView, *frameImageView, *fireImageView, *transitionToPhase02ImageView, *hintLayerImageView, *menuImageView;

@property (nonatomic, weak) IBOutlet UIControl *fatherControl, *teaPotControl;

- (IBAction)fatherTouched:(id)sender;
- (IBAction)teaPotTouched:(id)sender;
- (IBAction)Screen01nextScreenButtonTouched:(id)sender;
- (IBAction)screen01PreviousButtonTouched:(id)sender;
- (IBAction)screen01MusicButtonTouched:(id)sender;
- (IBAction)hintButtonTapped;
- (IBAction)narrationButtonTapped;

@end
