//
//  Screen06_07ViewController.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/02/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonLibrary.h"
#import <AVFoundation/AVFoundation.h>

@interface Inori_FatherAndSonSwimInTheSeaViewController : UIViewController <AVAudioPlayerDelegate>
{
    NSTimer *wavingTimer, *smallFishSwarmArcTimer, *newCreatureTimer;
    CGFloat wavingTimerClock, wavingTimerClockChange, newCreatureTimerClock;
    CGFloat newXForCreature,newDirectionForCreature;
    AVAudioPlayer *backgroundMusic, *narration, *sfx2Swimmwers, *sfxFishSwarmStraight, *sfxFishSwarmArc, *sfxCreatures1, *sfxCreatures2, *sfxCreatures3;
    
    BOOL inoriInteractionFound, fatherInteractionFound, wavesInteractionFound;
}

@property (nonatomic, weak) IBOutlet UIView *screen06_07FatherControlView, *screen06_07InoriControlView, *screen06_07SmallFishSwarmView;
@property (nonatomic, weak) IBOutlet UIControl *screen06_07InoriControl, *screen06_07FatherControl;
@property (nonatomic, weak) IBOutlet WavingImageView *screen06_07Wave01ImageView, *screen06_07Wave02ImageView,*screen06_07Wave03ImageView,*screen06_07Wave04ImageView,*screen06_07Wave05ImageView,*screen06_07Wave06ImageView,*screen06_07Wave07ImageView,*screen06_07Wave08ImageView,*screen06_07Wave09ImageView, *screen06_07FatherImageView, *screen06_07InoriImageView;
@property (nonatomic, weak) IBOutlet UIImageView *hintLayerImageView, *screen06_07MenuImageView;

- (IBAction)screen06_07NextScreenControlTapped:(id) sender;
- (IBAction)screen06_07PreviousScreenControlTapped:(id) sender;
- (IBAction)screen06_07MusicButtonTapped:(UITapGestureRecognizer *) sender;
- (IBAction)screen06_07HintButtonTapped:(UITapGestureRecognizer *)sender;
- (IBAction)screen06_07NarrationButtonTapped:(UITapGestureRecognizer *)sender;

@end
