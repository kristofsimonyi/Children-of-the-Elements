//
//  screen12ViewController.m
//  KickOff
//
//  Created by INKOVICS Ferenc on 18/03/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

#import "Screen12ViewController.h"
#import "ViewController.h"
/*
 #define FISHES_1_CENTER_X 800
 #define FISHES_1_CENTER_Y -200
 #define FISHES_1_RADIUS 500
 #define FISHES_1_RADIUS2 420
 #define MAX_FISHES_1 30
 #define FISHES_2_CENTER_X 512
 #define FISHES_2_CENTER_Y 378
 #define FISHES_2_RADIUS 300
 #define FISHES_2_RADIUS2 330
 #define MAX_FISHES_2 30
*/
///*
 #define FISHES_1_CENTER_X  800
 #define FISHES_1_CENTER_Y  -200
 #define FISHES_1_RADIUS    500
 #define FISHES_1_RADIUS2   300
 #define MAX_FISHES_1       40
 #define FISHES_2_CENTER_X  330
 #define FISHES_2_CENTER_Y  1270
 #define FISHES_2_RADIUS    900
 #define FISHES_2_RADIUS2   700
 #define MAX_FISHES_2       60
 #define FISHES1_MIN_SPEED     5
 #define FISHES1_MAX_SPEED     13
 #define FISHES2_MIN_SPEED     3
 #define FISHES2_MAX_SPEED     7
//*/
#define BIG_MEDUSA_MAX_ROTATION_AT_A_TIME   2.0
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

@implementation Screen12ViewController

@synthesize screen12BackToMainMenuImageView, screen12WavesImageView, screen12Kelp1ImageView, screen12Kelp2ImageView, screen12Kelp3ImageView, screen12Kelp4ImageView, screen12Kelp5ImageView, screen12Kelp6ImageView, screen12BigMedusaImageView,screen12BigMedusaArm1ImageView, screen12BigMedusaArm2ImageView, screen12BigMedusaArm3ImageView, screen12BigMedusaArm4ImageView, screen12BackgroundMedusa1ImageView, screen12BackgroundMedusa2ImageView, screen12BackgroundMedusa3ImageView, screen12BackgroundMedusa4ImageView, screen12BackgroundMedusa5ImageView, screen12BackgroundMedusa6ImageView, screen12BackgroundMedusa7ImageView, screen12BackgroundMedusa8ImageView;

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

- (void)screen12BackToMainMenu;
{
    /*
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
     */
}

- (IBAction)screen12NextScreenButtonTouched:(id) sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)screen12PreviousScreenButtonTouched:(id)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
- (void) textAppear;
{
    for (UIView *view in screen12StoryTextView.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel *newLabel;
    NSString *string;
    
    UILabel *origLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, 10, 12)];
    [origLabel setText:@" abcd efgh ijkl mnopqr stuvxyz valaminek jonnie kell..."];
    
    CGAffineTransform previousTransformMatrixForText;
    previousTransformMatrixForText = [origLabel transform];
    
    CGAffineTransform newTransform = CGAffineTransformRotate(previousTransformMatrixForText,M_PI/2.00);
    
    for (int i=0; i<15; i++) 
        for (int j=0; j<30; j++) 
        {
            newLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*20-20, j*20-20, 20, 20)];
            string = [NSString stringWithFormat:@"%c",[origLabel.text characterAtIndex:arc4random()%30+1]];
            [newLabel setText:string];
            [screen12StoryTextView addSubview:newLabel]; 
            [newLabel setAlpha:0];
            [newLabel setTransform:newTransform];
            [newLabel setBackgroundColor:[UIColor clearColor]];
            [newLabel setTextAlignment:NSTextAlignmentRight];
            
            [UIView animateWithDuration:((i%3)*0.5+0.5)
                                  delay: 3+arc4random()%5*0.5
                                options: UIViewAnimationOptionCurveEaseIn
                             animations:^
             {
                 [newLabel setTransform:previousTransformMatrixForText];
                 [newLabel setAlpha:1];
                 [newLabel setTextColor:[UIColor whiteColor]];
                 [newLabel setCenter:CGPointMake(newLabel.center.x+20,newLabel.center.y+40)];
             }
                             completion:nil];
            
            
        }
}
*/

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    if ([self.view window] == nil)
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        self.view = nil;
    }
}

#pragma mark - View lifecycle

- (void)movingWavesAction
{
    movingWavesClock=movingWavesClock+1;
    if (movingWavesClock==360) 
    {
        movingWavesClock=0;
    }
    [screen12WavesImageView setCenter:CGPointMake((20.00*sin(M_PI/180*movingWavesClock*2))+512,(20.00*cos(M_PI/180*movingWavesClock))+374)];
}

- (void)screen12BigMedusaAppears;
{
    [self screen12BigMedusaMoveToCoordinate:CGPointMake(-100, 200)];
    
    bigMedusaAppearsTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(screen12BigMedusaAppearsAction) userInfo:nil repeats:YES];
	[bigMedusaAppearsTimer fire];
    
    
}

- (void)screen12BigMedusaAppearsAction;
{
    bigMedusaAppearsClock=bigMedusaAppearsClock+1;
    if (bigMedusaAppearsClock >= 0) 
    {
        if ((bigMedusaAppearsClock>100)||(isBigMedusaMoving)||(isBigMedusaPulse)) 
        {
            [bigMedusaAppearsTimer invalidate];
        } 
        else
        {
            [self screen12BigMedusaMoveToCoordinate:CGPointMake(-100+bigMedusaAppearsClock, bigMedusaAppearsClock-40)];
        }
    }
}

