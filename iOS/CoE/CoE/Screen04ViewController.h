//
//  Screen04ViewController.h
//  KickOff
//
//  Created by INKOVICS Ferenc on 29/03/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface Screen04ViewController : UIViewController<UIGestureRecognizerDelegate, AVAudioPlayerDelegate>
{
    int itIsWavingClock, bigShipRockingClock, bigShipRockingClockChange, smallShipRockingClock, smallShipRockingClockChange;
    NSTimer *itIsWavingTimer, *bigShipRockingTimer, *smallShipRockingTimer;
    BOOL isSnailMoving;
    CGPoint previousSnailCenter;
    CGAffineTransform smallShipOriginalTransform, bigShipOriginalTransform;

    AVAudioPlayer *backgroundMusic;
    AVAudioPlayer *sfxInori, *sfxBoatsAreClose, *sfxBoat, *sfxSnail;
    CGFloat boatsAreCloseVolumePercentage;
}

@property (nonatomic, retain) IBOutlet UIView *screen04StoryTextView;
@property (weak, nonatomic) IBOutlet UIView *screen04BigShipView, *screen04SmallShipView, *screen04BigShipControl;
@property (nonatomic, retain) IBOutlet UIImageView *screen04InoriSitting, *screen04InoriStanding, *screen04Wave1ImageView, *screen04Wave2ImageView, *screen04Wave3ImageView, *screen04Wave4ImageView, *screen04SnailImageView, *screen04BigShipImageView, *screen04SmallShipImageView;
@property (nonatomic, retain) IBOutlet UIControl *screen04SnailControl, *screen04SmallShipControl, *screen04InoriControl, *screen04MusicControl, *screen04NextScreenControl, *screen04PreviousScreenContol, *screen04CompassContol;

- (void) setSmallShipRockingState;
- (void) setBigShipRockingState;
- (void)startsfxBoat;
- (IBAction)forwardTappingToUnderlayingView:(UITapGestureRecognizer *)sender;

@end
