//
//  Screen14ViewController.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/01/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>

@interface Screen14ViewController : UIViewController <AVAudioPlayerDelegate>
{
    AVAudioPlayer *backgroundMusic, *backgroundMusic2;
}

@property (nonatomic, retain) IBOutlet UIControl *compassControl;
@property (nonatomic, retain) IBOutlet UIImageView *Screen14BackgroundImageView;

- (IBAction)screen14NextScreenButtonTouched:(id)sender;
- (IBAction)screen1PreviousScreenButtonTouched:(id)sender;

@end
