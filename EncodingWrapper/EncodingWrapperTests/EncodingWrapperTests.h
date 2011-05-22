//
//  EncodingWrapperTests.h
//  EncodingWrapperTests
//
//  Created by Tamas Zsar on 2011.04.30..
//  Copyright 2011 encoding.com. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "EncodingAction.h"
#import "EncodingActionQueue.h"

@interface EncodingWrapperTests : SenTestCase {
	EncodingActionQueue *_queue;
	EncodingAction *_action;
}

- (NSMutableDictionary*)addMediaDictionary;

@end
