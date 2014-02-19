//
//  Screen09ViewController.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/02/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonLibrary.h"
#import <AVFoundation/AVAudioPlayer.h>

@interface Inori_FatherAndSonPatchUpAFishnetViewController : UIViewController <AVAudioPlayerDelegate>
{
    NSTimer *seaChangeTimer, *netMovingTimer;
    CGFloat netMovingTimerClock, netMovingTimerClockChange;

    BOOL netIsOnTheMove;
    CGPoint previousTranslatedPoint;

    NSTimer *wavingFishTimer;
    CGFloat wavingFishTimerClock, wavingFishTimerClockChange;

    AVAudioPlayer *backgroundMusic, *narration, *sfxInoriAndFather, *sfxFish1, *sfxFish2;
    
    BOOL fish1InteractionFound, fish2InteractionFound, fish3InteractionFound, fish4InteractionFound, fish5InteractionFound, inoriAndFatherInteractionFound;
}

@property (nonatomic, weak) IBOutlet UIControl *screen09InoriAndFatherControl;
@property (nonatomic, weak) IBOutlet UIImageView *screen09ShoreImageView, *screen09PeopleImageView, *screen09Sea01ImageView, *screen09Sea02ImageView, *screen09NetImageView, *screen09MenuImageView, *hintLayerImageView;
@property (nonatomic, weak) IBOutlet WavingImageView *screen09Fish01ImageView, *screen09Fish02ImageView, *screen09Fish03ImageView, *screen09Fish04ImageView, *screen09Fish05ImageView;

- (IBAction)screen09NextScreenButtonTouched:(id)sender;
- (IBAction)screen09PreviousButtonTouched:(id)sender;
- (IBAction)screen09NarrationButtonTapped:(UITapGestureRecognizer *)sender;
- (IBAction)screen09MusicButtonTapped:(UITapGestureRecognizer *) sender;
- (IBAction)screen09HintButtonTapped:(UITapGestureRecognizer *)sender;
//- (IBAction)netPanGestureRecognizer:(UIPanGestureRecognizer *)sender;

@end
