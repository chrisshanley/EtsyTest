//
//  SSSessionManager.m
//  NetworkingFramework
//
//  Created by Chris on 8/20/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

#import "SessionManager.h"

@interface SessionManager()<NSURLSessionDelegate, NSURLSessionDataDelegate>
@property(nonatomic, strong)NSHashTable *weakReferencedObservers;
@end

@implementation SessionManager

+(SessionManager *)sharedSessionManager
{
    static SessionManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        instance =  [[SessionManager alloc]init];
        
    });
    return instance;
}

-(id)init
{
    self = [super init];
    if( self )
    {
        
        _defaultSession                = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _networkActivityOperationQueue = [[NSOperationQueue alloc]init];
        _weakReferencedObservers       = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

@end
