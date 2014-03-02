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
    AVAudioPlayer *backgroundMusic;
}

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView, *hintLayerImageView, *menuImageView;

- (IBAction)nextScreenButtonTouched:(UITapGestureRecognizer *)sender;
- (IBAction)previousScreenButtonTouched:(UITapGestureRecognizer *)sender;
- (IBAction)hintButtonTapped:(UITapGestureRecognizer *)sender;
- (IBAction)narrationButtonTapped:(UITapGestureRecognizer *)sender;
- (IBAction)musicButtonTapped:(UITapGestureRecognizer *) sender;
@end
