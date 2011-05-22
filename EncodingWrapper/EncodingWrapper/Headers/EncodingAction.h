//
//  EncodingAction.h
//  EncodingWrapper
//
//  Created by Tamas Zsar on 2011.04.17..
//  Copyright 2011 encoding.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EncodingActionDelegate.h"

#define BASE_URL @"https://manage.encoding.com"

@interface EncodingAction : NSObject {	
	id<EncodingActionDelegate> _delegate;
	NSMutableDictionary *_parameters;
	NSString *_xmlString;
	
	NSMutableData *_data;
	NSURLConnection *_connection;
}

// properties
@property (nonatomic, assign) id<EncodingActionDelegate> delegate;
@property (nonatomic, retain) NSString *xmlString;
@property (nonatomic, retain) NSMutableDictionary *parameters;

// methods
- (id)initWithDelegate:(id<EncodingActionDelegate>)delegate;
- (void)start;
- (void)sendXMLQuery:(NSString*)xmlQuery;
- (NSString*)generateXMLString;
- (void)cancel;

@end
