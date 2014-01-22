//
//  Screen06_07ViewController.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/02/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonLibrary.h"

@interface Screen06_07ViewController : UIViewController
{
    NSTimer *wavingTimer, *smallFishSwarmArcTimer, *newCreatureTimer;
    CGFloat wavingTimerClock, wavingTimerClockChange, newCreatureTimerClock;
    CGFloat newXForCreature,newDirectionForCreature;
}

@property (nonatomic, retain) IBOutlet UIView *screen06_07FatherControlView, *screen06_07InoriControlView, *screen06_07SmallFishSwarmView;
@property (nonatomic, retain) IBOutlet UIControl *screen06_07InoriControl, *screen06_07FatherControl;
@property (nonatomic, retain) IBOutlet WavingImageView *screen06_07Wave01ImageView, *screen06_07Wave02ImageView,*screen06_07Wave03ImageView,*screen06_07Wave04ImageView,*screen06_07Wave05ImageView,*screen06_07Wave06ImageView,*screen06_07Wave07ImageView,*screen06_07Wave08ImageView,*screen06_07Wave09ImageView, *screen06_07FatherImageView, *screen06_07InoriImageView;

-(IBAction)screen06_07BackToMainMenu:(id)sender;

@end
