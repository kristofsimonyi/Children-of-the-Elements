//
//  Inori_InoriAndAmihanDiscussingOnTheBeachViewController.h
//  CoE
//
//  Created by Ferenc INKOVICS on 02/03/14.
//  Copyright (c) 2014 No company - private person. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface Inori_InoriAndAmihanDiscussingOnTheBeachViewController : UIViewController <AVAudioPlayerDelegate>
{    
    AVAudioPlayer *backgroundMusic, *narration;

    CGFloat wavingClock, wavingClockChange, wavingClockMin, wavingClockMax, wavingClock2, wavingClockChange2, wavingClockMin2, wavingClockMax2;
    NSTimer *wavingTimer;
    BOOL isWavingUpward, isWavingUpward2;
    
}

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView, *hintLayerImageView, *menuImageView;
@property (nonatomic, weak) IBOutlet UIImageView *wave1ImageView, *wave2ImageView, *wavesImagevView;

- (IBAction)nextScreenButtonTouched:(UITapGestureRecognizer *)sender;
- (IBAction)previousScreenButtonTouched:(UITapGestureRecognizer *)sender;
- (IBAction)hintButtonTapped:(UITapGestureRecognizer *)sender;
- (IBAction)narrationButtonTapped:(UITapGestureRecognizer *)sender;
- (IBAction)musicButtonTapped:(UITapGestureRecognizer *) sender;
@end
