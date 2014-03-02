//
//  Screen04ViewController.h
//  KickOff
//
//  Created by INKOVICS Ferenc on 29/03/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>

@interface Inori_InoriIsWaitingForTheFishermenOnTheBeachViewController : UIViewController<UIGestureRecognizerDelegate, AVAudioPlayerDelegate>
{
    int itIsWavingClock, bigShipRockingClock, bigShipRockingClockChange, smallShipRockingClock, smallShipRockingClockChange;
    NSTimer *itIsWavingTimer, *bigShipRockingTimer, *smallShipRockingTimer;
    BOOL isSnailMoving;
    CGPoint previousSnailCenter;
    CGAffineTransform smallShipOriginalTransform, bigShipOriginalTransform;

    AVAudioPlayer *backgroundMusic, *narration;
    AVAudioPlayer *sfxInori, *sfxBoatsAreClose, *sfxBoat, *sfxSnail1, *sfxSnail2, *sfxSnail3;
    CGFloat boatsAreCloseVolumePercentage;
    
    BOOL snailInteractionFound, inoriInteractionFound, shipsInteractionFound;
}

@property (nonatomic, weak) IBOutlet UIView *screen04BigShipView, *screen04SmallShipView, *screen04BigShipControl;
@property (nonatomic, weak) IBOutlet UIImageView *screen04BaseImageView, *screen04InoriSitting, *screen04InoriStanding, *screen04Wave1ImageView, *screen04Wave2ImageView, *screen04Wave3ImageView, *screen04Wave4ImageView, *screen04SnailImageView, *screen04BigShipImageView, *screen04SmallShipImageView, *hintLayerImageView, *screen04MenuImageView;
@property (nonatomic, weak) IBOutlet UIControl *screen04SnailControl, *screen04SmallShipControl, *screen04InoriControl, *screen04MusicButton, *screen04NarrationButton, *screen04HintButton, *screen04NextScreenButton, *screen04PreviousScreenButton;

- (void) setSmallShipRockingState;
- (void) setBigShipRockingState;
- (void) startsfxBoat;
- (IBAction) forwardTappingToUnderlayingView:(UITapGestureRecognizer *)sender;

@end
