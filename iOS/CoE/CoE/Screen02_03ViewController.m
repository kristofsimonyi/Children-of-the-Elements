//
//  Screen02-03ViewController.m
//  KickOff
//
//  Created by Ferenc INKOVICS on 30/04/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import "Screen02_03ViewController.h"

@interface Screen02_03ViewController ()

@end

@implementation Screen02_03ViewController

-(IBAction)screen02_03BackToMainMenu:(id)sender;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
