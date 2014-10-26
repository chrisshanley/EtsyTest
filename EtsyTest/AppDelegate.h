//
//  AppDelegate.h
//  EtsyTest
//
//  Created by christopher shanley on 10/26/14.
//  Copyright (c) 2014 christopher shanley. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EtsyAPIClient.h"

// NOTE : would likely go in some constants or config file vs in app code normally
#define AUTH_TOKEN @"liwecjs0c3ssk6let4p1wqt9"
#define API_HOST   @"https://api.etsy.com"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
