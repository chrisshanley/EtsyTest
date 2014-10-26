//
//  SSNetworkError.h
//  NetworkingFramework
//
//  Created by Chris on 8/20/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkError : NSObject

-(instancetype)initWithResponseObject:(NSHTTPURLResponse *)response andErrorOrNil:(NSError *)error;

// Placeholder for now, needs logic to determine this , as well as all the rest of its guts
@property(nonatomic, strong)NSString *userMessage;

@end
