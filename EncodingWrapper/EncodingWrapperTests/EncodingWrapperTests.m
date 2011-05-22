//
//  EncodingWrapperTests.m
//  EncodingWrapperTests
//
//  Created by Tamas Zsar on 2011.04.30..
//  Copyright 2011 encoding.com. All rights reserved.
//

#import "EncodingWrapperTests.h"

NSString *const userId = @"[USERID]";
NSString *const userKey = @"[USERKEY]";
NSString *const source = @"[SOURCE]";
NSString *const destination = @"[DESTINATION]";
NSString *const notify = @"[NOTIFY]";

@implementation EncodingWrapperTests

#pragma mark -
#pragma mark test cases

- (void)testXMLGeneration {
	// create the parameters dictionary
	NSMutableDictionary *parameters = [self addMediaDictionary];
	// create the action
	EncodingAction *action = [[EncodingAction alloc] initWithDelegate:nil];
	action.parameters = parameters;

	// check if xml is generated from the dictionary
	NSString *generatedXMLString = nil;
	generatedXMLString = [action generateXMLString];
	STAssertNotNil(generatedXMLString, @"XML string is nil");
	
	// check if xml is correct (based on the parameters)
	NSString *shouldBeXMLString = @"<?xml version=\"1.0\"?><query><userid>[USERID]</userid><action>AddMedia</action><userkey>[USERKEY]</userkey><instant>no</instant><format><destination>[DESTINATION]</destination><output>iphone_stream</output></format></query>";
	STAssertTrue([generatedXMLString isEqualToString:shouldBeXMLString], @"generated xml string is not correct");

	[action release];
}

- (void)testAddActionToQueue {
	// test if queue has one item
	STAssertEquals([_queue numberOfActions], 1u, @"action is not added to the queue");
	
	// test if action is the next one
	STAssertNotNil([_queue actionInProgress], @"action is not set as current action");
	STAssertEqualObjects([_queue actionInProgress], _action, @"current action is not the test object");
}

- (void)testRemoveActionFromQueue {
	// get current action
	EncodingAction *action = [_queue actionInProgress];
	
	// test if we have current action
	STAssertNotNil(action, @"no current action");

	// remove action
	[_queue removeAction:action];

	// test if queue has no items
	STAssertEquals([_queue numberOfActions], 0u, @"action is not removed from the queue");
	
	// test if current action is removed
	STAssertNil([_queue actionInProgress], @"current action is not nil");
}

- (NSMutableDictionary*)addMediaDictionary {
	NSMutableDictionary *format = [NSMutableDictionary dictionary];
	[format setObject:@"iphone_stream" forKey:@"output"];
	[format setObject:destination forKey:@"destination"];
	
	NSMutableDictionary *query = [NSMutableDictionary dictionary];
	[query setObject:format forKey:@"format"];
	[query setObject:userId forKey:@"userid"];
	[query setObject:userKey forKey:@"userkey"];
	[query setObject:@"AddMedia" forKey:@"action"];
	[query setObject:@"no" forKey:@"instant"];
	
	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	[parameters setObject:query forKey:@"query"];
	return parameters;
}

#pragma mark -
#pragma mark setup and teardown

- (void)setUp {
	[super setUp];    
	_queue = [[EncodingActionQueue alloc] initWithDelegate:nil];
	
	NSMutableDictionary *parameters = [self addMediaDictionary];
	
	_action = [[EncodingAction alloc] initWithDelegate:nil];
	_action.parameters = parameters;
	
	[_queue addAction:_action];	
}

- (void)tearDown {
	[super tearDown];
	[_queue release];
}

@end
