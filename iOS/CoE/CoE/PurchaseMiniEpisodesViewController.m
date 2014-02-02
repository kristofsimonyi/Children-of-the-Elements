//
//  PurchaseMiniEpisodesViewController.m
//  CoE
//
//  Created by Ferenc INKOVICS on 08/12/13.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//
#define WAIT_TIME_BETWEEN_GETPRODUCTIDS             0.01
#define MINI_SERIES_02                              @"Inko.CoE.MiniSeries002"
#define MINI_SERIES_03                              @"Inko.CoE.MiniSeries003"
#define MINI_SERIES_04                              @"Inko.CoE.MiniSeries004"
#define MINI_SERIES_05                              @"Inko.CoE.MiniSeries005"

#import "PurchaseMiniEpisodesViewController.h"
#import "ViewController.h"
#import <StoreKit/StoreKit.h>

@interface PurchaseMiniEpisodesViewController ()

@property (strong, nonatomic) ViewController *homeViewController;

@end

@implementation PurchaseMiniEpisodesViewController

@synthesize productTitle2, productTitle3, productTitle4, productTitle5, productDescription2, productDescription3, productDescription4, productDescription5, buyButton2, buyButton3, buyButton4, buyButton5, restoreButton2, restoreButton3, restoreButton4, restoreButton5, userInformationLabel;

- (void)connectViewControllerToThisView:(ViewController *)viewController;
{
    _homeViewController = viewController;     
}

