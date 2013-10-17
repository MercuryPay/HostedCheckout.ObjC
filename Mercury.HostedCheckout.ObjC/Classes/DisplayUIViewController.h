//
//  DisplayUIViewController.h
//  Mercury.HostedCheckout.ObjC
//
//  Created by agharris73 on 10/14/13.
//  Copyright (c) 2013 Mercury. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCMercuryHelper.h"
#import "AppDelegate.h"

@interface DisplayUIViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *viewWeb;

@end
