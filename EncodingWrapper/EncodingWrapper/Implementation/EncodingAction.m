//
//  EncodingAction.m
//  EncodingWrapper
//
//  Created by Tamas Zsar on 2011.04.17..
//  Copyright 2011 encoding.com. All rights reserved.
//

#import "EncodingAction.h"
#import "XMLDictionary.h"

@implementation EncodingAction
@synthesize delegate = _delegate;
@synthesize parameters = _parameters;
@synthesize xmlString = _xmlString;

#pragma mark -
#pragma mark initializers

- (EncodingAction*)initWithDelegate:(id<EncodingActionDelegate>)delegate {
	if ((self = [super init])) {
		self.delegate = delegate;
	}
	return self;
}

#pragma mark -
#pragma mark methods

- (void)start {
	// if we don't have the XML string yet we generate it from the parameters dictionary
	if (_xmlString == nil) {
		self.xmlString = [self generateXMLString];
	}
	DLog(@"[D] starting action");
	[self sendXMLQuery:_xmlString];
}

- (void)sendXMLQuery:(NSString *)xmlQuery {
	DLog(@"[D] send XML query");
	if ([_delegate respondsToSelector:@selector(encodingAction:didFailWithError:)]) {
		
	}
	// stop previous connection
	[self cancel];
	
	// prepare new request
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:BASE_URL]];
	[request setHTTPMethod:@"POST"];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	
	// create data
	_data = [[NSMutableData alloc] init];
	
	// create new connection
	_connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	// start connection
	[_connection start];
}

- (void)cancel {
	// cancel connection
	[_connection cancel];
	[_connection release];	
	
	// cleanup data
	[_data release];
}

#pragma mark -
#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	DLog(@"[D] received data");
	[_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	DLog(@"[E] action failed with error: %@", error);
	if ([_delegate respondsToSelector:@selector(encodingAction:didFailWithError:)]) {
		[_delegate encodingAction:self didFailWithError:error];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	// parse response
	NSString *responseString = [[NSString alloc] initWithBytes:[_data bytes] length:[_data length] encoding:NSUTF8StringEncoding];
	
	// create response dictionary
	NSDictionary *results = nil;
	results = [XMLDictionary dictionaryForXMLString:responseString];
														
	DLog(@"[D] action received response: %@", responseString);
	if ([_delegate respondsToSelector:@selector(encodingAction:didFinishRunningWithResults:)]) {
		[_delegate encodingAction:self didFinishRunningWithResults:results];
	}
}

#pragma mark -
#pragma mark parameters methods

- (NSString*)generateXMLString {
	return [NSString stringWithFormat:@"<?xml version=\"1.0\"?>%@", [XMLDictionary XMLStringForDictionary:_parameters]];
}

#pragma mark -
#pragma mark memory management

- (void)dealloc {
	[self cancel];
	self.xmlString = nil;
	self.delegate = nil;
	self.parameters = nil;
	[super dealloc];
}

@end
