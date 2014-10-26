//
//  NetworkOperation.h
//  NetworkingFramework
//
//  Created by Chris on 8/20/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkError.h"

// Internal usage only
typedef void (^TaskResponseHandler) (NSData *data, NSURLResponse *response, NSError *error);

@interface NetworkOperation : NSOperation
{
    NSURLSessionTask *_sessionTask;
    BOOL _finished;
    BOOL _executing;
    BOOL _ready;
}

-(instancetype)initWithRequest:(NSURLRequest *)request andSession:(NSURLSession *)session;
-(void)handleErrorOrNil:(NSError *)error responseOrNil:(NSHTTPURLResponse *)httpresponse;
-(void)handleResponse:(NSData *)data response:(NSURLResponse *)response;
-(void)setIsReady:(BOOL)value;

@property(nonatomic, copy,   readonly)TaskResponseHandler taskResponseHandler;
@property(nonatomic, strong, readonly)NSURLRequest        *request;
@property(nonatomic, weak ,  readonly)NSURLSession        *session;
@property(nonatomic, strong, readonly)NetworkError      *error;
@property(nonatomic, strong, readonly)NSData              *resultData;


// for inheritance ,
// call this from start override
-(void)operationAboutToStart;


@end
