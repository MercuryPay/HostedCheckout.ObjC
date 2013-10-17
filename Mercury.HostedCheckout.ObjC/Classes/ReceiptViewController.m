//
//  ReceiptViewController.m
//  Mercury.HostedCheckout.ObjC
//
//  Created by agharris73 on 10/14/13.
//  Copyright (c) 2013 Mercury. All rights reserved.
//

#import "ReceiptViewController.h"

@interface ReceiptViewController ()

@end

@implementation ReceiptViewController

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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.statusValue.text = appDelegate.status;
    self.tranTypeValue.text = appDelegate.tranType;
    self.authCodeValue.text = appDelegate.authCode;
    self.authAmountValue.text = appDelegate.authAmount;
    self.amountValue.text = appDelegate.amount;
    self.taxAmtValue.text = appDelegate.taxAmt;
    self.acqRefDataValue.text = appDelegate.acqRefData;
    self.cardTypeValue.text = appDelegate.cardType;
    self.cvvResultValue.text = appDelegate.cvvResult;
    self.displayMessageValue.text = appDelegate.displayMessage;
    self.expDateValue.text = appDelegate.expDate;
    self.invoiceValue.text = appDelegate.invoice;
    self.maskedAccountValue.text = appDelegate.maskedAccount;
    self.refNoValue.text = appDelegate.refNo;
    self.responseCodeValue.text = appDelegate.responseCode;
    self.statusMessageValue.text = appDelegate.statusMessage;
    self.tokenValue.text = appDelegate.token;
    self.transPostTimeValue.text = appDelegate.transPostTime;
    self.transctionIDValue.text = appDelegate.tranactionID;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