- (void)screen12BigMedusaMoveToCoordinate:(CGPoint)newCoordinate;
{
    CGPoint movement = CGPointMake(newCoordinate.x-screen12BigMedusaImageView.center.x, newCoordinate.y-screen12BigMedusaImageView.center.y);
    [screen12BigMedusaArm1ImageView setCenter:CGPointMake(screen12BigMedusaArm1ImageView.center.x+movement.x, screen12BigMedusaArm1ImageView.center.y+movement.y)];
    [screen12BigMedusaArm2ImageView setCenter:CGPointMake(screen12BigMedusaArm2ImageView.center.x+movement.x, screen12BigMedusaArm2ImageView.center.y+movement.y)];
    [screen12BigMedusaArm3ImageView setCenter:CGPointMake(screen12BigMedusaArm3ImageView.center.x+movement.x, screen12BigMedusaArm3ImageView.center.y+movement.y)];
    [screen12BigMedusaArm4ImageView setCenter:CGPointMake(screen12BigMedusaArm4ImageView.center.x+movement.x, screen12BigMedusaArm4ImageView.center.y+movement.y)];
    [screen12BigMedusaImageView setCenter:CGPointMake(newCoordinate.x, newCoordinate.y)];    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    UITouch *touch = [touches anyObject];
    CGPoint translatedPoint = [touch locationInView:self.view];
    
    if ([bigMedusaSlowsDownTimer isValid]) {
        [bigMedusaSlowsDownTimer invalidate];
    }
    bigMedusaSlowsDownTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(bigMedusaSlowsDownAction) userInfo:nil repeats:YES];
    bigMedusaSlowsDownClock=0;
    [bigMedusaSlowsDownTimer fire];
    isBigMedusaSlowsDown = false;

    if (CGRectContainsPoint(screen12BigMedusaImageView.frame, translatedPoint)) 
    {
        isBigMedusaMoving = true;
        if (![bigMedusaPulseTimer isValid]) 
        {
            bigMedusaPulseTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screen12BigMedusaPulseAction) userInfo:nil repeats:YES];
            [bigMedusaPulseTimer fire];
            isBigMedusaPulse = TRUE;
            previousTranslatedPoint = translatedPoint;
        }
    }
    
    UIImageView *selectedKelp;
    
    if (CGRectContainsPoint(screen12BackToMainMenuImageView.frame, translatedPoint)) 
    {
        [self screen12BackToMainMenu];
    }
    
    if (CGRectContainsPoint(screen12Kelp1ImageView.frame, translatedPoint)) 
    {
        selectedKelp = screen12Kelp1ImageView;
        screen12Kelp1ImageView = [self screen12CreateWhiteKelpOf:screen12Kelp1ImageView];
    }
    if (CGRectContainsPoint(screen12Kelp2ImageView.frame, translatedPoint)) 
    {
        selectedKelp = screen12Kelp2ImageView;
    }
    if (CGRectContainsPoint(screen12Kelp3ImageView.frame, translatedPoint)) 
    {
        selectedKelp = screen12Kelp3ImageView;
    }
    if (CGRectContainsPoint(screen12Kelp4ImageView.frame, translatedPoint)) 
    {
        selectedKelp = screen12Kelp4ImageView;
    }
    if (CGRectContainsPoint(screen12Kelp5ImageView.frame, translatedPoint)) 
    {
        selectedKelp = screen12Kelp5ImageView;
    }
    if (CGRectContainsPoint(screen12Kelp6ImageView.frame, translatedPoint)) 
    {
        selectedKelp = screen12Kelp6ImageView;
    }
    if (selectedKelp != nil) 
    {
        [selectedKelp setAlpha:1];
        [UIView animateWithDuration:2.0
                              delay: 0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^
         {
             [selectedKelp setAlpha:0.4];
         }
                         completion:nil];
        
    }

}

