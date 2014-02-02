//
//  Screen11ViewController.m
//  KickOff
//
//  Created by Ferenc INKOVICS on 25/03/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//
#define BACKGROUND_RED_VALUE        0xFF
#define BACKGROUND_GREEN_VALUE      0xB7
#define BACKGROUND_BLUE_VALUE       0xEC

#define START_CENTER_INGREDIENT01   834,471
#define START_CENTER_INGREDIENT02   198,92
#define START_CENTER_INGREDIENT03   547,98
#define START_CENTER_INGREDIENT04   570,646
#define START_CENTER_INGREDIENT05   853,205
#define START_CENTER_INGREDIENT06   86,352
#define START_CENTER_INGREDIENT07   86,352

#define COOKINGPOT_ORIGINAL_SCALE       0.68
#define COOKINGPOT_SCALE_CHANGE         0.32/7

#define INGREDIENTS_ANIMATION_TIME      1.0
#define INGREDIENTS_BACK_TO_START_ANIMATION_TIME      0.2

#define PLATE_COMES_IN_TIME              2.0

#import "Screen11ViewController.h"
#import "ViewController.h"

@interface Screen11ViewController ()

@end

@implementation Screen11ViewController

@synthesize screen11CookingPotImageView, screen11CookingPotIngredient01ImageView, screen11Ingredient01ImageView, screen11Ingredient01TouchView, screen11CookingPotIngredient02ImageView, screen11CookingPotIngredient03ImageView, screen11CookingPotIngredient04ImageView, screen11CookingPotIngredient05ImageView, screen11CookingPotIngredient06ImageView, screen11Ingredient02ImageView, screen11Ingredient02TouchView, screen11Ingredient03ImageView, screen11Ingredient03TouchView, screen11Ingredient04ImageView, screen11Ingredient04TouchView, screen11Ingredient05ImageView, screen11Ingredient05TouchView, screen11Ingredient06ImageView, screen11Ingredient06TouchView, screen11PlateImageView, screen11Ingredient07ImageView, screen11Ingredient07TouchView;

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

-(IBAction)screen11BackToMainMenu:(id)sender;
{
    /*
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
     */
}

- (IBAction)screen11NextScreenButtonTouched:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)screen11PreviousScreenButtonTouched:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    
	NSUInteger touchCount = 0;
	for (UITouch *touch in touches)
	{
		CGPoint translatedPoint = [touch locationInView:self.view];

        if (CGRectContainsPoint(screen11Ingredient01TouchView.frame, translatedPoint))
        {
            firstTranslatedPoint=translatedPoint;
            movingImageView=screen11Ingredient01ImageView;
            movingTouchView=screen11Ingredient01TouchView;
            movingTouchViewStartCenter=movingTouchView.center;
            movingCookingPotImageView=nil;
        }

        if (CGRectContainsPoint(screen11Ingredient02TouchView.frame, translatedPoint))
        {
            firstTranslatedPoint=translatedPoint;
            movingImageView=screen11Ingredient02ImageView;
            movingTouchView=screen11Ingredient02TouchView;
            movingTouchViewStartCenter=movingTouchView.center;
            movingCookingPotImageView=screen11CookingPotIngredient06ImageView;
        }
        
        if (CGRectContainsPoint(screen11Ingredient03TouchView.frame, translatedPoint))
        {
            firstTranslatedPoint=translatedPoint;
            movingImageView=screen11Ingredient03ImageView;
            movingTouchView=screen11Ingredient03TouchView;
            movingTouchViewStartCenter=movingTouchView.center;
            movingCookingPotImageView=screen11CookingPotIngredient02ImageView;
        }
        
        if (CGRectContainsPoint(screen11Ingredient04TouchView.frame, translatedPoint))
        {
            firstTranslatedPoint=translatedPoint;
            movingImageView=screen11Ingredient04ImageView;
            movingTouchView=screen11Ingredient04TouchView;
            movingTouchViewStartCenter=movingTouchView.center;
            movingCookingPotImageView=screen11CookingPotIngredient01ImageView;
        }
        
        if (CGRectContainsPoint(screen11Ingredient05TouchView.frame, translatedPoint))
        {
            firstTranslatedPoint=translatedPoint;
            movingImageView=screen11Ingredient05ImageView;
            movingTouchView=screen11Ingredient05TouchView;
            movingTouchViewStartCenter=movingTouchView.center;
            movingCookingPotImageView=screen11CookingPotIngredient05ImageView;
        }
        
        if (CGRectContainsPoint(screen11Ingredient06TouchView.frame, translatedPoint))
        {
            firstTranslatedPoint=translatedPoint;
            movingImageView=screen11Ingredient06ImageView;
            movingTouchView=screen11Ingredient06TouchView;
            movingTouchViewStartCenter=movingTouchView.center;
            movingCookingPotImageView=screen11CookingPotIngredient03ImageView;
        }
        
        if (CGRectContainsPoint(screen11Ingredient07TouchView.frame, translatedPoint))
        {
            firstTranslatedPoint=translatedPoint;
            movingImageView=screen11Ingredient07ImageView;
            movingTouchView=screen11Ingredient07TouchView;
            movingTouchViewStartCenter=movingTouchView.center;
            movingCookingPotImageView=screen11CookingPotIngredient04ImageView;
        }
        
		touchCount++;
	}
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
    
	NSUInteger touchCount = 0;
	for (UITouch *touch in touches)
	{
		CGPoint translatedPoint = [touch locationInView:self.view];
        
        if (movingImageView!=nil)
        {
            CGPoint newCenter = translatedPoint;
            CGPoint startCenter=CGPointMake(512,374);
            newCenter.x=newCenter.x-firstTranslatedPoint.x+startCenter.x;
            newCenter.y=newCenter.y-firstTranslatedPoint.y+startCenter.y;
            [movingImageView setCenter:newCenter];
            
            newCenter = translatedPoint;
            startCenter=movingTouchViewStartCenter;
            newCenter.x=newCenter.x-firstTranslatedPoint.x+startCenter.x;
            newCenter.y=newCenter.y-firstTranslatedPoint.y+startCenter.y;
            [movingTouchView setCenter:newCenter];
        }
		touchCount++;
	}
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
    NSUInteger touchCount = 0;
	for (UITouch *touch in touches)
	{
//		CGPoint translatedPoint = [touch locationInView:self.view];
        
        if (movingImageView!=nil)
        {
            if (CGRectContainsRect(screen11CookingPotImageView.frame, movingTouchView.frame))
            {
                ingredientsRemained--;
                [movingTouchView setCenter:CGPointMake(1000, 1000)];
                CGAffineTransform newTransform = CGAffineTransformMakeScale(0.2, 0.2);
                [UIView animateWithDuration:INGREDIENTS_ANIMATION_TIME animations:
                 ^{
                     [movingImageView setAlpha:0];
                     [movingCookingPotImageView setAlpha:1];
                     [movingImageView setTransform:newTransform];
                     [movingImageView setCenter:screen11CookingPotImageView.center];
                 }];
                cookingPotActualScale=cookingPotActualScale+COOKINGPOT_SCALE_CHANGE;
                [self setCookingPotScale];
                if (ingredientsRemained==0)
                {
                    [self plateComesIn];
                }
            }
            else
            {
                [UIView animateWithDuration:INGREDIENTS_BACK_TO_START_ANIMATION_TIME animations:
                 ^{
                     [movingImageView setCenter:CGPointMake(512,374)];
                     [movingTouchView setCenter:movingTouchViewStartCenter];
                 }];
            }
        }
		touchCount++;
	}
    movingImageView=nil;
    movingTouchView=nil;    
}

