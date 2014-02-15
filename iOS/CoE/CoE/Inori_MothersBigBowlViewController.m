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

#define HINT_TIME                                       1.0

#import "Inori_MothersBigBowlViewController.h"
#import "ViewController.h"

@interface Inori_MothersBigBowlViewController ()

@end

@implementation Inori_MothersBigBowlViewController

@synthesize screen11CookingPotImageView, screen11CookingPotIngredient01ImageView, screen11Ingredient01ImageView, screen11Ingredient01TouchView, screen11CookingPotIngredient02ImageView, screen11CookingPotIngredient03ImageView, screen11CookingPotIngredient04ImageView, screen11CookingPotIngredient05ImageView, screen11CookingPotIngredient06ImageView, screen11Ingredient02ImageView, screen11Ingredient02TouchView, screen11Ingredient03ImageView, screen11Ingredient03TouchView, screen11Ingredient04ImageView, screen11Ingredient04TouchView, screen11Ingredient05ImageView, screen11Ingredient05TouchView, screen11Ingredient06ImageView, screen11Ingredient06TouchView, screen11PlateImageView, screen11Ingredient07ImageView, screen11Ingredient07TouchView, screen11HintLayerImageView, screen11MenuImageView;

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

/*
-(IBAction)screen11BackToMainMenu:(id)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
}
 */

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

            [self startSfxForIngredient:movingImageView];
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
                [self startSfxForGrowing:movingImageView];
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
                    [self allInteractionFound];
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

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
{
    if (ingredientsRemained==0)
    {
        sfxPlateComeIn=[self startsfx:sfxPlateComeIn named:@"005_sonkas_mandala_thEnd"];
        ingredientsRemained=-1;
    }
    
}

- (void)allInteractionFound;
{
    if (ingredientsRemained==0)
    {
        self.screen11MenuImageView.image=nil;
        [self.screen11MenuImageView setImage:[UIImage imageNamed:@"menu_set-top-g.png"]];
    }
}

- (IBAction)screen11MusicButtonTapped:(UITapGestureRecognizer *) sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [backgroundMusic setVolume:0.0];
        [sfxPotGrowing1 setVolume:0.0];
        [sfxPotGrowing2 setVolume:0.0];
        [sfxPotGrowing3 setVolume:0.0];
        [sfxPotGrowing4 setVolume:0.0];
        [sfxPotGrowing5 setVolume:0.0];
        [sfxPotGrowing6 setVolume:0.0];
        [sfxPotGrowing7 setVolume:0.0];
        [sfxIngredient1 setVolume:0.0];
        [sfxIngredient2 setVolume:0.0];
        [sfxIngredient3 setVolume:0.0];
        [sfxIngredient4 setVolume:0.0];
        [sfxIngredient5 setVolume:0.0];
        [sfxIngredient6 setVolume:0.0];
        [sfxIngredient7 setVolume:0.0];
        [narration setVolume:0.0];
        
        viewContoller.musicIsOn=FALSE;
    }
    else
    {
        [backgroundMusic setVolume:1.0];
        [sfxPotGrowing1 setVolume:1.0];
        [sfxPotGrowing2 setVolume:1.0];
        [sfxPotGrowing3 setVolume:1.0];
        [sfxPotGrowing4 setVolume:1.0];
        [sfxPotGrowing5 setVolume:1.0];
        [sfxPotGrowing6 setVolume:1.0];
        [sfxPotGrowing7 setVolume:1.0];
        [sfxIngredient1 setVolume:1.0];
        [sfxIngredient2 setVolume:1.0];
        [sfxIngredient3 setVolume:1.0];
        [sfxIngredient4 setVolume:1.0];
        [sfxIngredient5 setVolume:1.0];
        [sfxIngredient6 setVolume:1.0];
        [sfxIngredient7 setVolume:1.0];
        [narration setVolume:1.0];
        
        viewContoller.musicIsOn=TRUE;
    }
    viewContoller = nil;
}

-(void)startSfxForIngredient:(UIImageView *)ingredient;
{
    if (ingredient==screen11Ingredient01ImageView)
    {
        sfxIngredient1=[self startsfx:sfxIngredient1 named:@"005_nov1"];
    }
    if (ingredient==screen11Ingredient02ImageView)
    {
        sfxIngredient2=[self startsfx:sfxIngredient2 named:@"005_nov2"];
    }
    if (ingredient==screen11Ingredient03ImageView)
    {
        sfxIngredient3=[self startsfx:sfxIngredient3 named:@"005_nov3"];
    }
    if (ingredient==screen11Ingredient04ImageView)
    {
        sfxIngredient4=[self startsfx:sfxIngredient4 named:@"005_nov4"];
    }
    if (ingredient==screen11Ingredient05ImageView)
    {
        sfxIngredient5=[self startsfx:sfxIngredient5 named:@"005_nov5"];
    }
    if (ingredient==screen11Ingredient06ImageView)
    {
        sfxIngredient6=[self startsfx:sfxIngredient6 named:@"005_nov6"];
    }
    if (ingredient==screen11Ingredient07ImageView)
    {
        sfxIngredient7=[self startsfx:sfxIngredient7 named:@"005_nov7"];
    }
}

