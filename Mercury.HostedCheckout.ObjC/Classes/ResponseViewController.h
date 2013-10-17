//
//  ResponseViewController.h
//  Mercury.HostedCheckout.ObjC
//
//  Created by agharris73 on 10/14/13.
//  Copyright (c) 2013 Mercury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCMercuryHelper.h"
#import "AppDelegate.h"

@interface ResponseViewController : UIViewController


@property (strong, nonatomic) IBOutlet UILabel *responseCodeValue;
@property (strong, nonatomic) IBOutlet UILabel *message;
@property (strong, nonatomic) IBOutlet UILabel *pid;

@end