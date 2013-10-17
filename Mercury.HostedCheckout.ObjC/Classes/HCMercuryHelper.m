//
//  MercurySOAPHelper.m
//  CallMercuryHostedCheckoutWebService
//
//  Created by Kevin Oliver on 5/16/13.
//  Copyright (c) 2013 Kevin Oliver. All rights reserved.
//

#import "HCMercuryHelper.h"

@implementation HCMercuryHelper

// Change this URL to https://hc.mercurypay.com/hcws/hcservice.asmx when running transactions against production Hosted Checkout Web service

static NSString *const MERCURY_WEB_SERVICE_URL = @"https://hc.mercurydev.net/hcws/hcservice.asmx";

static int          _numberOfPasses = 0;
NSMutableData       *_conWebData;
NSMutableString     *_soapResults;
NSString            *_hcTransactionResult;
NSMutableDictionary *_dict;
NSString            *_currentElement;
NSXMLParser         *_xmlParser;
static BOOL         _recordResults = NO;
NSMutableString     *_hctransactionType;
NSString            *_noCaps;

-(void) initializePaymentFromDictionary:(NSDictionary *)dictionary andPassword:(NSString *)password {
    
    NSString *soapMessage = [self buildInitializePaymentFromDictionary:dictionary andPassword:password];
    NSURL *url = [NSURL URLWithString:MERCURY_WEB_SERVICE_URL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    NSString *soapAction = [NSString stringWithFormat:@"http://www.mercurypay.com/%@", @"InitializePayment"];
    [theRequest addValue: soapAction forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection ) {
        _conWebData = [NSMutableData data];
    }
    else {
        NSLog(@"theConnection is NULL");
    }
    
}

-(void) verifyPaymentFromDictionary:(NSDictionary *)dictionary andPassword:(NSString *)password {
    
    NSString *soapMessage = [self buildVerifyPaymentFromDictionary:dictionary andPassword:password];
    NSURL *url = [NSURL URLWithString:MERCURY_WEB_SERVICE_URL];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    NSString *soapAction = [NSString stringWithFormat:@"http://www.mercurypay.com/%@", @"VerifyPayment"];
    [theRequest addValue: soapAction forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection ) {
        _conWebData = [NSMutableData data];
    }
    else {
        NSLog(@"theConnection is NULL");
    }
    
}

- (NSString *)buildInitializePaymentFromDictionary:(NSDictionary *)dict andPassword:(NSString *)password {
    
    NSMutableString *hcSoap = [NSMutableString string];
    [hcSoap appendFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"http://www.mercurypay.com/\">\n"];
    [hcSoap appendFormat:@"<soapenv:Header/>\n"];
    [hcSoap appendFormat:@"<soapenv:Body>\n"];
    [hcSoap appendFormat:@"<InitializePayment>\n"];
    [hcSoap appendFormat:@"<request>\n"];
    [hcSoap appendFormat:@"<Password>%@</Password>\n", password];
    
    for (NSString *key in [dict allKeys]) {
        [hcSoap appendFormat:@"<%@>%@</%@>\n", key, [dict objectForKey:key], key];
    }
                        
    [hcSoap appendFormat:@"</request>\n"];
    [hcSoap appendFormat:@"</InitializePayment>\n"];
    [hcSoap appendFormat:@"</soapenv:Body>\n"];
    [hcSoap appendFormat:@"</soapenv:Envelope>\n"];
    
    return hcSoap;
     
}

- (NSString *)buildVerifyPaymentFromDictionary:(NSDictionary *)dict andPassword:(NSString *)password {
    
    NSMutableString *hcSoap = [NSMutableString string];
    [hcSoap appendFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns=\"http://www.mercurypay.com/\">\n"];
    [hcSoap appendFormat:@"<soapenv:Header/>\n"];
    [hcSoap appendFormat:@"<soapenv:Body>\n"];
    [hcSoap appendFormat:@"<VerifyPayment>\n"];
    [hcSoap appendFormat:@"<request>\n"];
    [hcSoap appendFormat:@"<Password>%@</Password>\n", password];
    
    for (NSString *key in [dict allKeys]) {
        [hcSoap appendFormat:@"<%@>%@</%@>\n", key, [dict objectForKey:key], key];
    }
    
    [hcSoap appendFormat:@"</request>\n"];
    [hcSoap appendFormat:@"</VerifyPayment>\n"];
    [hcSoap appendFormat:@"</soapenv:Body>\n"];
    [hcSoap appendFormat:@"</soapenv:Envelope>\n"];
    
    return hcSoap;
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_conWebData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_conWebData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.delegate performSelector:@selector(hcTransactionDidFailWithError:) withObject:error];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _numberOfPasses = 1;
    _xmlParser = [[NSXMLParser alloc] initWithData: _conWebData];
    [_xmlParser setDelegate: self];
    [_xmlParser setShouldResolveExternalEntities: YES];
    [_xmlParser parse];
}

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    _numberOfPasses += 1;
    _dict = [[NSMutableDictionary alloc] init];
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName   attributes: (NSDictionary *)attributeDict
{
    if (_numberOfPasses == 1)
    {
       NSString *hctransactionResult = @"InitializePaymentResult";
        
        if( [elementName isEqualToString:hctransactionResult])
        {
            if(!_soapResults)
            {
                _soapResults = [[NSMutableString alloc] init];
            }
            _recordResults = YES;
        }
    }
    else
    {
        _currentElement = elementName;
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (_numberOfPasses == 1)
    {
        if(_recordResults)
        {
            [_soapResults appendString: string];
        }
    }
    else
    {
        [_soapResults appendString: string];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (_numberOfPasses == 1)
    {
        NSString *hctransactionResult = [NSString stringWithFormat:@"InitializePaymentResult"];
        
        if([elementName isEqualToString:hctransactionResult])
        {
            _hcTransactionResult = _soapResults;
            _hcTransactionResult = [_hcTransactionResult stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
            _hcTransactionResult = [_hcTransactionResult stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

            _recordResults = NO;
        }
    }
    else
    {
        if ([elementName isEqualToString:_currentElement]
            && ![_soapResults hasPrefix:@"<"])
        {
            NSString *value = [_soapResults stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [_dict setObject:value forKey:_currentElement];
        }
    }
    
    _soapResults = nil;
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (_numberOfPasses == 1)
    {
        NSData *data = [_hcTransactionResult dataUsingEncoding:NSUTF8StringEncoding];
        _xmlParser = [[NSXMLParser alloc] initWithData: data];
        [_xmlParser setDelegate: self];
        [_xmlParser setShouldResolveExternalEntities: YES];
        [_xmlParser parse];
        _numberOfPasses += 1;
    }
    else
    {
        [self.delegate performSelector:@selector(hcTransactionDidFinish:) withObject:_dict];
    }
    
}

@end