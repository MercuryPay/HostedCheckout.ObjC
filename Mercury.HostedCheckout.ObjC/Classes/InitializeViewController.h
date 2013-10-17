//
//  InitializeViewController.h
//  Mercury.HostedCheckout.ObjC
//
//  Created by agharris73 on 10/14/13.
//  Copyright (c) 2013 Mercury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCMercuryHelper.h"
#import "AppDelegate.h"

@interface InitializeViewController : UIViewController <HCMercuryHelperDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *buttonInitPay;

- (IBAction)runInitPay:(id)sender;

@end