- (UIImageView *)screen12CreateWhiteKelpOf:(UIImageView *)kelpImageView;
{
    UIImageView *whiteKelp;
    
    /*
     
    CGImageRef alphaImage = CGImageRetain(kelpImageView.image.CGImage);
    CGImageRef maskingImage;
    
    NSMutableData *data = [NSMutableData dataWithLength:400 * 400 * 1];
    // Create a bitmap context
    CGContextRef context = CGBitmapContextCreate([data mutableBytes], 400, 400, 8, 400, NULL, kCGImageAlphaOnly);
    // Set the blend mode to copy to avoid any alteration of the source data
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    // Draw the image to extract the alpha channel
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, 400, 400), alphaImage);
    // Now the alpha channel has been copied into our NSData object above, so discard the context and lets make an image mask.
    CGContextRelease(context);
    // Create a data provider for our data object (NSMutableData is tollfree bridged to CFMutableDataRef, which is compatible with CFDataRef)
    CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData((CFMutableDataRef)data);
    // Create our new mask image with the same size as the original image
    maskingImage = CGImageMaskCreate(400, 400, 8, 8, 400, dataProvider, NULL, YES);
    // And release the provider.
    CGDataProviderRelease(dataProvider);

    
    
    
    
    //Open up an ImageContext
    
	UIGraphicsBeginImageContext(kelpImageView.frame.size);
    context = UIGraphicsGetCurrentContext();
	
    
	// Quartz also allows you to mask to an image or image mask, the primary difference being
	// how the image data is interpreted. Note that you can use any image
	// When you use a regular image, the alpha channel is interpreted as the alpha values to use,
	// that is a 0.0 alpha indicates no pass and a 1.0 alpha indicates full pass.
    
    //save the current graphic state
	CGContextSaveGState(context);
    
    //set the image mask
	CGContextClipToMask(context, CGRectMake(0.0, 0.0, kelpImageView.frame.size.width, kelpImageView.frame.size.height), alphaImage);
    
    //set the image to draw
//        alphaImage2 = CGImageRetain(mysteryMachineImage.image.CGImage);
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, 100.0, 100.0), alphaImage);
    
    CGContextTranslateCTM(context, 0.0, kelpImageView.frame.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
    
	CGRect myImageArea = kelpImageView.frame;
	CGImageRef mySubimage = CGImageCreateWithImageInRect (alphaImage, myImageArea);
	CGRect myRect = CGRectMake(0, 0, kelpImageView.frame.size.width, kelpImageView.frame.size.height);
	CGContextDrawImage(context, myRect, mySubimage);
    
    // Restore the graphic state
    CGContextRestoreGState(context);
    
    
    
    
    
    //writing the result to the image
    kelpImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    //closing ImageContext
    UIGraphicsEndImageContext();
     
    */ 
    
    return whiteKelp;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    UITouch *touch = [touches anyObject];
    CGPoint translatedPoint = [touch locationInView:self.view];
        
    if (isBigMedusaMoving) 
    {
        [self screen12BigMedusaMoveToCoordinate:CGPointMake(screen12BigMedusaImageView.center.x+translatedPoint.x-previousTranslatedPoint.x,screen12BigMedusaImageView.center.y+translatedPoint.y-previousTranslatedPoint.y)];
        CGFloat newBigMedusaRotation =1.00*atanf((previousTranslatedPoint.y-translatedPoint.y)/(previousTranslatedPoint.x-translatedPoint.x));
        if (previousTranslatedPoint.x >= translatedPoint.x) {
            newBigMedusaRotation = newBigMedusaRotation - M_PI;
        }
        if (newBigMedusaRotation<=0) {
            newBigMedusaRotation=newBigMedusaRotation+2*M_PI;
        }

//        NSLog(@"new:%f actual:%f",RADIANS_TO_DEGREES(newBigMedusaRotation),RADIANS_TO_DEGREES(bigMedusaRotation));
        
        if (fabs(bigMedusaRotation-newBigMedusaRotation)>DEGREES_TO_RADIANS(BIG_MEDUSA_MAX_ROTATION_AT_A_TIME)) {
            if (fabs(bigMedusaRotation-newBigMedusaRotation)>M_PI) 
            {
                if (bigMedusaRotation<newBigMedusaRotation) {
                    bigMedusaRotation = bigMedusaRotation-DEGREES_TO_RADIANS(BIG_MEDUSA_MAX_ROTATION_AT_A_TIME);
                }
                else
                {
                    bigMedusaRotation = bigMedusaRotation+DEGREES_TO_RADIANS(BIG_MEDUSA_MAX_ROTATION_AT_A_TIME);
                }
                if (bigMedusaRotation>2*M_PI) {
                    bigMedusaRotation=bigMedusaRotation-2*M_PI;
                }
                if (bigMedusaRotation<0) {
                    bigMedusaRotation=bigMedusaRotation+2*M_PI;
                }
            } 
            else 
            {
                if (bigMedusaRotation<newBigMedusaRotation) {
                    bigMedusaRotation = bigMedusaRotation+DEGREES_TO_RADIANS(BIG_MEDUSA_MAX_ROTATION_AT_A_TIME);
                }
                else
                {
                    bigMedusaRotation = bigMedusaRotation-DEGREES_TO_RADIANS(BIG_MEDUSA_MAX_ROTATION_AT_A_TIME);
                }
            }
            
        } 
        else
        {
            bigMedusaRotation = newBigMedusaRotation;            
        }
        

        
        CGAffineTransform newTransform;
        if (medusaPulseDirection) 
        {
            newTransform = CGAffineTransformMakeScale(0.90, 1.00+0.01*bigMedusaPulseClock);
        }
        else
        {
            newTransform = CGAffineTransformMakeScale(1.00+0.01*bigMedusaPulseClock, 0.90);
        }
        newTransform = CGAffineTransformRotate(newTransform, bigMedusaRotation);
        [screen12BigMedusaImageView setTransform:newTransform];
        
        
        
        
        
        if (sqrt(pow(translatedPoint.x-previousTranslatedPoint.x, 2.0)+pow(translatedPoint.y-previousTranslatedPoint.y, 2.0))>5) 
        {
        }
        previousTranslatedPoint=translatedPoint;            
        bigMedusaSlowsDownClock=0;
    }

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    UITouch *touch = [touches anyObject];
    CGPoint translatedPoint = [touch locationInView:self.view];
    
    if (isBigMedusaMoving) 
    {
        if (bigMedusaSlowsDownClock>100) 
        {
            [bigMedusaSlowsDownTimer invalidate];
        } else 
        {
            bigMedusaSlowsDownValues=CGPointMake((translatedPoint.x-previousTranslatedPoint.x)/(bigMedusaSlowsDownClock+1), (translatedPoint.y-previousTranslatedPoint.y)/(bigMedusaSlowsDownClock+1));            
            isBigMedusaSlowsDown=true;
        }    
    }
    isBigMedusaPulse = false;                
    isBigMedusaMoving = false;

}

