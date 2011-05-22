//
//  EncodingActionQueue.m
//  EncodingWrapper
//
//  Created by Tamas Zsar on 2011.04.17..
//  Copyright 2011 encoding.com. All rights reserved.
//

#import "EncodingActionQueue.h"

@interface EncodingActionQueue (PrivateMethods)
- (void)nextAction;
@end

@implementation EncodingActionQueue
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark initializers

- (id)init {
	if ((self = [super init])) {
		_queue = [[NSMutableArray alloc] init];
	}
	return self;
}

- (id)initWithDelegate:(id<EncodingActionQueueDelegate>)delegate {
	if ((self = [self init])) {
		self.delegate = delegate;
	}
	return self;
}

#pragma mark -
#pragma mark the beef

- (void)addAction:(EncodingAction*)action {
	// force the action to notify us
	[action setDelegate:self];

	[_queue addObject:action];	
	if (_currentAction == nil) {
		_currentAction = [_queue objectAtIndex:0];
	}
}

- (void)removeAction:(EncodingAction*)action {
	[_queue removeObject:action];
}

- (NSUInteger)numberOfActions {
	return [_queue count];
}

- (EncodingAction*)actionInProgress {
	return _currentAction;
}

- (void)start {
	_currentAction = [_queue objectAtIndex:0];

	if (_currentAction == nil) {
		return;
	}
	
	[_currentAction start];
}

- (void)stop {
	[_currentAction cancel];
	[_queue removeAllObjects];
}

- (void)pause {
	[_currentAction cancel];
}

- (void)resume {
	[_currentAction start];
}

- (void)nextAction {
	[self removeAction:_currentAction];
	[self start];	
}

#pragma mark -
#pragma mark EncodingActionDelegate

- (void)encodingAction:(EncodingAction *)action didFinishRunningWithResults:(NSDictionary *)results {
	// notify delegate
	if ([_delegate respondsToSelector:@selector(encodingActionQueue:didFinishAction:withResult:)]) {
		[_delegate encodingActionQueue:self didFinishAction:action withResult:results];
	}
	
	// start next action
	[self nextAction];
}

- (void)encodingAction:(EncodingAction *)action didFailWithError:(NSError *)error {
	// notify delegate
	if ([_delegate respondsToSelector:@selector(encodingActionQueue:didFailAction:withError:)]) {
		[_delegate encodingActionQueue:self didFailAction:action withError:error];
	}
	
	// start next action
	[self nextAction];
}

#pragma mark -
#pragma mark memory management

- (void)dealloc {
	[_queue release];
	[super dealloc];
}

@end
