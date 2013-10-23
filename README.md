HostedCheckout.ObjC
====================

XCode iOS application processing transactions to our Hosted Checkout platform.

>There are 3 steps to process a payment with Mercury's Hosted Checkout platform.

##Step 1: Initialize Payment

>To simplify our web service calls we have created an HCMercuryHelper library to submit, process, and parse the responses.

###Submit: Build Request with Key Value Pairs
>Create a NSMutableDictionary and add all the Key Value Pairs.
  
```objC
    NSMutableDictionary *dictionaryReq = [NSMutableDictionary new];
    [dictionaryReq setObject:@"018847445761734" forKey:@"MerchantID"];
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
```
  
###Process: Process Initialize Payment Transaction

Create HCMercuryHelper object and call the initializePaymentFromDictionary method with the NSMutalbeDictionary and merchant's password.

```objC
    HCMercuryHelper *mgh = [HCMercuryHelper new];
    mgh.delegate = self;
    [mgh initializePaymentFromDictionary:dictionaryReq andPassword:@"Y6@Mepyn!r0LsMNq"];
```

###Parse: Parse the Response

>Parse the Response using in the hcTransactionDidFinish delegate.

>Approved transactions will have a CmdStatus equal to "Approved".

```objC
-(void) hcTransactionDidFinish:(NSDictionary *)result {
    
    if ([result objectForKey:@"CmdStatus"]
      && [[result objectForKey:@"CmdStatus"] isEqualToString:@"Approved"]) {
      
      // Approved logic here
      
    } else {
      
      // Declined logic here
      
    }
    
}
```

##Step 2: Display HostedCheckout

Display the HostedCheckout Web page in a UIWebView control. The URL ends with the PaymentID returned from the initialize payment response.
  
```objC
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [_viewWeb setOpaque:NO];
    [_viewWeb setBackgroundColor:[UIColor clearColor]];
    
    NSString *pidURL = [NSString stringWithFormat:@"https://hc.mercurydev.net/CheckoutPOSiframe.aspx?pid=%@", appDelegate.pid];

    NSURL *url = [NSURL URLWithString:pidURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_viewWeb loadRequest:requestObj];  
```

Listen to the shouldStartLoadWithRequest of the UIWebViewDelegate to determine if the user completed or cancelled the transaction.

```objC
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
```

##Step 3: Verify Payment

To simplify our web service calls we have created an HCMercuryHelper library to submit, process, and parse the responses.

###Submit: Build Request with Key Value Pairs
  
Create a NSMutableDictionary and add all the Key Value Pairs.
  
```objC
    NSMutableDictionary *dictionaryReq = [NSMutableDictionary new];
    [dictionaryReq setObject:@"018847445761734" forKey:@"MerchantID"];
    [dictionaryReq setObject:appDelegate.pid forKey:@"PaymentID"];
```
  
###Process: Process the Transaction

Create HCMercuryHelper object and call the verifyPaymentFromDictionary method with the NSMutalbeDictionary and merchant's password.

```objC
    HCMercuryHelper *mgh = [HCMercuryHelper new];
    mgh.delegate = self;
    [mgh verifyPaymentFromDictionary:dictionaryReq andPassword:@"xyz"];
```

###Parse: Parse the Response

Parse the Response using in the hcTransactionDidFinish delegate.

Approved transactions will have a CmdStatus equal to "Approved".

```objC
-(void) hcTransactionDidFinish:(NSDictionary *)result {
    
    if ([result objectForKey:@"CmdStatus"]
      && [[result objectForKey:@"CmdStatus"] isEqualToString:@"Approved"]) {
      
      // Approved logic here
      
    } else {
      
      // Declined logic here
      
    }
    
}
```

###©2013 Mercury Payment Systems, LLC - all rights reserved.

Disclaimer:
This software and all specifications and documentation contained herein or provided to you hereunder (the "Software") are provided free of charge strictly on an "AS IS" basis. No representations or warranties are expressed or implied, including, but not limited to, warranties of suitability, quality, merchantability, or fitness for a particular purpose (irrespective of any course of dealing, custom or usage of trade), and all such warranties are expressly and specifically disclaimed. Mercury Payment Systems shall have no liability or responsibility to you nor any other person or entity with respect to any liability, loss, or damage, including lost profits whether foreseeable or not, or other obligation for any cause whatsoever, caused or alleged to be caused directly or indirectly by the Software. Use of the Software signifies agreement with this disclaimer notice.
