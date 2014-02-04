//
//  Screen11ViewController.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 25/03/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>

@interface Screen11ViewController : UIViewController <AVAudioPlayerDelegate>
{
    CGFloat cookingPotActualScale;
    CGPoint movingTouchViewStartCenter;
    UIImageView *movingImageView, *movingCookingPotImageView;
    UIView *movingTouchView;
    CGPoint firstTranslatedPoint;
    NSInteger ingredientsRemained;
    
    AVAudioPlayer *backgroundMusic, *narration;
}
@property (nonatomic, weak) IBOutlet UIImageView *screen11CookingPotImageView, *screen11HintLayerImageView, *screen11MenuImageView;
@property (nonatomic, weak) IBOutlet UIView *screen11Ingredient01TouchView, *screen11Ingredient02TouchView, *screen11Ingredient03TouchView, *screen11Ingredient04TouchView, *screen11Ingredient05TouchView, *screen11Ingredient06TouchView, *screen11Ingredient07TouchView;
@property (nonatomic, weak) IBOutlet UIImageView *screen11Ingredient01ImageView, *screen11Ingredient02ImageView, *screen11Ingredient03ImageView, *screen11Ingredient04ImageView, *screen11Ingredient05ImageView, *screen11Ingredient06ImageView, *screen11Ingredient07ImageView;
@property (nonatomic, weak) IBOutlet UIImageView *screen11CookingPotIngredient01ImageView, *screen11CookingPotIngredient02ImageView, *screen11CookingPotIngredient03ImageView, *screen11CookingPotIngredient04ImageView, *screen11CookingPotIngredient05ImageView, *screen11CookingPotIngredient06ImageView;
@property (nonatomic, weak) IBOutlet UIImageView *screen11PlateImageView;

-(IBAction)screen11BackToMainMenu:(id)sender;
- (IBAction)screen11NextScreenButtonTouched:(id)sender;
- (IBAction)screen11PreviousScreenButtonTouched:(id)sender;
- (IBAction)screen11NarrationButtonTapped:(UITapGestureRecognizer *)sender;
- (IBAction)screen11HintButtonTapped:(UITapGestureRecognizer *)sender;

@end
