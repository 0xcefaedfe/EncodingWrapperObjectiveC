//
//  EncodingActionQueue.h
//  EncodingWrapper
//
//  Created by Tamas Zsar on 2011.04.17..
//  Copyright 2011 encoding.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EncodingAction.h"
#import "EncodingActionQueueDelegate.h"

@interface EncodingActionQueue : NSObject <EncodingActionDelegate> {
	NSMutableArray *_queue;
	EncodingAction *_currentAction;
	id<EncodingActionQueueDelegate> _delegate;
}

// properties
@property (nonatomic, assign) id<EncodingActionQueueDelegate> delegate;

// methods
- (id)initWithDelegate:(id<EncodingActionQueueDelegate>)delegate;
- (void)addAction:(EncodingAction*)action;
- (void)removeAction:(EncodingAction*)action;
- (NSUInteger)numberOfActions;
- (EncodingAction*)actionInProgress;
- (void)start;
- (void)stop;
- (void)pause;
- (void)resume;

@end
