//
//  screen12ViewController.h
//  KickOff
//
//  Created by INKOVICS Ferenc on 18/03/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GiantJellyfishArrivedViewController : UIViewController<UIGestureRecognizerDelegate, AVAudioPlayerDelegate>{
    NSTimer *movingWavesTimer, *bigMedusaAppearsTimer, *bigMedusaPulseTimer, *bigMedusaArmsMoveTimer, *fishesMovingTimer, *bigMedusaSlowsDownTimer, *continuousKelpMovementTimer, *medusasComeInTimer;
    int movingWavesClock, bigMedusaAppearsClock, bigMedusaPulseClock, bigMedusaPulseClockChange, bigMedusaArmsMoveClock, fishesMovingClock, bigMedusaSlowsDownClock, continuousKelpMovementClock;
    CGPoint previousTranslatedPoint, bigMedusaSlowsDownValues;
    CGFloat bigMedusaRotation, fish1Orig, fish2Orig, medusasComeInClock, medusa1ComeInClock, medusa2ComeInClock, medusa3ComeInClock, medusa4ComeInClock, medusa5ComeInClock, medusa6ComeInClock, medusa7ComeInClock, medusa8ComeInClock;
    BOOL isBigMedusaPulse, medusaPulseDirection, isBigMedusaMoving, isBigMedusaSlowsDown;
    CGAffineTransform previousTransformMatrix;
    NSMutableArray *fishes1Array, *fishes2Array, *fishes1SpeedArray, *fishes2SpeedArray;
    
    AVAudioPlayer *backgroundMusic, *narration, *sfxFishesMoving, *sfxFishReached1, *sfxFishReached2, *sfxFishReached3, *sfxFishReached4, *sfxFishReached5, *sfxMedusaPulsing;
    
    NSMutableArray *sfxMedusaReachesFishArray, *sfxMedusasComeInArray, *timingOfMedusasArray;
}

@property (nonatomic, weak) IBOutlet UIImageView *screen12BackgroundImageView, *screen12WavesImageView, *screen12Kelp1ImageView, *screen12Kelp2ImageView, *screen12Kelp3ImageView, *screen12Kelp4ImageView, *screen12Kelp5ImageView, *screen12Kelp6ImageView, *screen12BigMedusaImageView, *screen12BigMedusaArm1ImageView, *screen12BigMedusaArm2ImageView, *screen12BigMedusaArm3ImageView, *screen12BigMedusaArm4ImageView, *screen12BackgroundMedusa1ImageView, *screen12BackgroundMedusa2ImageView, *screen12BackgroundMedusa3ImageView, *screen12BackgroundMedusa4ImageView, *screen12BackgroundMedusa5ImageView, *screen12BackgroundMedusa6ImageView, *screen12BackgroundMedusa7ImageView, *screen12BackgroundMedusa8ImageView, *hintLayerImageView, *screen12MenuImageView;

- (UIImage*) imageWithBrightness:(CGFloat)brightnessFactor;
- (void)screen12BigMedusaAppears;
- (void)screen12BigMedusaMoveToCoordinate:(CGPoint)newCoordinate;
- (void)screen12BackgroundMedusasComeIn;
- (void)screen12CreateFishes;
-(CGPoint)rotatePoint:(CGPoint)centre around:(CGPoint)point withDegree:(float)degree;
- (void) screen12IsBigMedusaReachesFish;
- (UIImageView *)screen12CreateWhiteKelpOf:(UIImageView *)kelpImageView;
- (IBAction)screen12NextScreenButtonTouched:(id) sender;
- (IBAction)screen12PreviousScreenButtonTouched:(id)sender;
- (IBAction)screen12HintButtonTapped:(UITapGestureRecognizer *)sender;
- (IBAction)screen12NarrationButtonTapped:(UITapGestureRecognizer *)sender;
- (IBAction)screen12MusicButtonTapped:(UITapGestureRecognizer *) sender;

@end
