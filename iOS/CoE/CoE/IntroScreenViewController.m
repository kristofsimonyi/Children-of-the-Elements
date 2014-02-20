//
//  IntroScreenViewController.m
//  CoE
//
//  Created by Ferenc INKOVICS on 15/12/13.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//
#define MUSIC_VOLUME = 1.00

#import "IntroScreenViewController.h"
#import "ViewController.h"

@interface IntroScreenViewController ()

@end

@implementation IntroScreenViewController

@synthesize continueLabel;

- (IBAction)screenTapped:(id)sender
{
    [introMusic stop];
    introMusic.delegate=nil;
    introMusic=nil;
    
    //After tapping this screen it is time to change the rootViewController in NavigationController to ViewController that is on the MainStoryboard
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:[self.navigationController.viewControllers mutableCopy]];

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ViewController *mainViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    mainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    //For the continuous music we need to pass the current introMusic as backgroundMusic of ViewController.
    mainViewController.nextViewController=101;
    mainViewController.musicIsOn=YES;

    [viewControllers replaceObjectAtIndex:0 withObject:mainViewController];
    [self.navigationController setViewControllers:viewControllers];
}

-(void)startMusic;
{
    //set the Music for intro then start playing
	NSString *introMusicPath = [[NSBundle mainBundle] pathForResource:@"The story of the Sea_OK" ofType:@"mp3"];
	introMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:introMusicPath] error:NULL];
	introMusic.delegate = self;
	[introMusic setVolume:1.0];
	[introMusic setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
    [introMusic play];
}

-(void)stopMusic;
{
    [introMusic stop];
}

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight)) {
        return YES;
    } else {
        return FALSE;
    }
}

-(void)viewDidDisappear:(BOOL)animated;
{
    [self.view removeFromSuperview];
    self.view=nil;
}

- (void)viewDidLoad;
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //start background music
    [self startMusic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if ([self.view window] == nil)
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        self.view = nil;
    }
}

@end