- (void) bigMedusaSlowsDownAction;
{
    bigMedusaSlowsDownClock++;
    if (isBigMedusaSlowsDown) 
    {
        [self screen12BigMedusaMoveToCoordinate:CGPointMake(screen12BigMedusaImageView.center.x+bigMedusaSlowsDownValues.x, screen12BigMedusaImageView.center.y+bigMedusaSlowsDownValues.y)];
        bigMedusaSlowsDownValues.x=bigMedusaSlowsDownValues.x*0.975;
        bigMedusaSlowsDownValues.y=bigMedusaSlowsDownValues.y*0.975;
        if (sqrt(pow(bigMedusaSlowsDownValues.x,2.0)+pow(bigMedusaSlowsDownValues.y,2.0))<0.01) {
            [bigMedusaSlowsDownTimer invalidate];
            if (CGRectIntersectsRect(screen12BigMedusaImageView.frame, self.view.frame)!=1) 
            {
                isBigMedusaSlowsDown=false;
                bigMedusaArmsMoveClock=0;
                [screen12BigMedusaImageView setTransform:CGAffineTransformMakeRotation(0)];
                [self screen12BigMedusaAppears];
                ///*****

            }
        }
    }
}

- (void) screen12IsBigMedusaReachesFish;
{
    
    NSEnumerator *enumerator = [fishes1Array objectEnumerator];
    id obj;
    UIImageView *fish;
    CGFloat fishNewX, fishNewY;
    CGFloat fishEscapeRotation=0;
    while (obj = [enumerator nextObject]) 
    {
        fish = obj;
        if (CGRectIntersectsRect(fish.frame, screen12BigMedusaImageView.frame)==1) {
            fishNewX = fish.center.x+(fish.center.x-screen12BigMedusaImageView.center.x)*2;
            fishNewY = fish.center.y+(fish.center.y-screen12BigMedusaImageView.center.y)*2;
            fishEscapeRotation = atanf((fish.center.y-fishNewY)/(fish.center.x-fishNewX));
            if (fish.center.x>screen12BigMedusaImageView.center.x) 
            {
                fishEscapeRotation = fishEscapeRotation-M_PI;
            }
            [UIView animateWithDuration: 0.20
                                  delay: 0
                                options: UIViewAnimationOptionCurveEaseIn
                             animations:^
             {
                 CGAffineTransform newTransform = CGAffineTransformRotate([fish transform],fishEscapeRotation);
                 [fish setTransform:newTransform];
             }
                             completion:nil];
            [UIView animateWithDuration: 1.00
                                  delay: 0
                                options: UIViewAnimationOptionCurveEaseIn
                             animations:^
             {
                 [fish setAlpha:0];
                 [fish setCenter:CGPointMake(fishNewX, fishNewY)];
             }
                             completion:nil];
        }
    }
    
    enumerator = [fishes2Array objectEnumerator];
    while (obj = [enumerator nextObject]) 
    {
        fish = obj;
        if (CGRectIntersectsRect(fish.frame, screen12BigMedusaImageView.frame)==1) {
            fishNewX = fish.center.x+(fish.center.x-screen12BigMedusaImageView.center.x)*2;
            fishNewY = fish.center.y+(fish.center.y-screen12BigMedusaImageView.center.y)*2;
            fishEscapeRotation = atanf((fish.center.y-fishNewY)/(fish.center.x-fishNewX));
            if (fish.center.x<screen12BigMedusaImageView.center.x) 
            {
                fishEscapeRotation = fishEscapeRotation-M_PI;
            }
            [UIView animateWithDuration: 0.20
                                  delay: 0
                                options: UIViewAnimationOptionCurveEaseIn
                             animations:^
             {
                 CGAffineTransform newTransform = CGAffineTransformRotate([fish transform],fishEscapeRotation);
                 [fish setTransform:newTransform];
             }
                             completion:nil];
            [UIView animateWithDuration: 1.00
                                  delay: 0
                                options: UIViewAnimationOptionCurveEaseIn
                             animations:^
             {
                 [fish setAlpha:0];
                 [fish setCenter:CGPointMake(fishNewX, fishNewY)];
             }
                             completion:nil];
        }
    }

}

- (void)screen12BigMedusaPulseAction;
{
    
    bigMedusaPulseClock=bigMedusaPulseClock+bigMedusaPulseClockChange;
    CGAffineTransform newTransform;
    if (medusaPulseDirection) 
    {
        newTransform = CGAffineTransformMakeScale(0.90, 1.00+0.01*bigMedusaPulseClock);
    }
    else
    {
        newTransform = CGAffineTransformMakeScale(1.00+0.01*bigMedusaPulseClock, 0.90);
    }
    
    newTransform = CGAffineTransformRotate(newTransform, bigMedusaRotation);
    [screen12BigMedusaImageView setTransform:newTransform];
    
    if ((bigMedusaPulseClock==0)&&(!isBigMedusaPulse)) 
    {
        [bigMedusaPulseTimer invalidate];
    } 
    if ((bigMedusaPulseClock == -10)&&(bigMedusaPulseClockChange == -1)) 
    {
        medusaPulseDirection = !medusaPulseDirection;
    } 
    if (bigMedusaPulseClock>=10) 
    {
        bigMedusaPulseClockChange = -1;
    }
    if (bigMedusaPulseClock<=-10) 
    {
        bigMedusaPulseClockChange = 1;
    }
    
}

