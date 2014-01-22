//
//  ViewController.h
//  KickOff
//
//  Created by INKOVICS Ferenc on 29/02/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//
// Read this and try to avoid filling the stack by calling newer and newer UIViewControllers
// http://stackoverflow.com/questions/9737234/how-do-i-switch-viewcontroller-instead-of-adding-to-stack
//



//http://www.youtube.com/watch?v=vY8tQQn4evo


#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <StoreKit/StoreKit.h>
#import "PurchaseMiniEpisodesViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate>
{
    AVAudioPlayer *backgroundMusic;
    int nextViewController;
}
@property (strong, nonatomic) AVAudioPlayer *backgroundMusic;
@property int nextViewController;
@property BOOL musicIsOn;

- (IBAction)mainscreenScreenMiniEpisode01Selected:(id)sender;
- (IBAction)mainscreenScreenMiniEpisode02Selected:(id)sender;
- (IBAction)mainscreenScreenMiniEpisode03Selected:(id)sender;
- (IBAction)mainscreenScreenMiniEpisode04Selected:(id)sender;
- (IBAction)mainscreenScreenMiniEpisode05Selected:(id)sender;

- (void)miniEpisode02Purchased;
- (void)miniEpisode03Purchased;
- (void)miniEpisode04Purchased;
- (void)miniEpisode05Purchased;

- (IBAction)mainscreenScreenA1ControlSelected:(id)sender;
- (IBAction)mainscreenScreenEControlSelected:(id)sender;
- (IBAction)mainscreenScreen01ControlSelected:(id)sender;
- (IBAction)mainscreenScreen02_03ControlSelected:(id)sender;
- (IBAction)mainscreenScreen04ControlSelected:(id)sender;
- (IBAction)mainscreenScreen06_07ControlSelected:(id)sender;
- (IBAction)mainscreenScreen08ControlSelected:(id)sender;
- (IBAction)mainscreenScreen09ControlSelected:(id)sender;
- (IBAction)mainscreenScreen10ControlSelected:(id)sender;
- (IBAction)mainscreenScreen11ControlSelected:(id)sender;
- (IBAction)mainscreenScreen12ControlSelected:(id)sender;
- (IBAction)mainscreenScreen13ControlSelected:(id)sender;
- (IBAction)mainscreenScreen14ControlSelected:(id)sender;
- (IBAction)mainscreenScreen15_16ControlSelected:(id)sender;
- (IBAction)mainscreenScrollingPagesControlSelected:(id)sender;
- (IBAction)mainscreenScreenFontsSelected:(id)sender;
- (IBAction)mainscreenMusicButtonTouched:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *miniEpisode02Padlock;
@property (weak, nonatomic) IBOutlet UIImageView *miniEpisode03Padlock;
@property (weak, nonatomic) IBOutlet UIImageView *miniEpisode04Padlock;
@property (weak, nonatomic) IBOutlet UIImageView *miniEpisode05Padlock;

@property (weak, nonatomic) IBOutlet UIView *miniEpisode01View;
@property (weak, nonatomic) IBOutlet UIView *miniEpisode02View;
@property (weak, nonatomic) IBOutlet UIView *miniEpisode03View;
@property (weak, nonatomic) IBOutlet UIView *miniEpisode04View;
@property (weak, nonatomic) IBOutlet UIView *miniEpisode05View;

@property (strong, nonatomic) PurchaseMiniEpisodesViewController *purchaseMiniEpisodesViewController;

@end
