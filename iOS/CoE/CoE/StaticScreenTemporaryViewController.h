//
//  Screen10ViewController.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/01/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface StaticScreenTemporaryViewController : UIViewController <AVAudioPlayerDelegate>
{
    AVAudioPlayer *narration;
}

@property (nonatomic, weak) IBOutlet UIImageView *Screen10BackgroundImageView, *Screen10MenuImageView;

- (IBAction)screen10NextScreenButtonTouched:(id)sender;
- (IBAction)screen10PreviousScreenButtonTouched:(id)sender;
- (IBAction)screen10NarrationButtonTouched:(id)sender;
- (IBAction)screen10MusicButtonTouched:(id)sender;

@end
