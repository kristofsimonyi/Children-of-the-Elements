//
//  ScrollingPagesViewController.m
//  KickOff
//
//  Created by Ferenc INKOVICS on 01/05/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//
#define NUMBER_OF_PAGES     11
#define IMAGE_HEIGHT        150
#define IMAGE_WIDTH         200
#define PAGE_HEIGHT         350
#define PAGE_WIDTH          350
#define GROTH_PERCENTAGE    0.50

#import "ScrollingPagesViewController.h"

@interface ScrollingPagesViewController ()

@end

@implementation ScrollingPagesViewController

@synthesize scroll;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
	NSUInteger touchCount = 0;
	for (UITouch *touch in touches)
	{
		CGPoint translatedPoint = [touch locationInView:self.view];
        firstTranslatedPoint = translatedPoint;
        firstPositionOfScroll = actualPositionOfScroll;
        touchCount++;
	}
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
	NSUInteger touchCount = 0;
	for (UITouch *touch in touches)
	{
		CGPoint translatedPoint = [touch locationInView:self.view];
        
        actualPositionOfScroll=firstPositionOfScroll-translatedPoint.x+firstTranslatedPoint.x;
        if (actualPositionOfScroll < PAGE_WIDTH/2)
        {
            actualPositionOfScroll=PAGE_WIDTH/2;
        }
        if (actualPositionOfScroll > (NUMBER_OF_PAGES-1)*PAGE_WIDTH+PAGE_WIDTH/2)
        {
            actualPositionOfScroll=(NUMBER_OF_PAGES-1)*PAGE_WIDTH+PAGE_WIDTH/2;
        }
        
        touchCount++;
	}
    
    [self setImageSizes];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
    
}

-(void)setImageSizes;
{
    NSArray *subviews = [scroll subviews];
    int actualImageNumber=round((actualPositionOfScroll+PAGE_WIDTH/2.00)/PAGE_WIDTH)-1;
    if (actualImageNumber<0) actualImageNumber=0;
    CGFloat groth =actualPositionOfScroll-PAGE_WIDTH*actualImageNumber;
    groth = (groth-PAGE_WIDTH/2)/PAGE_WIDTH;
    if (groth<0)
    {
        groth=-groth;
    }
    groth = 0.5-groth;
    UIImageView *selectedImageView = [subviews objectAtIndex:actualImageNumber*2+1];
    for (UIImageView *imageView in subviews)
    {
  //      if ([imageView isKindOfClass:[UIImageView class]])
        {
            CGAffineTransform newTransform = CGAffineTransformMakeScale(1.0, 1.0);
            [imageView setTransform:newTransform];
        }
    }
    CGAffineTransform newTransform = CGAffineTransformMakeScale(1.0+groth, 1.0+groth);
    [selectedImageView setTransform:newTransform];
    [scroll setContentOffset:CGPointMake(actualPositionOfScroll-PAGE_WIDTH/2, 0) animated:NO];
}

-(IBAction)scrollingPaesBackToMainMenu:(id)sender;
{
    [self dismissViewControllerAnimated:YES completion:Nil];
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
    imageNames = [[NSArray alloc] initWithObjects:
                  [NSString stringWithFormat:@"screen1-overview2.png"],
                  [NSString stringWithFormat:@"screen2-3-overview.jpg"],
                  [NSString stringWithFormat:@"04-overview.png"],
                  [NSString stringWithFormat:@"6-7-overview.png"],
                  [NSString stringWithFormat:@"8_overview small.png"],
                  [NSString stringWithFormat:@"9_overview.png"],
                  [NSString stringWithFormat:@"screen11-overview1.png"],
                  [NSString stringWithFormat:@"12-overview.png"],
                  [NSString stringWithFormat:@"screen_16_osszkep.png"],
                  [NSString stringWithFormat:@"A1-overview.png"],
                  [NSString stringWithFormat:@"korhinta-overview.png"],
                  [NSString stringWithFormat:@""],
                  [NSString stringWithFormat:@""],
                  [NSString stringWithFormat:@""],
                  [NSString stringWithFormat:@""],
                  [NSString stringWithFormat:@""],
                  [NSString stringWithFormat:@""],
                  [NSString stringWithFormat:@""],
            nil];

    scroll.frame = CGRectMake(0,300,PAGE_WIDTH, PAGE_HEIGHT);
    [scroll setCenter:CGPointMake(512, 300)];
    scroll.contentSize = CGSizeMake(PAGE_WIDTH*NUMBER_OF_PAGES, PAGE_HEIGHT);
    scroll.showsHorizontalScrollIndicator = YES;
  
    for (int i=0; i<NUMBER_OF_PAGES; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*PAGE_WIDTH+(PAGE_WIDTH-IMAGE_WIDTH)/2, 0, IMAGE_WIDTH, IMAGE_HEIGHT)];
        imageView.image=[UIImage imageNamed:[imageNames objectAtIndex:i]];
        [scroll addSubview:imageView];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*PAGE_WIDTH, IMAGE_HEIGHT*(1+GROTH_PERCENTAGE), PAGE_WIDTH, 20)];
        label.text=[imageNames objectAtIndex:i];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setCenter:CGPointMake(imageView.center.x, label.center.y)];
        [scroll addSubview:label];
    }
    
    actualPositionOfScroll=PAGE_WIDTH/2;
    [self setImageSizes];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if ([self.view window] == nil)
        self.view = nil;
}

@end
