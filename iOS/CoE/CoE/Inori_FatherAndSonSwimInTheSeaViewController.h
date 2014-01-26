//
//  Inori_FatherAndSonSwimInTheSeaViewController.h
//  CoE
//
//  Created by Ferenc INKOVICS on 25/01/14.
//  Copyright (c) 2014 No company - private person. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Inori_FatherAndSonSwimInTheSeaViewController : UIViewController <AVAudioPlayerDelegate>

{
    AVAudioPlayer *backgroundMusic;

}
@property (nonatomic, retain) IBOutlet UIImageView *inoriImageView, *fatherImageView;
@property (nonatomic, retain) IBOutlet UIControl *inoriControl, *fatherControl;
- (IBAction)NextScreenControlTapped:(id) sender;
- (IBAction)PreviousScreenControlTapped:(id) sender;
- (IBAction)musicControlTapped;
- (IBAction)fishImageViewTapped:(UITapGestureRecognizer *)sender;
- (IBAction)inoriOrFatherImageViewTapped:(UITapGestureRecognizer *)sender;

@end
