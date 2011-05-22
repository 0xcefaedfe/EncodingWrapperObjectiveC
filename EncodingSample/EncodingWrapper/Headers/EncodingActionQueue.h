//
//  EncodingActionQueue.h
//  EncodingWrapper
//
//  Created by Tamas Zsar on 2011.04.17..
//  Copyright 2011 encoding.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EncodingAction;

@interface EncodingActionQueue : NSObject {
	NSMutableArray *_queue;
	EncodingAction *_currentAction;
}

// methods
- (void)addAction:(EncodingAction*)action;
- (void)removeAction:(EncodingAction*)action;
- (NSUInteger)numberOfActions;
- (EncodingAction*)actionInProgress;
- (void)start;
- (void)stop;
- (void)pause;
- (void)resume;

@end
