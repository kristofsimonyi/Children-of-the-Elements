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

//read for a better memory management
//http://stackoverflow.com/questions/9402061/high-virtual-memory-usage-low-allocations-on-ios
//http://stackoverflow.com/questions/14979742/releasing-memory-in-ios-5-under-arc



#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <StoreKit/StoreKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate>
{
}

@property int nextViewController;
@property BOOL musicIsOn;

@end
