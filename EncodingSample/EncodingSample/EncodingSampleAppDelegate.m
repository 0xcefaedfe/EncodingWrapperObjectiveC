//
//  EncodingSampleAppDelegate.m
//  EncodingSample
//
//  Created by Tamas Zsar on 2011.05.02..
//  Copyright 2011 encoding.com. All rights reserved.
//

#import "EncodingSampleAppDelegate.h"
#import "EncodingAction.h"

@implementation EncodingSampleAppDelegate

@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// create the parameters
	NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"AddMedia" ofType:@"xml"];
	NSError *error = nil;
	NSString *parameterString = [NSString stringWithContentsOfFile:xmlPath encoding:NSUTF8StringEncoding error:&error];
	
	if (error) {
		NSLog(@"[E] failed reading AddMedia.xml with error: %@", error);
		return NO;
	}
	
	// the AddMedia.xml file contains placeholders for some items
	// replace them with real values according to the 
	// encoding.com API documentation at http://www.encoding.com/wdocs/ApiDoc
	
	if ([parameterString rangeOfString:@"[USERID]"].location != NSNotFound ||
			[parameterString rangeOfString:@"[USERKEY]"].location != NSNotFound ||
			[parameterString rangeOfString:@"[SOURCE]"].location != NSNotFound ||
			[parameterString rangeOfString:@"[NOTIFY]"].location != NSNotFound ||
			[parameterString rangeOfString:@"[DESTINATION]"].location != NSNotFound ) {
		NSLog(@"[E] replace placeholders with real values in the AddMedia.xml file");
		return NO;
	}
	
	// create the action
	EncodingAction *addMediaAction = [[EncodingAction alloc] initWithDelegate:self];
	// you have two options to send the query from the raw xml
	// set the xmlString property...
	addMediaAction.xmlString = parameterString;
	// ...and send it when you want
	[addMediaAction start];
	
	// OR send it immediately with
	// [addMediaAction sendXMLQuery:parameterString];
	[addMediaAction release];
	
	[self.window makeKeyAndVisible];
	return YES;
}

#pragma mark -
#pragma mark EncodingActionDelegate

- (void)encodingAction:(EncodingAction *)action didFinishRunningWithResults:(NSDictionary *)results {
	NSLog(@"[D] encodingAction: %@ finished with results: %@", action, results);
}

- (void)encodingAction:(EncodingAction *)action didFailWithError:(NSError *)error {
	NSLog(@"[D] encodingAction: %@ failed with error: %@", action, error);	
}

- (void)dealloc {
	[_window release];
	[super dealloc];
}

@end
