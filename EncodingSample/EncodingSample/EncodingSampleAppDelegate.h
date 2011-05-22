//
//  EncodingSampleAppDelegate.h
//  EncodingSample
//
//  Created by Tamas Zsar on 2011.05.02..
//  Copyright 2011 encoding.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EncodingActionDelegate.h"
@interface EncodingSampleAppDelegate : NSObject <UIApplicationDelegate, EncodingActionDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
