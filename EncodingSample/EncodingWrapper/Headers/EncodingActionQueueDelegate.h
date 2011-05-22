//
//  EncodingActionQueueDelegate.h
//  EncodingWrapper
//
//  Created by Tamas Zsar on 2011.04.17..
//  Copyright 2011 encoding.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EncodingAction;
@class EncodingActionQueue;

@protocol EncodingActionQueueDelegate <NSObject>
@required
- (void)encodingActionQueue:(EncodingActionQueue*)queue didFinishAction:(EncodingAction*)action withResult:(NSDictionary*)result;
- (void)encodingActionQueue:(EncodingActionQueue*)queue didFailAction:(EncodingAction*)action withError:(NSError*)error;

@end
