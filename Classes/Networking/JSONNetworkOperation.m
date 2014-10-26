//
//  SSJSONNetworkOperation.m
//  NetworkingFramework
//
//  Created by Chris on 8/21/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

#import "JSONNetworkOperation.h"

@implementation JSONNetworkOperation

-(void)handleResponse:(NSData *)data response:(NSURLResponse *)response
{
    _json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    [self willChangeValueForKey:@"isExecuting"];
    _executing = NO;
    [self didChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    _finished = YES;
    [self didChangeValueForKey:@"isFinished"];
}



@end
