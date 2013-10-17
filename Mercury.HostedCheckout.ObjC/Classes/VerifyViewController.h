//
//  VerifyViewController.h
//  Mercury.HostedCheckout.ObjC
//
//  Created by agharris73 on 10/14/13.
//  Copyright (c) 2013 Mercury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCMercuryHelper.h"
#import "AppDelegate.h"

@interface VerifyViewController : UIViewController <HCMercuryHelperDelegate, UIWebViewDelegate, UIAlertViewDelegate>

- (IBAction)runVerifyPay:(id)sender;

@end
