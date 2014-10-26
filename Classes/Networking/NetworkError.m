//
//  SSNetworkError.m
//  NetworkingFramework
//
//  Created by Chris on 8/20/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

#import "NetworkError.h"

@implementation NetworkError


// This is a placehold class for custom error handling and parsing
// Should be extended for custom platform specific error messages

-(instancetype)initWithResponseObject:(NSHTTPURLResponse *)response andErrorOrNil:(NSError *)error
{
    self = [super init];
    if( self )
    {
        
    }
    return self;
}

@end
