//
//  InitializeViewController.m
//  Mercury.HostedCheckout.ObjC
//
//  Created by agharris73 on 10/14/13.
//  Copyright (c) 2013 Mercury. All rights reserved.
//

#import "InitializeViewController.h"

@implementation InitializeViewController

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

- (IBAction)runInitPay:(id)sender {
    
    NSMutableDictionary *dictionaryReq = [NSMutableDictionary new];
    [dictionaryReq setObject:@"018847445761734" forKey:@"MerchantID"];
    [dictionaryReq setObject:@"02" forKey:@"LaneID"];
    [dictionaryReq setObject:@"Off" forKey:@"Keypad"];
    [dictionaryReq setObject:@"123456" forKey:@"Invoice"];
    [dictionaryReq setObject:@"3.05" forKey:@"TotalAmount"];
    [dictionaryReq setObject:@"0.0" forKey:@"TaxAmount"];
    [dictionaryReq setObject:@"Sale" forKey:@"TranType"];
    [dictionaryReq setObject:@"OneTime" forKey:@"Frequency"];
    [dictionaryReq setObject:@"Testing HostedCheckout.POS.ObjC" forKey:@"Memo"];
    [dictionaryReq setObject:@"COMPLETED" forKey:@"ProcessCompleteUrl"];
    [dictionaryReq setObject:@"CANCELED" forKey:@"ReturnUrl"];
    [dictionaryReq setObject:@"#00A4E4" forKey:@"TotalAmountBackgroundColor"];
    [dictionaryReq setObject:@"Swipe" forKey:@"DefaultSwipe"];
    [dictionaryReq setObject:@"Custom" forKey:@"DisplayStyle"];
    [dictionaryReq setObject:@"#00A4E4" forKey:@"BackgroundColor"];
    [dictionaryReq setObject:@"#00A4E4" forKey:@"ButtonBackgroundColor"];
    [dictionaryReq setObject:@"On" forKey:@"CancelButton"];
    
    HCMercuryHelper *mgh = [HCMercuryHelper new];
    mgh.delegate = self;
    [mgh initializePaymentFromDictionary:dictionaryReq andPassword:@"Y6@Mepyn!r0LsMNq"];

}

-(void) hcTransactionDidFailWithError:(NSError *)error {
    
}

-(void) hcTransactionDidFinish:(NSDictionary *)result {
        
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([result objectForKey:@"PaymentID"])
    {
        appDelegate.pid = [result objectForKey:@"PaymentID"];
    }
    
    if ([result objectForKey:@"ResponseCode"])
    {
        appDelegate.responseCode = [result objectForKey:@"ResponseCode"];
    }
    
    if ([result objectForKey:@"Message"])
    {
        appDelegate.message = [result objectForKey:@"Message"];
    }
    
    [self performSegueWithIdentifier:@"initPay" sender:self];
    
}

@end
