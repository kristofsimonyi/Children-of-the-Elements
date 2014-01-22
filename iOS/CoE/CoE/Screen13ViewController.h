//
//  Screen13ViewController.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/01/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import "ViewController.h"

@interface Screen13ViewController : ViewController
{
    BOOL screenIsTouchable;
    NSTimer *guitarTimer, *zitherTimer, *drumTimer, *fluteTimer;
    int guitarTimerClock, zitherTimerClock, drumTimerClock, fluteTimerClock;
}

@property (nonatomic, retain) IBOutlet UIControl *compassControl;
@property (nonatomic, retain) IBOutlet UIImageView *Screen13BackgroundImageView, *Screen13ZitherImageView, *Screen13ZitherLabelImageView, *Screen13DrumImageView, *Screen13DrumLabelImageView, *Screen13FluteImageView, *Screen13FluteLabelImageView, *Screen13GuitarImageView, *Screen13GuitarLabelImageView;
@property (nonatomic, retain) IBOutlet UIView *Screen13ZitherTouchView, *Screen13GuitarTouchView, *Screen13FluteTouchView, *Screen13DrumTouchView;
@end