-(void)setBackgroundColorForView;
{
    CGFloat nRed=BACKGROUND_RED_VALUE/255.0;
    CGFloat nBlue=BACKGROUND_BLUE_VALUE/255.0;
    CGFloat nGreen=BACKGROUND_GREEN_VALUE/255.0;
    UIColor *myColor=[[UIColor alloc]initWithRed:nRed green:nBlue blue:nGreen alpha:1];
    [self.view setBackgroundColor:myColor];
    myColor=nil;

}

-(void)setFirstCookingPotScale;
{
    cookingPotActualScale=COOKINGPOT_ORIGINAL_SCALE;

    CGAffineTransform newTransform = CGAffineTransformMakeScale(cookingPotActualScale, cookingPotActualScale);
    [screen11CookingPotImageView setTransform:newTransform];
    [screen11CookingPotIngredient01ImageView setTransform:newTransform];
    [screen11CookingPotIngredient02ImageView setTransform:newTransform];
    [screen11CookingPotIngredient03ImageView setTransform:newTransform];
    [screen11CookingPotIngredient04ImageView setTransform:newTransform];
    [screen11CookingPotIngredient05ImageView setTransform:newTransform];
    [screen11CookingPotIngredient06ImageView setTransform:newTransform];
}

-(void)setCookingPotScale;
{
    CGAffineTransform newTransform = CGAffineTransformMakeScale(cookingPotActualScale, cookingPotActualScale);
    [UIView animateWithDuration:INGREDIENTS_ANIMATION_TIME animations:^
    {
        [screen11CookingPotImageView setTransform:newTransform];
        [screen11CookingPotIngredient01ImageView setTransform:newTransform];
        [screen11CookingPotIngredient02ImageView setTransform:newTransform];
        [screen11CookingPotIngredient03ImageView setTransform:newTransform];
        [screen11CookingPotIngredient04ImageView setTransform:newTransform];
        [screen11CookingPotIngredient05ImageView setTransform:newTransform];
        [screen11CookingPotIngredient06ImageView setTransform:newTransform];
    }];
}

-(void)plateComesIn;
{
    [UIView animateWithDuration:PLATE_COMES_IN_TIME animations:^
     {
         [screen11PlateImageView setCenter:CGPointMake(512, 376)];
     }];
}

-(void)startBackgroundMusic;
{
    //set the Music for intro then start playing
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"003_ketten usznak" ofType:@"mp3"];
	backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:backgroundMusicPath] error:NULL];
	backgroundMusic.delegate = self;
	[backgroundMusic setVolume:1.0];
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
    // Do any additional setup after loading the view from its nib.
    
    [self setBackgroundColorForView];
    [self setFirstCookingPotScale];
    ingredientsRemained=7;
    
    [self startBackgroundMusic];
}

- (void)viewWillDisappear:(BOOL)animated;
{
    [self stopMusicAndSfx];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight)) {
        return YES;
    } else {
        return FALSE;
    }
}
@end