- (UIImage*) imageWithBrightness:(CGFloat)brightnessFactor {
    
    if ( brightnessFactor == 0 ) {
        return screen12Kelp1ImageView.image;
    }
    
    CGImageRef imgRef = [[UIImage imageNamed:@"12_1k_hinar_1.png"] CGImage];
    
    size_t width = CGImageGetWidth(imgRef);
    size_t height = CGImageGetHeight(imgRef);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = 4;
    size_t bytesPerRow = bytesPerPixel * width;
    size_t totalBytes = bytesPerRow * height;
    
    //Allocate Image space
    uint8_t* rawData = malloc(totalBytes);
    
    //Create Bitmap of same size
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    //Draw our image to the context
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imgRef);
    
    //Perform Brightness Manipulation
    for ( int i = 0; i < totalBytes; i += 4 ) {
        
        uint8_t* red = rawData + i; 
        uint8_t* green = rawData + (i + 1); 
        uint8_t* blue = rawData + (i + 2); 
        
        *red = MIN(255,MAX(0,roundf(*red + (*red * brightnessFactor))));
        *green = MIN(255,MAX(0,roundf(*green + (*green * brightnessFactor))));
        *blue = MIN(255,MAX(0,roundf(*blue + (*blue * brightnessFactor))));
        
    }
    
    //Create Image
    CGImageRef newImg = CGBitmapContextCreateImage(context);
    
    //Release Created Data Structs
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    free(rawData);
    
    //Create UIImage struct around image
    UIImage* image = [UIImage imageWithCGImage:newImg];
    
    //Release our hold on the image
    CGImageRelease(newImg);
    
    rawData=nil;
    
    //return new image!
    return image;
    
}

- (void)screen12BigMedusaArmsMoveAction:(id)sender 
{
    bigMedusaArmsMoveClock=bigMedusaArmsMoveClock+1;  
    
    CGFloat rotation = 0.5*sinf(1.00*bigMedusaArmsMoveClock/180*M_PI)+bigMedusaRotation;
    CGAffineTransform newTransform = CGAffineTransformRotate(previousTransformMatrix,rotation);
    [screen12BigMedusaArm1ImageView setTransform:newTransform];

    rotation = 0.3*cosf(1.00*bigMedusaArmsMoveClock/180*M_PI)+bigMedusaRotation;
    newTransform = CGAffineTransformRotate(previousTransformMatrix,rotation);
    [screen12BigMedusaArm2ImageView setTransform:newTransform];

    rotation = 0.15*sinf(1.00*bigMedusaArmsMoveClock/180*M_PI)+bigMedusaRotation;
    newTransform = CGAffineTransformRotate(previousTransformMatrix,rotation);
    [screen12BigMedusaArm3ImageView setTransform:newTransform];
    
    rotation = 0.2*sinf(1.00*bigMedusaArmsMoveClock/180*M_PI)+bigMedusaRotation;
    newTransform = CGAffineTransformRotate(previousTransformMatrix,rotation);
    [screen12BigMedusaArm4ImageView setTransform:newTransform];
    
    
}