-(void)startSfxForGrowing:(UIImageView *)ingredient;
{
    if (ingredient==screen11Ingredient01ImageView)
    {
        sfxPotGrowing1=[self startsfx:sfxPotGrowing1 named:@"005_edeny_novekszik_1OK"];
    }
    if (ingredient==screen11Ingredient02ImageView)
    {
        sfxPotGrowing2=[self startsfx:sfxPotGrowing2 named:@"005_edeny_novekszik_2OK"];
    }
    if (ingredient==screen11Ingredient03ImageView)
    {
        sfxPotGrowing3=[self startsfx:sfxPotGrowing3 named:@"005_edeny_novekszik_3OK"];
    }
    if (ingredient==screen11Ingredient04ImageView)
    {
        sfxPotGrowing4=[self startsfx:sfxPotGrowing4 named:@"005_edeny_novekszik_4OK"];
    }
    if (ingredient==screen11Ingredient05ImageView)
    {
        sfxPotGrowing5=[self startsfx:sfxPotGrowing5 named:@"005_edeny_novekszik_5OK"];
    }
    if (ingredient==screen11Ingredient06ImageView)
    {
        sfxPotGrowing6=[self startsfx:sfxPotGrowing6 named:@"005_edeny_novekszik_6OK"];
    }
    if (ingredient==screen11Ingredient07ImageView)
    {
        sfxPotGrowing7=[self startsfx:sfxPotGrowing7 named:@"005_edeny_novekszik_7OK"];
    }
}

- (AVAudioPlayer *)startsfx:(AVAudioPlayer *)audioplayer named:(NSString *)sfxFileName;
{
    //set the SFX then start playing
    if (audioplayer==nil)
    {
        NSString *audiplayerSFXPath = [[NSBundle mainBundle] pathForResource:sfxFileName ofType:@"mp3"];
        audioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audiplayerSFXPath] error:NULL];
        audioplayer.delegate = self;
        [audioplayer setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
        
        audiplayerSFXPath= nil;
    }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [audioplayer setVolume:1.0];
    }
    else
    {
        [audioplayer setVolume:0.0];
    }
    
    if (![audioplayer isPlaying])
    {
        [audioplayer play];
    }
    
    viewContoller=nil;
    
    return audioplayer;
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

- (IBAction)screen11HintButtonTapped:(UITapGestureRecognizer *)sender;
{
    if (screen11HintLayerImageView.alpha==0.0)
    {
        //        [hintLayerImageView removeFromSuperview];
        //        [self.view addSubview:hintLayerImageView];
        [UIView animateWithDuration:HINT_TIME animations:^{
            [self.screen11HintLayerImageView setAlpha:1.0];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:HINT_TIME animations:^{
                [self.screen11HintLayerImageView setAlpha:0.01];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:HINT_TIME animations:^{
                    [self.screen11HintLayerImageView setAlpha:1.0];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:HINT_TIME animations:^{
                        [self.screen11HintLayerImageView setAlpha:0.0];
                    }];
                }];
            }];
        }];
    }
}

- (IBAction)screen11NarrationButtonTapped:(UITapGestureRecognizer *)sender;
{
    if (narration==nil)
    {
        [self startNarration];
    } else
    {
        if ([narration isPlaying])
        {
            [self stopNarration];
        } else {
            [self startNarration];
        }
    }
}

-(void)startNarration;
{
    //set the Music for intro then start playing
    if (narration==nil)
    {
        ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
        NSString *screenName = [NSString stringWithFormat:@"%i:", viewContoller.nextViewController ];
        viewContoller = nil;
        
        //name the file to read
        NSString* aPath = [[NSBundle mainBundle] pathForResource:@"ScreenNarrations" ofType:@"txt"];
        //pull the content from the file into memory
        NSData* data = [NSData dataWithContentsOfFile:aPath];
        //convert the bytes from the file into a string
        NSString* string = [[NSString alloc] initWithBytes:[data bytes]
                                                    length:[data length]
                                                  encoding:NSUTF8StringEncoding];
        //split the string around newline characters to create an array
        NSString* delimiter = @"\n";
        NSArray* lines = [string componentsSeparatedByString:delimiter];
        string = nil;
        
        //find the screen identifier
        int i=0;
        while ((i!=[lines count])&&(![screenName isEqual:[lines objectAtIndex:i]]))
        {
            i++;
        }
        
        NSString *narrationFileName = [lines objectAtIndex:i+1];
        NSString *narrationFileExt = [lines objectAtIndex:i+1];
        narrationFileName = [narrationFileName substringToIndex:[narrationFileName rangeOfString:@"."].location];
        narrationFileExt = [narrationFileExt substringFromIndex:[narrationFileExt rangeOfString:@"."].location+1];
        
        NSString *narrationPath = [[NSBundle mainBundle] pathForResource:narrationFileName ofType:narrationFileExt];
        narration = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:narrationPath] error:NULL];
        narration.delegate = self;
        [narration setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
        narrationFileName=nil;
        narrationFileExt=nil;
        narrationPath = nil;
        lines=nil;
    } else
    {
        [narration setCurrentTime:0];
    }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [narration setVolume:1.0];
    }
    else
    {
        [narration setVolume:0.0];
    }
    
    [narration play];
    
    viewContoller = nil;
    viewContoller = nil;
}

