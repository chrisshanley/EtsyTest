//
//  SSSessionManager.h
//  NetworkingFramework
//
//  Created by Chris on 8/20/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SessionManager : NSObject<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

+(SessionManager *)sharedSessionManager;

/*
    We can create multiple sessions for background and so on
 */
@property(nonatomic, strong, readonly)NSURLSession     *defaultSession;

/*
 All network operations run through this queue, we can cancel all globally, 
 We can add multiple queues or content like, earnings, images, accounts and generic
 */
@property(nonatomic, strong, readonly)NSOperationQueue *networkActivityOperationQueue;

@end