- (void) screen12CreateFishes;
{
    UIImageView *fish;
    CGFloat newScale, fishOriginalDegree;
    CGAffineTransform newTransform;
    int randomFish, fishRadius;
    CGFloat fishSpeed;
    for (int i=MAX_FISHES_1/12*4; i<MAX_FISHES_1/12*9; i++) {
        randomFish = arc4random()%9+1;
        fish = [[UIImageView alloc] init];
        switch (randomFish) {
            case 1:
                [fish setFrame:CGRectMake(0, 0, 80, 34)];
                break;
            case 2:
                [fish setFrame:CGRectMake(0, 0, 93, 29)];
                break;
            case 3:
                [fish setFrame:CGRectMake(0, 0, 72, 50)];
                break;
            case 4:
                [fish setFrame:CGRectMake(0, 0, 58, 58)];
                break;
            case 5:
                [fish setFrame:CGRectMake(0, 0, 87, 58)];
                break;
            case 6:
                [fish setFrame:CGRectMake(0, 0, 96, 26)];
                break;
            case 7:
                [fish setFrame:CGRectMake(0, 0, 49, 47)];
                break;
            case 8:
                [fish setFrame:CGRectMake(0, 0, 82, 48)];
                break;
            case 9:
                [fish setFrame:CGRectMake(0, 0, 64, 90)];
                break;
                
            default:
                [fish setFrame:CGRectMake(0, 0, 89, 57)];
                break;
        }
        fish.image = [UIImage imageNamed:[NSString stringWithFormat:@"12_1k_hal%i.png",randomFish]];
        
        fishOriginalDegree = 2.00*M_PI/MAX_FISHES_1*i;
        fishRadius = FISHES_1_RADIUS2+((arc4random()%(FISHES_1_RADIUS-FISHES_1_RADIUS2))+1);
        [fish setCenter:CGPointMake(roundf(1.00*FISHES_1_CENTER_X+fishRadius*sin(fishOriginalDegree)), roundf(1.00*FISHES_1_CENTER_Y+fishRadius*cos(fishOriginalDegree)))];

        if (arc4random()%2==0) 
        {
            newScale = 1.00*(arc4random()%11+20)/100;
        }
        else
        {
            newScale = 1.00*(arc4random()%31+70)/100;            
        }
        [fish setTransform:CGAffineTransformMakeScale(newScale, newScale)];
        
        newTransform = [fish transform];
        newTransform = CGAffineTransformRotate(newTransform,-2.00*M_PI/MAX_FISHES_1*i);
        [fish setTransform:newTransform];
        
        [self.view addSubview:fish];

        [fishes1Array addObject:fish]; 
        fishSpeed = ((arc4random()%(FISHES1_MAX_SPEED-FISHES1_MIN_SPEED))+FISHES1_MIN_SPEED)/10.00;
        [fishes1SpeedArray addObject:[NSNumber numberWithFloat:fishSpeed]];   
        fish=nil;
        
        randomFish = arc4random()%9+1;
        fish = [[UIImageView alloc] init];
        switch (randomFish) {
            case 1:
                [fish setFrame:CGRectMake(0, 0, 80, 34)];
                break;
            case 2:
                [fish setFrame:CGRectMake(0, 0, 93, 29)];
                break;
            case 3:
                [fish setFrame:CGRectMake(0, 0, 72, 50)];
                break;
            case 4:
                [fish setFrame:CGRectMake(0, 0, 58, 58)];
                break;
            case 5:
                [fish setFrame:CGRectMake(0, 0, 87, 58)];
                break;
            case 6:
                [fish setFrame:CGRectMake(0, 0, 96, 26)];
                break;
            case 7:
                [fish setFrame:CGRectMake(0, 0, 49, 47)];
                break;
            case 8:
                [fish setFrame:CGRectMake(0, 0, 82, 48)];
                break;
            case 9:
                [fish setFrame:CGRectMake(0, 0, 64, 90)];
                break;
                
            default:
                [fish setFrame:CGRectMake(0, 0, 89, 57)];
                break;
        }
        fish.image = [UIImage imageNamed:[NSString stringWithFormat:@"12_1k_hal%i.png",randomFish]];
        
        fishRadius = FISHES_1_RADIUS2+((arc4random()%(FISHES_1_RADIUS-FISHES_1_RADIUS2))+1);
        [fish setCenter:CGPointMake(roundf(1.00*FISHES_1_CENTER_X+fishRadius*sin(fishOriginalDegree)), roundf(1.00*FISHES_1_CENTER_Y+fishRadius*cos(fishOriginalDegree)))];

        if (arc4random()%2==0) 
        {
            newScale = 1.00*(arc4random()%11+20)/100;
        }
        else
        {
            newScale = 1.00*(arc4random()%31+70)/100;            
        }
        [fish setTransform:CGAffineTransformMakeScale(newScale, newScale)];
        
        newTransform = [fish transform];
        newTransform = CGAffineTransformRotate(newTransform,-2.00*M_PI/MAX_FISHES_1*i);
        [fish setTransform:newTransform];
        
        [self.view addSubview:fish];
        
        [fishes1Array addObject:fish];           
        fishSpeed = ((arc4random()%(FISHES1_MAX_SPEED-FISHES1_MIN_SPEED))+FISHES1_MIN_SPEED)/10.00;
        [fishes1SpeedArray addObject:[NSNumber numberWithFloat:fishSpeed]];   
        fish=nil;
    }
 
    for (int i=(MAX_FISHES_2/12)*4; i<(MAX_FISHES_2/12)*9; i++) {
        randomFish = arc4random()%9+1;
        fish = [[UIImageView alloc] init];
        switch (randomFish) {
            case 1:
                [fish setFrame:CGRectMake(0, 0, 80, 34)];
                break;
            case 2:
                [fish setFrame:CGRectMake(0, 0, 93, 29)];
                break;
            case 3:
                [fish setFrame:CGRectMake(0, 0, 72, 50)];
                break;
            case 4:
                [fish setFrame:CGRectMake(0, 0, 58, 58)];
                break;
            case 5:
                [fish setFrame:CGRectMake(0, 0, 87, 58)];
                break;
            case 6:
                [fish setFrame:CGRectMake(0, 0, 96, 26)];
                break;
            case 7:
                [fish setFrame:CGRectMake(0, 0, 49, 47)];
                break;
            case 8:
                [fish setFrame:CGRectMake(0, 0, 82, 48)];
                break;
            case 9:
                [fish setFrame:CGRectMake(0, 0, 64, 90)];
                break;
                
            default:
                [fish setFrame:CGRectMake(0, 0, 89, 57)];
                break;
        }
        fish.image = [UIImage imageNamed:[NSString stringWithFormat:@"12_1k_hal%i.png",randomFish]];
        
        if (arc4random()%2==0) 
        {
            newScale = 1.00*(arc4random()%11+20)/100;
        }
        else
        {
            newScale = 1.00*(arc4random()%31+70)/100;            
        }
        [fish setTransform:CGAffineTransformMakeScale(newScale, newScale)];
        
        newTransform = [fish transform];
        newTransform = CGAffineTransformRotate(newTransform,-2.00*M_PI/MAX_FISHES_2*i+M_PI);
        [fish setTransform:newTransform];
        
        fish.image = [UIImage imageWithCGImage:fish.image.CGImage scale:1.0 orientation:UIImageOrientationUpMirrored];

        
        fishOriginalDegree = 2.00*M_PI/MAX_FISHES_2*i;
        fishRadius = FISHES_2_RADIUS2+((arc4random()%(FISHES_2_RADIUS-FISHES_2_RADIUS2))+1);
        [fish setCenter:CGPointMake(roundf(1.00*FISHES_2_CENTER_X+fishRadius*sin(fishOriginalDegree)), roundf(1.00*FISHES_2_CENTER_Y+fishRadius*cos(fishOriginalDegree)))];

//        [fish setCenter:CGPointMake(roundf(1.00*FISHES_2_CENTER_X+FISHES_2_RADIUS*sin(2.00*M_PI/MAX_FISHES_2*i)), roundf(1.00*FISHES_2_CENTER_Y+FISHES_2_RADIUS*cos(2.00*M_PI/MAX_FISHES_2*i)))];

        [self.view addSubview:fish];
        
        [fishes2Array addObject:fish]; 

        fishSpeed = ((arc4random()%(FISHES2_MAX_SPEED-FISHES2_MIN_SPEED))+FISHES2_MIN_SPEED)/10.00;
        [fishes2SpeedArray addObject:[NSNumber numberWithFloat:fishSpeed]];   
        fish=nil;

        fish = [[UIImageView alloc] init];
        [fish setFrame:CGRectMake(0, 0, 89, 57)];
        fish.image = [UIImage imageNamed:[NSString stringWithFormat:@"12_1k_hal%i.png",arc4random()%9+1]];
        
        if (arc4random()%2==0) 
        {
            newScale = 1.00*(arc4random()%11+20)/100;
        }
        else
        {
            newScale = 1.00*(arc4random()%31+70)/100;            
        }
        [fish setTransform:CGAffineTransformMakeScale(newScale, newScale)];
        
        newTransform = [fish transform];
        newTransform = CGAffineTransformRotate(newTransform,-2.00*M_PI/MAX_FISHES_2*i+M_PI);
        [fish setTransform:newTransform];
        
        fish.image = [UIImage imageWithCGImage:fish.image.CGImage scale:1.0 orientation:UIImageOrientationUpMirrored];
 
        fishRadius = FISHES_2_RADIUS2+((arc4random()%(FISHES_2_RADIUS-FISHES_2_RADIUS2))+1);
        [fish setCenter:CGPointMake(roundf(1.00*FISHES_2_CENTER_X+fishRadius*sin(fishOriginalDegree)), roundf(1.00*FISHES_2_CENTER_Y+fishRadius*cos(fishOriginalDegree)))];
        
        [self.view addSubview:fish];
        
        [fishes2Array addObject:fish];           
        fishSpeed = ((arc4random()%(FISHES2_MAX_SPEED-FISHES2_MIN_SPEED))+FISHES2_MIN_SPEED)/10.00;
        [fishes2SpeedArray addObject:[NSNumber numberWithFloat:fishSpeed]];   
        
        fish=nil;
    }

}

