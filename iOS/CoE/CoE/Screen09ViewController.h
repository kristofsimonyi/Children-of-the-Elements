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

@interface Screen09ViewController : UIViewController <AVAudioPlayerDelegate>
{
    NSTimer *seaChangeTimer, *netMovingTimer;
    CGFloat netMovingTimerClock, netMovingTimerClockChange;

    NSTimer *wavingFishTimer;
    CGFloat wavingFishTimerClock, wavingFishTimerClockChange;

    AVAudioPlayer *backgroundMusic;
}

@property (nonatomic, retain) IBOutlet UIImageView *screen09Sea01ImageView, *screen09Sea02ImageView, *screen09NetImageView;
@property (nonatomic, retain) IBOutlet WavingImageView *screen09Fish01ImageView, *screen09Fish02ImageView;
-(IBAction)screen09BackToMainMenu:(id)sender;
- (IBAction)screen09NextScreenButtonTouched:(id)sender;
- (IBAction)screen09PreviousButtonTouched:(id)sender;

@end
