//
//  ResponseViewController.m
//  Mercury.HostedCheckout.ObjC
//
//  Created by agharris73 on 10/14/13.
//  Copyright (c) 2013 Mercury. All rights reserved.
//

#import "ResponseViewController.h"

@interface ResponseViewController ()

@end

@implementation ResponseViewController

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
 
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.message.text = appDelegate.message;
    self.responseCodeValue.text = appDelegate.responseCode;
    self.pid.text = appDelegate.pid;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
