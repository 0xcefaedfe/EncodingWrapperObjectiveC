//
//  EncodingActionDelegate.h
//  EncodingWrapper
//
//  Created by Tamas Zsar on 2011.04.19..
//  Copyright 2011 encoding.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EncodingAction;

@protocol EncodingActionDelegate <NSObject>
@required
- (void)encodingAction:(EncodingAction*)action didFinishRunningWithResults:(NSDictionary*)results;
- (void)encodingAction:(EncodingAction*)action didFailWithError:(NSError*)error;

@end