- (void) screen12FishesMovingAction:(id)sender ;
{
    fishesMovingClock++;
    CGAffineTransform newTransform;
    NSEnumerator *enumerator = [fishes1Array objectEnumerator];
    NSEnumerator *enumeratorSpeed = [fishes1SpeedArray objectEnumerator];
    id obj, objSpeed;
    UIImageView *fish;
    int visibleFishes = 0;
    CGFloat fishSpeed;
    while (obj = [enumerator nextObject]) 
    {
        objSpeed = [enumeratorSpeed nextObject];
        fish = obj;
        fishSpeed = [objSpeed floatValue];
        
        if (fish.alpha == 1) 
        {
            visibleFishes++;
            if ((fish.center.y-100)<FISHES_1_CENTER_Y) 
            {
                [fish setCenter:[self rotatePoint:fish.center around:CGPointMake(FISHES_1_CENTER_X, FISHES_1_CENTER_Y) withDegree:240.00/180.00*M_PI]];
                newTransform = [fish transform];
                newTransform = CGAffineTransformRotate(newTransform,240.00/180.00*M_PI);
                [fish setTransform:newTransform];
            }
            else
            {
                [fish setCenter:[self rotatePoint:fish.center around:CGPointMake(FISHES_1_CENTER_X, FISHES_1_CENTER_Y) withDegree:fishSpeed/180*M_PI]];
                newTransform = [fish transform];
                newTransform = CGAffineTransformRotate(newTransform,fishSpeed/180*M_PI);
                [fish setTransform:newTransform];
            }
        }
    }
    enumerator = [fishes2Array objectEnumerator];
    enumeratorSpeed = [fishes2SpeedArray objectEnumerator];
    while (obj = [enumerator nextObject]) 
    {
        objSpeed = [enumeratorSpeed nextObject];
        fish = obj;
        fishSpeed = [objSpeed floatValue];

        if (fish.alpha == 1) 
        {
            visibleFishes++;
            if ((fish.center.y+100)>FISHES_2_CENTER_Y) 
            {
                [fish setCenter:[self rotatePoint:fish.center around:CGPointMake(FISHES_2_CENTER_X, FISHES_2_CENTER_Y) withDegree:240.00/180.00*M_PI]];
                newTransform = [fish transform];
                newTransform = CGAffineTransformRotate(newTransform,240.00/180.00*M_PI);
                [fish setTransform:newTransform];
            }
            else
            {
                [fish setCenter:[self rotatePoint:fish.center around:CGPointMake(FISHES_2_CENTER_X, FISHES_2_CENTER_Y) withDegree:fishSpeed/180*M_PI]];
                
                newTransform = [fish transform];
                newTransform = CGAffineTransformRotate(newTransform,fishSpeed/180*M_PI);
                [fish setTransform:newTransform];
            }
        }
        
    }
    [self screen12IsBigMedusaReachesFish];
    if (visibleFishes==0) {
        [fishesMovingTimer invalidate];
        [self screen12BackgroundMedusasComeIn];
    }
}

- (CGPoint)rotatePoint:(CGPoint)pointToRotate around:(CGPoint)center withDegree:(float)degree
{
	pointToRotate = CGPointMake(pointToRotate.x-center.x,pointToRotate.y-center.y);
	CGPoint rotatedPoint = CGPointMake(pointToRotate.x*cos(degree)-pointToRotate.y*sin(degree),pointToRotate.x*sin(degree)+pointToRotate.y*cos(degree));
	rotatedPoint.x=center.x+rotatedPoint.x;
	rotatedPoint.y=center.y+rotatedPoint.y;
	return rotatedPoint;	
}

