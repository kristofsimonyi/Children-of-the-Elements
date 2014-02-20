//
//  IntroScreenViewController.h
//  CoE
//
//  Created by Ferenc INKOVICS on 15/12/13.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>

@interface IntroScreenViewController : UIViewController <AVAudioPlayerDelegate>{
    AVAudioPlayer *introMusic;
}

@property (weak, nonatomic) IBOutlet UILabel *continueLabel;

@end
