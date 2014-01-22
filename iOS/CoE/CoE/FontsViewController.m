//
//  FontsViewController.m
//  CoE
//
//  Created by Ferenc INKOVICS on 17/12/13.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import "FontsViewController.h"

@interface FontsViewController ()

@end

@implementation FontsViewController

@synthesize scrollView;

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
    
    [scrollView setContentSize:(CGSizeMake(1024, 4048))];
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    int i=0;
    int const j=30;
    int const fontsize=20;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
//        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
//            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);

            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, i, 300, j)];
            [label setText:[fontNames objectAtIndex:indFont]];
            [label setMinimumFontSize:10];
            [scrollView addSubview:label];

            UIFont *newFont = [UIFont fontWithName:[fontNames objectAtIndex:indFont] size:fontsize];
            
            label=nil;
            label = [[UILabel alloc]initWithFrame:CGRectMake(310, i, 400, j)];
            [label setText:@"Children of the Elements"];
            [label setFont:newFont];
            [scrollView addSubview:label];

            label=nil;
            label = [[UILabel alloc]initWithFrame:CGRectMake(720, i, 300, j)];
            [label setText:@"áÁéÉíÍóÓöÖőŐüÜűŰ"];
            [label setFont:newFont];
            [scrollView addSubview:label];
            /*

             */
            newFont = nil;
            label=nil;
            i=i+j;
        }
        fontNames = nil;
    }
    familyNames = nil;
}

-(void)releaseFontsMemory;
{
    for (UILabel *subview in [scrollView subviews])
    {
        if ([subview isKindOfClass:[UILabel class]])
        {
            [subview setText:@""];
            [subview setFont:[UIFont systemFontOfSize:10]];
        }
    }
    for (UILabel *subview in [scrollView subviews])
    {
        [subview removeFromSuperview];
    }
    for (UILabel *subview in [self.view subviews])
    {
        [subview removeFromSuperview];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if ([self.view window] == nil)
        self.view = nil;
}

- (IBAction)backToMainScreen:(id)sender
{
    [self releaseFontsMemory];

    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
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