- (IBAction)goBack:(id)sender;
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (IBAction)buyProduct2:(id)sender;
{
    _product =  _product2;

    SKPayment *payment = [SKPayment paymentWithProduct:_product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (IBAction)buyProduct3:(id)sender;
{
    _product =  _product3;
    
    SKPayment *payment = [SKPayment paymentWithProduct:_product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (IBAction)buyProduct4:(id)sender;
{
    _product =  _product4;
    
    SKPayment *payment = [SKPayment paymentWithProduct:_product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (IBAction)buyProduct5:(id)sender;
{
    _product =  _product5;
    
    SKPayment *payment = [SKPayment paymentWithProduct:_product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (IBAction)restore:(id)sender;
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue;
{
    for (SKPaymentTransaction *transaction in queue.transactions)
    {
        NSString *productIDToRestore = transaction.payment.productIdentifier;
        SKProduct *product = [self productIDToProduct:productIDToRestore];
        if (product!=nil)
        {
            _product=product;
            _productID=productIDToRestore;
            [self unlockPurchase];
        }
    }
    
}

-(int)productIDToInteger:(NSString *)productID;
{
    int i=1;
    if ([productID isEqualToString:MINI_SERIES_02])
    {
        i=2;
    }
    else
        if ([productID isEqualToString:MINI_SERIES_03])
        {
            i=3;
        }
        else
            if ([productID isEqualToString:MINI_SERIES_04])
            {
                i=4;
            }
            else
                if ([productID isEqualToString:MINI_SERIES_05])
                {
                    i=5;
                }
    return i;
}

-(SKProduct *)productIDToProduct:(NSString *)productID;
{
    SKProduct *product = Nil;
    if ([productID isEqualToString:MINI_SERIES_02])
    {
        product=_product2;
    }
    else
        if ([productID isEqualToString:MINI_SERIES_03])
        {
            product=_product3;
        }
        else
            if ([productID isEqualToString:MINI_SERIES_04])
            {
                product=_product4;
            }
            else
                if ([productID isEqualToString:MINI_SERIES_05])
                {
                    product=_product5;
                }
    return product;
}

-(int)productToInteger:(SKProduct *)product;
{
    int i=1;
    if (product == _product2)
    {
        i=2;
    }
    else
        if (product == _product3)
        {
            i=3;
        }
        else
            if (product == _product4)
            {
                i=4;
            }
            else
                if (product == _product5)
                {
                    i=5;
                }
    return i;
}

- (void)getProductID;
{
    if ([SKPaymentQueue canMakePayments])
    {
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:self.productID]];
        request.delegate = self;
        [request start];
    } else
    {
        switch ([self productIDToInteger: _productID]) {
            case 2:
                productDescription2.text = @"Please enable In App Purchase in your settings";
                break;
                
            case 3:
                productDescription3.text = @"Please enable In App Purchase in your settings";
                break;
                
            case 4:
                productDescription4.text = @"Please enable In App Purchase in your settings";
                break;
                
            case 5:
                productDescription5.text = @"Please enable In App Purchase in your settings";
                break;
                
            default:
                break;
        }
    }
}

-(void)getProductIDTimerAction;
{
    if (getProductIDTimerCanBeIncreased)
    {
        getProductIDTimerCanBeIncreased=NO;
        getProductIDTimercount++;

        switch (getProductIDTimercount) {
            case 2:
                self.productID =  MINI_SERIES_02;
                [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
                [self getProductID];
                break;
                
            case 3:
                //product is saved for future usage
                _product2 = _product;
                
                // After product information is received the productTitle, productDesciption, buyButton and restoreButton need to appear
                productTitle2.hidden=FALSE;
                productDescription2.hidden=FALSE;
                buyButton2.hidden=FALSE;
                restoreButton2.hidden=FALSE;

                if (_homeViewController.miniEpisode02Padlock.hidden)
                {
                    [buyButton2 setTitle:@"Purchased" forState:UIControlStateNormal];
                }

                self.productID = MINI_SERIES_03;
                [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
                [self getProductID];
                break;
                
            case 4:
                //product is saved for future usage
                _product3 = _product;
                
                // After product information is received the productTitle, productDesciption, buyButton and restoreButton need to appear
                productTitle3.hidden=FALSE;
                productDescription3.hidden=FALSE;
                buyButton3.hidden=FALSE;
                restoreButton3.hidden=FALSE;
                
                if (_homeViewController.miniEpisode03Padlock.hidden)
                {
                    [buyButton3 setTitle:@"Purchased" forState:UIControlStateNormal];
                }
                
                self.productID =  MINI_SERIES_04;
                [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
                [self getProductID];
                break;
                
            case 5:
                //product is saved for future usage
                _product4 = _product;
                
                // After product information is received the productTitle, productDesciption, buyButton and restoreButton need to appear
                productTitle4.hidden=FALSE;
                productDescription4.hidden=FALSE;
                buyButton4.hidden=FALSE;
                restoreButton4.hidden=FALSE;
                
                if (_homeViewController.miniEpisode04Padlock.hidden)
                {
                    [buyButton4 setTitle:@"Purchased" forState:UIControlStateNormal];
                }
                
                self.productID =  MINI_SERIES_05;
                [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
                [self getProductID];
                break;
                
            case 6:
                //product is saved for future usage
                _product5 = _product;
                
                // After product information is received the productTitle, productDesciption, buyButton and restoreButton need to appear
                productTitle5.hidden=FALSE;
                productDescription5.hidden=FALSE;
                buyButton5.hidden=FALSE;
                restoreButton5.hidden=FALSE;
                

                if (_homeViewController.miniEpisode05Padlock.hidden)
                {
                    [buyButton5 setTitle:@"Purchased" forState:UIControlStateNormal];
                }

                // After all Product information are received restore buttons needs to be enabled
                restoreButton2.enabled = YES;
                restoreButton3.enabled = YES;
                restoreButton4.enabled = YES;
                restoreButton5.enabled = YES;
                
                // After all Product information are received purchase button for non-purchased products need to be enabled
                if (!_homeViewController.miniEpisode02Padlock.hidden) {[buyButton2 setEnabled:TRUE];}
                if (!_homeViewController.miniEpisode03Padlock.hidden) {[buyButton3 setEnabled:TRUE];}
                if (!_homeViewController.miniEpisode04Padlock.hidden) {[buyButton4 setEnabled:TRUE];}
                if (!_homeViewController.miniEpisode05Padlock.hidden) {[buyButton5 setEnabled:TRUE];}
                
                // After all Product information are received this label needs to hide
                [userInformationLabel setHidden:TRUE];
                break;
                
            default:
                [getProductIDTimer invalidate];
                break;
        }
    }
}

#pragma mark - SKProductsRequestDelegate

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    
    if (products.count!= 0)
    {
        _product = products[0];
        
        switch ([self productIDToInteger: _productID]) {
            case 2:
                productTitle2.text = _product.localizedTitle;
                productDescription2.text = _product.localizedDescription;
                break;
                
            case 3:
                productTitle3.text = _product.localizedTitle;
                productDescription3.text = _product.localizedDescription;
                break;
                
            case 4:
                productTitle4.text = _product.localizedTitle;
                productDescription4.text = _product.localizedDescription;
                break;
                
            case 5:
                productTitle5.text = _product.localizedTitle;
                productDescription5.text = _product.localizedDescription;
                break;
                
            default:
                break;
        }
        
        
    } else
    {
        switch ([self productToInteger: _product]) {
            case 2:
                productTitle2.text = @"Product not found";
                break;
                
            case 3:
                productTitle3.text = @"Product not found";
                break;
                
            case 4:
                productTitle4.text = @"Product not found";
                break;
                
            case 5:
                productTitle5.text = @"Product not found";
                break;
                
            default:
                break;
        }
    }
    
    products = response.invalidProductIdentifiers;
    
    for (SKProduct *product in products)
    {
        NSLog(@"Product not Found: %@", product);
    }
    getProductIDTimerCanBeIncreased=TRUE;
}

-(void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self unlockPurchase];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:
                NSLog(@"Transaction failed");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;

            default:
                
                break;
        }
    }
}

-(void)unlockPurchase;
{
    switch ([self productToInteger: _product]) {
        case 2:
            buyButton2.enabled=NO;
            [buyButton2 setTitle:@"Purchased" forState:UIControlStateDisabled];
            [_homeViewController miniEpisode02Purchased];
            break;
            
        case 3:
            buyButton3.enabled=NO;
            [buyButton3 setTitle:@"Purchased" forState:UIControlStateDisabled];
            [_homeViewController miniEpisode03Purchased];
            break;
            
        case 4:
            buyButton4.enabled=NO;
            [buyButton4 setTitle:@"Purchased" forState:UIControlStateDisabled];
            [_homeViewController miniEpisode04Purchased];
            break;
            
        case 5:
            buyButton5.enabled=NO;
            [buyButton5 setTitle:@"Purchased" forState:UIControlStateDisabled];
            [_homeViewController miniEpisode05Purchased];
            break;
            
        default:
            break;
    }
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

- (void)viewDidDisappear:(BOOL)animated;
{
    self.view=nil;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    buyButton2.enabled = NO;
    buyButton3.enabled = NO;
    buyButton4.enabled = NO;
    buyButton5.enabled = NO;
    
    //in order to avoid a restore event while other Product information are still loading from server restore buttons needs to be disabled
    restoreButton2.enabled = NO;
    restoreButton3.enabled = NO;
    restoreButton4.enabled = NO;
    restoreButton5.enabled = NO;
    
    getProductIDTimerCanBeIncreased=TRUE;
    getProductIDTimer = [NSTimer scheduledTimerWithTimeInterval:WAIT_TIME_BETWEEN_GETPRODUCTIDS target:self selector:@selector(getProductIDTimerAction) userInfo:nil repeats:YES];
    getProductIDTimercount=1;
	[getProductIDTimer fire];
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
