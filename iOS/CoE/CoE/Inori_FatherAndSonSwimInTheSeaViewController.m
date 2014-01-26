//
//  Inori_FatherAndSonSwimInTheSeaViewController.m
//  CoE
//
//  Created by Ferenc INKOVICS on 25/01/14.
//  Copyright (c) 2014 No company - private person. All rights reserved.
//

#define PERSON_TURN_IN_DEGREE (10.0/180*M_PI_2)

#import "Inori_FatherAndSonSwimInTheSeaViewController.h"
#import "ViewController.h"

@interface Inori_FatherAndSonSwimInTheSeaViewController ()

@end

@implementation Inori_FatherAndSonSwimInTheSeaViewController

@synthesize fatherControl, fatherImageView, inoriControl, inoriImageView;

-(void)goToNextScreen;
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (IBAction)NextScreenControlTapped:(id) sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    [self goToNextScreen];
}

- (IBAction)PreviousScreenControlTapped:(id) sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)musicControlTapped;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [backgroundMusic setVolume:0.0];
        
        viewContoller.musicIsOn=FALSE;
    }
    else
    {
        [backgroundMusic setVolume:1.0];
        
        viewContoller.musicIsOn=TRUE;
    }
    viewContoller = nil;
}

- (IBAction)fishImageViewTapped:(UITapGestureRecognizer *)sender
{
    UIImageView *fishImageView = (UIImageView*)sender.view;
    
    if ((arc4random()%2)==0)
    {
        [UIView animateWithDuration:1.0 animations:^{
            CGPoint newCentre = CGPointMake(fishImageView.center.x+((arc4random()%100)+50), fishImageView.center.y+((arc4random()%100)+50));
            [fishImageView setCenter:newCentre];
            [fishImageView setAlpha:0.0];
        }];
    }
    else
    {
        [UIView animateWithDuration:1.0 animations:^{
            CGAffineTransform newTransform = CGAffineTransformMakeScale(1.5, 1.5);
            [fishImageView setTransform:newTransform];
            [fishImageView setAlpha:0.0];
        }];
    }
    fishImageView=nil;
}

- (IBAction)inoriOrFatherImageViewTapped:(UITapGestureRecognizer *)sender;
{
    UIImageView *personImageView;
    UIControl *tappedControl = (UIControl*)sender.view;
    
    if (tappedControl==fatherControl)
    {
        personImageView = fatherImageView;
    }
    else
        if (tappedControl==inoriControl)
        {
            personImageView = inoriImageView;
        }
    
    if (tappedControl.alpha == 1.0)
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGFloat newRotation = PERSON_TURN_IN_DEGREE;
                         CGAffineTransform newTransform=CGAffineTransformMakeRotation(newRotation);
                         [personImageView setTransform:newTransform];
                         [tappedControl setAlpha:0.0];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:1.0
                                          animations:^{
                                              CGFloat newRotation = -2*PERSON_TURN_IN_DEGREE;
                                              CGAffineTransform newTransform=CGAffineTransformMakeRotation(newRotation);
                                              [personImageView setTransform:newTransform];}
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   CGFloat newRotation = 0;
                                                                   CGAffineTransform newTransform=CGAffineTransformMakeRotation(newRotation);
                                                                   [personImageView setTransform:newTransform];
                                                                   [tappedControl setAlpha:1.0];
                                                               }
                                               ];}
                          ];}
     ];
    personImageView = nil;
}

-(void)startBackgroundMusic;
{
    //set the Music for intro then start playing
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"002_Atm_tengermadarszel" ofType:@"mp3"];
	backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:backgroundMusicPath] error:NULL];
	backgroundMusic.delegate = self;
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [backgroundMusic setVolume:1.0];
    }
    else
    {
        [backgroundMusic setVolume:0.0];
    }
    
	[backgroundMusic setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
    [backgroundMusic play];
    
    
}

-(void)stopMusicAndSfx;
{
    [backgroundMusic stop];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self startBackgroundMusic];
}

-(void)viewWillDisappear:(BOOL)animated;
{
    [self stopMusicAndSfx];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
