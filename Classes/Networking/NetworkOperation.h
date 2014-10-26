//
//  NetworkOperation.h
//  NetworkingFramework
//
//  Created by Chris on 8/20/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkError.h"

/*
 
 Abstract class that can be used directly to create a very basic http connection. 
 Based for inheritance this class is designed to be flexible and built upon for custom 
 implementatios.
 */
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

// set this when your request is ready to fire. either before or after adding to a queue
-(void)setIsReady:(BOOL)value;

// getter overide for custom competion handlers, block follows same implementation as NSURLSessionDataTask
@property(nonatomic, copy,   readonly)TaskResponseHandler taskResponseHandler;
@property(nonatomic, strong, readonly)NSURLRequest        *request;
@property(nonatomic, weak ,  readonly)NSURLSession        *session;

// custom erro object, this has not yet been implemented in the framework and is intended for overriding
@property(nonatomic, strong, readonly)NetworkError        *error;

@property(nonatomic, strong, readonly)NSData              *resultData;


// for inheritance ,
// call this from start override
-(void)operationAboutToStart;


@end
