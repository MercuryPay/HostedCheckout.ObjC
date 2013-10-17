//
//  VerifyViewController.m
//  Mercury.HostedCheckout.ObjC
//
//  Created by agharris73 on 10/14/13.
//  Copyright (c) 2013 Mercury. All rights reserved.
//

#import "VerifyViewController.h"

@interface VerifyViewController ()

@end

@implementation VerifyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)runVerifyPay:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSMutableDictionary *dictionaryReq = [NSMutableDictionary new];
    [dictionaryReq setObject:@"018847445761734" forKey:@"MerchantID"];
    [dictionaryReq setObject:appDelegate.pid forKey:@"PaymentID"];
    
    HCMercuryHelper *mgh = [HCMercuryHelper new];
    mgh.delegate = self;
    [mgh verifyPaymentFromDictionary:dictionaryReq andPassword:@"Y6@Mepyn!r0LsMNq"];
    
}

-(void) hcTransactionDidFailWithError:(NSError *)error {
    
}

-(void) hcTransactionDidFinish:(NSDictionary *)result {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([result objectForKey:@"Status"])
    {
        appDelegate.status = [result objectForKey:@"Status"];
    }
    if ([result objectForKey:@"TranType"])
    {
        appDelegate.tranType = [result objectForKey:@"TranType"];
    }
    if ([result objectForKey:@"AuthCode"])
    {
        appDelegate.authCode = [result objectForKey:@"AuthCode"];
    }
    if ([result objectForKey:@"AuthAmount"])
    {
        appDelegate.authAmount = [result objectForKey:@"AuthAmount"];
    }
    if ([result objectForKey:@"Amount"])
    {
        appDelegate.amount = [result objectForKey:@"Amount"];
    }
    if ([result objectForKey:@"TaxAmount"])
    {
        appDelegate.taxAmt = [result objectForKey:@"TaxAmount"];
    }
    if ([result objectForKey:@"AcqRefData"])
    {
        appDelegate.acqRefData = [result objectForKey:@"AcqRefData"];
    }
    if ([result objectForKey:@"CardType"])
    {
        appDelegate.cardType = [result objectForKey:@"CardType"];
    }
    if ([result objectForKey:@"DisplayMessage"])
    {
        appDelegate.displayMessage = [result objectForKey:@"DisplayMessage"];
    }
    if ([result objectForKey:@"ExpDate"])
    {
        appDelegate.expDate = [result objectForKey:@"ExpDate"];
    }
    if ([result objectForKey:@"Invoice"])
    {
        appDelegate.invoice = [result objectForKey:@"Invoice"];
    }
    if ([result objectForKey:@"MaskedAccount"])
    {
        appDelegate.maskedAccount = [result objectForKey:@"MaskedAccount"];
    }
    if ([result objectForKey:@"RefNo"])
    {
        appDelegate.refNo = [result objectForKey:@"RefNo"];
    }
    if ([result objectForKey:@"ResonseCode"])
    {
        appDelegate.responseCode = [result objectForKey:@"ResponseCode"];
    }
    if ([result objectForKey:@"StatusMessage"])
    {
        appDelegate.statusMessage = [result objectForKey:@"StatusMessage"];
    }
    if ([result objectForKey:@"Token"])
    {
        appDelegate.token = [result objectForKey:@"Token"];
    }
    if ([result objectForKey:@"TransPostTime"])
    {
        appDelegate.transPostTime = [result objectForKey:@"TransPostTime"];
    }
    if ([result objectForKey:@"CvvResult"])
    {
        appDelegate.cvvResult = [result objectForKey:@"CvvResult"];
    }
    
    [self performSegueWithIdentifier:@"verifyReturn" sender:self];
    
}

@end
