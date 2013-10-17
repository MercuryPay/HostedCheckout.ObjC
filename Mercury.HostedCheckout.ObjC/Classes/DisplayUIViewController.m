//
//  DisplayUIViewController.m
//  Mercury.HostedCheckout.ObjC
//
//  Created by agharris73 on 10/14/13.
//  Copyright (c) 2013 Mercury. All rights reserved.
//

#import "DisplayUIViewController.h"

@implementation DisplayUIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_viewWeb setOpaque:NO];
    [_viewWeb setBackgroundColor:[UIColor clearColor]];
    self.viewWeb.delegate = self;
    [self displayHC];
}

- (void)displayHC {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [_viewWeb setOpaque:NO];
    [_viewWeb setBackgroundColor:[UIColor clearColor]];
    
    NSString *pidURL = [NSString stringWithFormat:@"https://hc.mercurydev.net/CheckoutPOSiframe.aspx?pid=%@", appDelegate.pid];

    NSURL *url = [NSURL URLWithString:pidURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_viewWeb loadRequest:requestObj];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSString *URLString = [[request URL] absoluteString];
    
    if ([URLString hasSuffix: @"COMPLETED"]) {
        [self performSegueWithIdentifier:@"verifySegue" sender:self];
        return NO;
    }
    
    if ([URLString hasSuffix: @"CANCELED"]) {
        [self performSegueWithIdentifier:@"cancelSegue" sender:self];
    }
    
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