- (void)stopNarration;
{
    [narration stop];
}

- (void)loadImages;
{
    NSString* imagePath;
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_fazek-0" ofType:@"png"];
    [screen11CookingPotImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];

    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_hozzavalo-1" ofType:@"png"];
    [screen11Ingredient01ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_hozzavalo-2" ofType:@"png"];
    [screen11Ingredient02ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_hozzavalo-3" ofType:@"png"];
    [screen11Ingredient03ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_hozzavalo-4" ofType:@"png"];
    [screen11Ingredient04ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_hozzavalo-5" ofType:@"png"];
    [screen11Ingredient05ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_hozzavalo-6" ofType:@"png"];
    [screen11Ingredient06ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_hozzavalo-7" ofType:@"png"];
    [screen11Ingredient07ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_fazek-1" ofType:@"png"];
    [screen11CookingPotIngredient01ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_fazek-2" ofType:@"png"];
    [screen11CookingPotIngredient02ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_fazek-3" ofType:@"png"];
    [screen11CookingPotIngredient03ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_fazek-4" ofType:@"png"];
    [screen11CookingPotIngredient04ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_fazek-5" ofType:@"png"];
    [screen11CookingPotIngredient05ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_fazek-6" ofType:@"png"];
    [screen11CookingPotIngredient06ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"11_1k_tanyer" ofType:@"png"];
    [screen11PlateImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
}

-(void)startBackgroundMusic;
{
    //set the Music for intro then start playing
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"005_Marketok" ofType:@"mp3"];
	backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:backgroundMusicPath] error:NULL];
	backgroundMusic.delegate = self;
	[backgroundMusic setVolume:1.0];
	[backgroundMusic setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
    [backgroundMusic play];
}

-(void)stopMusicAndSfx;
{
    [backgroundMusic stop];
    [sfxPotGrowing1 stop];
    [sfxPotGrowing2 stop];
    [sfxPotGrowing3 stop];
    [sfxPotGrowing4 stop];
    [sfxPotGrowing5 stop];
    [sfxPotGrowing6 stop];
    [sfxPotGrowing7 stop];
    [sfxIngredient1 stop];
    [sfxIngredient2 stop];
    [sfxIngredient3 stop];
    [sfxIngredient4 stop];
    [sfxIngredient5 stop];
    [sfxIngredient6 stop];
    [sfxIngredient7 stop];
    [narration stop];
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
    
    [self loadImages];
    
    [self setBackgroundColorForView];
    [self setFirstCookingPotScale];
    ingredientsRemained=7;
    
    [self startBackgroundMusic];
}

- (void)viewDidDisappear:(BOOL)animated;
{
    [self stopMusicAndSfx];
    
    backgroundMusic.delegate=nil;
    narration.delegate=nil;
    sfxPotGrowing1.delegate=nil;
    sfxPotGrowing2.delegate=nil;
    sfxPotGrowing3.delegate=nil;
    sfxPotGrowing4.delegate=nil;
    sfxPotGrowing5.delegate=nil;
    sfxPotGrowing6.delegate=nil;
    sfxPotGrowing7.delegate=nil;
    sfxIngredient1.delegate=nil;
    sfxIngredient2.delegate=nil;
    sfxIngredient3.delegate=nil;
    sfxIngredient4.delegate=nil;
    sfxIngredient5.delegate=nil;
    sfxIngredient6.delegate=nil;
    sfxIngredient7.delegate=nil;
    
    backgroundMusic=nil;
    narration=nil;
    sfxPotGrowing1=nil;
    sfxPotGrowing2=nil;
    sfxPotGrowing3=nil;
    sfxPotGrowing4=nil;
    sfxPotGrowing5=nil;
    sfxPotGrowing6=nil;
    sfxPotGrowing7=nil;
    sfxIngredient1=nil;
    sfxIngredient2=nil;
    sfxIngredient3=nil;
    sfxIngredient4=nil;
    sfxIngredient5=nil;
    sfxIngredient6=nil;
    sfxIngredient7=nil;
    
    [self.view removeFromSuperview];
    self.view = nil;
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
