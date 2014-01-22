//
//  Screen25ViewController.m
//  KickOff
//
//  Created by INKOVICS Ferenc on 04/06/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

#import "Screen25ViewController.h"

@interface Screen25ViewController ()

@end

@implementation Screen25ViewController

- (IBAction)screen25BackToMainMenu:(id)sender;
{
    //    ViewController *mainViewController=[[ViewController alloc] init];
    //    [self presentViewController:mainViewController animated:NO completion:Nil];
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
