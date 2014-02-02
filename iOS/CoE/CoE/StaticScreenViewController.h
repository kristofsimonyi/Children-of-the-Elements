//
//  Screen10ViewController.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/01/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import "DesatView.h"
#import <AVFoundation/AVFoundation.h>

@interface StaticScreenViewController : UIViewController <AVAudioPlayerDelegate>
{
    int bigShipRockingClock, bigShipRockingClockChange, smallShipRockingClock, smallShipRockingClockChange;
    CGFloat cloudMovingTimerClockChange, cloudMovingTimerClock;
    NSTimer *bigShipRockingTimer, *smallShipRockingTimer, *cloudMovingTimer;
    CGAffineTransform smallShipOriginalTransform, bigShipOriginalTransform;
    
    AVAudioPlayer *narration;
}

@property (nonatomic, weak) IBOutlet UIControl *compassControl;
@property (nonatomic, weak) IBOutlet UIImageView *Screen10BackgroundImageView, *Screen10DuneImageView, *Screen10SmallShipImageView, *Screen10BigShipImageView, *Screen10CloudImageView, *Screen10InoriImageView, *Screen10MenuImageView;
@property (nonatomic, weak) IBOutlet UITextView *staticTextView;

- (void) setSmallShipRockingState;
- (void) setBigShipRockingState;
- (IBAction)screen10NextScreenButtonTouched:(id)sender;
- (IBAction)screen10PreviousScreenButtonTouched:(id)sender;
- (IBAction)screen10NarrationButtonTouched:(id)sender;
- (IBAction)screen10MusicButtonTouched:(id)sender;

@end
