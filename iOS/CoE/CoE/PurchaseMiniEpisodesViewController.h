//
//  PurchaseMiniEpisodesViewController.h
//  CoE
//
//  Created by Ferenc INKOVICS on 08/12/13.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@class ViewController;

@interface PurchaseMiniEpisodesViewController : UIViewController <SKPaymentTransactionObserver, SKProductsRequestDelegate>
{
    NSTimer *getProductIDTimer;
    int getProductIDTimercount;
    BOOL getProductIDTimerCanBeIncreased;
}

@property (strong, nonatomic) SKProduct *product, *product2, *product3, *product4, *product5;
@property (strong, nonatomic) NSString *productID;

@property (nonatomic, retain) IBOutlet UILabel *productTitle2, *productTitle3, *productTitle4, *productTitle5;
@property (nonatomic, retain) IBOutlet UITextView *productDescription2, *productDescription3, *productDescription4, *productDescription5;
@property (nonatomic, retain) IBOutlet UIButton *buyButton2, *buyButton3, *buyButton4, *buyButton5;
@property (nonatomic, retain) IBOutlet UIButton *restoreButton2, *restoreButton3, *restoreButton4, *restoreButton5;
@property (nonatomic, retain) IBOutlet UILabel *userInformationLabel;

- (IBAction)goBack:(id)sender;
- (IBAction)buyProduct2:(id)sender;
- (IBAction)buyProduct3:(id)sender;
- (IBAction)buyProduct4:(id)sender;
- (IBAction)buyProduct5:(id)sender;
- (IBAction)restore:(id)sender;

- (void)getProductID;
- (void)connectViewControllerToThisView:(ViewController *)viewController;

@end