- (void)screen12SetStartingPointForBackgroundMedusas;
{
    [screen12BackgroundMedusa1ImageView setCenter:CGPointMake(1512, 200)];
    [screen12BackgroundMedusa2ImageView setCenter:CGPointMake(0, 150)];
    [screen12BackgroundMedusa3ImageView setCenter:CGPointMake(400, 1100)];
    [screen12BackgroundMedusa4ImageView setCenter:CGPointMake(1100, 800)];
    [screen12BackgroundMedusa5ImageView setCenter:CGPointMake(-200, 500)];
    [screen12BackgroundMedusa6ImageView setCenter:CGPointMake(1100, 900)];
    [screen12BackgroundMedusa7ImageView setCenter:CGPointMake(200, -200)];
    [screen12BackgroundMedusa8ImageView setCenter:CGPointMake(600, -100)];
}

- (void)screen12BackgroundMedusasComeIn;
{
    [UIView animateWithDuration: 5.00
                          delay: 1+arc4random()%10
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         [screen12BackgroundMedusa1ImageView setCenter:CGPointMake(512, 374)];
     }
                     completion:nil];

    [UIView animateWithDuration: 5.00
                          delay: 1+arc4random()%10
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         [screen12BackgroundMedusa2ImageView setCenter:CGPointMake(512, 374)];
     }
                     completion:nil];

    [UIView animateWithDuration: 5.00
                          delay: 1+arc4random()%10
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         [screen12BackgroundMedusa3ImageView setCenter:CGPointMake(512, 374)];
     }
                     completion:nil];
    
    [UIView animateWithDuration: 5.00
                          delay: 1+arc4random()%10
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         [screen12BackgroundMedusa4ImageView setCenter:CGPointMake(512, 374)];
     }
                     completion:nil];
    
    [UIView animateWithDuration: 5.00
                          delay: 1+arc4random()%10
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         [screen12BackgroundMedusa5ImageView setCenter:CGPointMake(512, 374)];
     }
                     completion:nil];
    
    [UIView animateWithDuration: 5.00
                          delay: 1+arc4random()%10
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         [screen12BackgroundMedusa6ImageView setCenter:CGPointMake(512, 374)];
     }
                     completion:nil];
    
    [UIView animateWithDuration: 5.00
                          delay: 1+arc4random()%10
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         [screen12BackgroundMedusa7ImageView setCenter:CGPointMake(512, 374)];
     }
                     completion:nil];
    
    [UIView animateWithDuration: 5.00
                          delay: 1+arc4random()%10
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^
     {
         [screen12BackgroundMedusa8ImageView setCenter:CGPointMake(512, 374)];
     }
                     completion:nil];
    

}

- (void) screen12continuousKelpMovementAction:(id)sender ;
{
    continuousKelpMovementClock++;
    CGAffineTransform newTransform = CGAffineTransformMakeRotation(sin(continuousKelpMovementClock/180.00*M_PI)/3);
    [screen12Kelp1ImageView setTransform:newTransform];
    [screen12Kelp2ImageView setTransform:newTransform];
    [screen12Kelp3ImageView setTransform:newTransform];
    [screen12Kelp4ImageView setTransform:newTransform];
    [screen12Kelp5ImageView setTransform:newTransform];
    [screen12Kelp6ImageView setTransform:newTransform];
    
    if (continuousKelpMovementClock==360) {
        continuousKelpMovementClock=0;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    movingWavesTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(movingWavesAction) userInfo:nil repeats:YES];
    movingWavesClock=0;
	[movingWavesTimer fire];

    bigMedusaArmsMoveTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screen12BigMedusaArmsMoveAction:) userInfo:nil repeats:YES];
    bigMedusaArmsMoveClock=0;
    previousTransformMatrix = [screen12BigMedusaImageView transform];
	[bigMedusaArmsMoveTimer fire];

//    [self textAppear];

    [self screen12BigMedusaAppears];

    isBigMedusaPulse = false;
    bigMedusaAppearsClock = 0;
//    bigMedusaAppearsClock = -400;
    bigMedusaPulseClockChange = -1;
    [screen12BigMedusaImageView setTransform:CGAffineTransformMakeScale(1.00+0.01*bigMedusaPulseClock, 0.90)];


    fishes1Array =[[NSMutableArray alloc] initWithCapacity:100];
    fishes2Array =[[NSMutableArray alloc] initWithCapacity:100];
    fishes1SpeedArray =[[NSMutableArray alloc] initWithCapacity:100];
    fishes2SpeedArray =[[NSMutableArray alloc] initWithCapacity:100];
    [self screen12CreateFishes ];

    fishesMovingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screen12FishesMovingAction:) userInfo:nil repeats:YES];
    fishesMovingClock=0;
	[fishesMovingTimer fire];
    
    continuousKelpMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(screen12continuousKelpMovementAction:) userInfo:nil repeats:YES];
    continuousKelpMovementClock=0;
	[continuousKelpMovementTimer fire];
    
    [self screen12SetStartingPointForBackgroundMedusas];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (void)viewWillDisappear:(BOOL)animated;
{
    [fishes1Array removeAllObjects];
    [fishes2Array removeAllObjects];
    [fishes1SpeedArray removeAllObjects];
    [fishes2SpeedArray removeAllObjects];
    
    fishes1Array=nil;
    fishes2Array=nil;
    fishes1SpeedArray=nil;
    fishes2SpeedArray=nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight)) {
        return YES;
    }
    // Return YES for supported orientations
	return NO;
}

@end
