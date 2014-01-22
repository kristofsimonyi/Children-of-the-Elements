//
//  Screen08ViewController.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/01/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import "ViewController.h"
#import "DesatView.h"

@interface Screen08ViewController : ViewController
{
    int itIsWavingClock, bigShipRockingClock, bigShipRockingClockChange, smallShipRockingClock, smallShipRockingClockChange;
    CGFloat cloudMovingTimerClockChange, cloudMovingTimerClock;
    NSTimer *itIsWavingTimer, *bigShipRockingTimer, *smallShipRockingTimer, *cloudMovingTimer;
    CGAffineTransform smallShipOriginalTransform, bigShipOriginalTransform;
    
}

@property (nonatomic, retain) IBOutlet UIControl *compassControl;
@property (nonatomic, retain) IBOutlet UIImageView *screen08BackgroundImageView, *screen08DuneImageView, *screen08Wave01ImageView, *screen08Wave02ImageView, *screen08Wave03ImageView, *screen08Wave04ImageView, *screen08SmallShipImageView, *screen08BigShipImageView, *screen08CloudImageView, *screen08InoriImageView;

- (void) setSmallShipRockingState;
- (void) setBigShipRockingState;

@end
