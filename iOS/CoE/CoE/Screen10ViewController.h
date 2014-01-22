//
//  Screen10ViewController.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/01/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import "ViewController.h"
#import "DesatView.h"

@interface Screen10ViewController : ViewController
{
    int itIsWavingClock, bigShipRockingClock, bigShipRockingClockChange, smallShipRockingClock, smallShipRockingClockChange;
    CGFloat cloudMovingTimerClockChange, cloudMovingTimerClock;
    NSTimer *itIsWavingTimer, *bigShipRockingTimer, *smallShipRockingTimer, *cloudMovingTimer;
    CGAffineTransform smallShipOriginalTransform, bigShipOriginalTransform;
    
}

@property (nonatomic, retain) IBOutlet UIControl *compassControl;
@property (nonatomic, retain) IBOutlet UIImageView *Screen10BackgroundImageView, *Screen10DuneImageView, *Screen10Wave01ImageView, *Screen10Wave02ImageView, *Screen10Wave03ImageView, *Screen10Wave04ImageView, *Screen10SmallShipImageView, *Screen10BigShipImageView, *Screen10CloudImageView, *Screen10InoriImageView;

- (void) setSmallShipRockingState;
- (void) setBigShipRockingState;

@end
