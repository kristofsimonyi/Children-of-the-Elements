//
//  A1ViewController.h
//  KickOff
//
//  Created by INKOVICS Ferenc on 18/03/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface A1ViewController : UIViewController <AVAudioPlayerDelegate>{
NSMutableArray *rainDrops1Array, *rainDrops1StartArray, *rainDrops1StopArray, *rainDrops1StepsArray, *rainDrops2Array, *rainDrops2StartArray, *rainDrops2StopArray, *rainDrops2StepsArray, *rainDrops3Array, *rainDrops3StartArray, *rainDrops3StopArray, *rainDrops3StepsArray, *rainDrops4Array, *rainDrops4StartArray, *rainDrops4StopArray, *rainDrops4StepsArray;
int itIsRaining1Clock, puddle1MaxSteps,itIsRaining2Clock, puddle2MaxSteps, itIsRaining3Clock, puddle3MaxSteps,itIsRaining4Clock, puddle4MaxSteps, clothes4Clock;
int randomCatNumber;
CGFloat sfxVolume, rainSFXVolumeClockChange;
NSTimer *itIsRaining1Timer, *itIsRaining2Timer, *itIsRaining3Timer, *itIsRaining4Timer, *clothes4Timer, *rainSFXVolumeTimer;
CGAffineTransform previousTransformMatrix;
CGPoint firstTranslatedPoint, almondOriginalCenter;
BOOL isAlmondDragging;
UIImageView *selectedAlmond;
CGAffineTransform originalTransformMatrix;
AVAudioPlayer *catSFX, *lightSwitchSFX, *tubeFiresCreamSFX, *windSFX, *windowCreekSFX, *windChimesSFX, *itIsRainingSFX;
}

@property (nonatomic, retain) IBOutlet UIView *a1View, *a1StoryTextView;;
@property (nonatomic, retain) IBOutlet UIControl *a1Cat1Control,*a1Cat2Control,*a1Cat3Control,*a1Cat4Control,*a1Cat5Control,*a1Cat6Control, *a1StreetLampControl, *a1StreetLight1Control, *a1StreetLight2Control, *a1StreetLight3Control, *a1StreetLight4Control, *a1StreetLight5Control, *a1StreetLight6Control, *a1StreetLight7Control, *a1StreetLight8Control, *a1StreetLight9Control, *a1StreetLight10Control, *a1StreetLight11Control, *a1StreetLight12Control, *a1StreetLight13Control, *a1Puddle1Control, *a1Puddle2Control, *a1Puddle3Control, *a1Puddle4Control, *a1WhippedCream1Control, *a1WhippedCream2Control, *a1WhippedCream3Control, *a1WhippedCream4Control, *a1WhippedCream5Control, *a1WhippedCream6Control, *a1WhippedCream7Control, *a1WhippedCream8Control, *a1WhippedCream9Control, *a1WindControl;
@property (nonatomic, retain) IBOutlet UIImageView *a1CatImageView, *a1StreetLampImageView, *a1StreetLight1ImageView, *a1StreetLight2ImageView, *a1StreetLight3ImageView, *a1StreetLight4ImageView, *a1StreetLight5ImageView, *a1StreetLight6ImageView, *a1StreetLight7ImageView, *a1StreetLight8ImageView, *a1StreetLight9ImageView, *a1StreetLight10ImageView, *a1StreetLight11ImageView, *a1StreetLight12ImageView, *a1StreetLight13ImageView, *a1Puddle1ImageView, *a1Puddle2ImageView, *a1Puddle3ImageView, *a1Puddle4ImageView, *a1WhippedCream1ImageView, *a1WhippedCream2ImageView, *a1WhippedCream3ImageView, *a1WhippedCream4ImageView, *a1WhippedCream5ImageView, *a1WhippedCream6ImageView, *a1WhippedCream7ImageView, *a1WhippedCream8ImageView, *a1WhippedCream9ImageView, *a1TubeImageView, *a1Almond1ImageView, *a1Almond2ImageView, *a1Almond3ImageView, *a1Almond4ImageView, *a1Almond5ImageView, *a1Almond6ImageView, *a1Almond7ImageView, *a1Almond8ImageView, *a1Almond9ImageView, *a1ShutterLeftImageView, *a1ShutterRightImageView, *a1Clothes1ImageView, *a1Clothes2ImageView, *a1Clothes3ImageView, *a1Clothes4ImageView;

- (IBAction)a1BackToMainMenu:(id)sender;
- (IBAction)a1RandomCatImage:(id)sender;
- (IBAction)a1StreetLampSelected:(id)sender;
- (IBAction)a1StreetLight1Selected:(id)sender;
- (IBAction)a1StreetLight2Selected:(id)sender;
- (IBAction)a1StreetLight3Selected:(id)sender;
- (IBAction)a1StreetLight4Selected:(id)sender;
- (IBAction)a1StreetLight5Selected:(id)sender;
- (IBAction)a1StreetLight6Selected:(id)sender;
- (IBAction)a1StreetLight7Selected:(id)sender;
- (IBAction)a1StreetLight8Selected:(id)sender;
- (IBAction)a1StreetLight9Selected:(id)sender;
- (IBAction)a1StreetLight10Selected:(id)sender;
- (IBAction)a1StreetLight11Selected:(id)sender;
- (IBAction)a1StreetLight12Selected:(id)sender;
- (IBAction)a1StreetLight13Selected:(id)sender;
- (IBAction)a1Puddle1Selected:(id)sender;
- (IBAction)a1Puddle2Selected:(id)sender;
- (IBAction)a1Puddle3Selected:(id)sender;
- (IBAction)a1Puddle4Selected:(id)sender;
- (IBAction)a1CakeSelected:(id)sender;
- (IBAction)a1WindControlSelected:(id)sender;
- (void) textAppear;


@end
