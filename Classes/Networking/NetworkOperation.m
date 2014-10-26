    //
//  NetworkOperation.m
//  NetworkingFramework
//
//  Created by Chris on 8/20/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

#import "NetworkOperation.h"

@interface NetworkOperation()

@end

typedef void (^ServiceCompleteHandler) (NSData *data, NSURLResponse *response, NSError *error);

@implementation NetworkOperation


-(instancetype)initWithRequest:(NSURLRequest *)request andSession:(NSURLSession *)session
{
    self = [super init];
    if( self )
    {
        _request = request;
        _session = session;
        _ready   = NO;
    }
    return self;
}

-(BOOL)isConcurrent
{
    return YES;
}

-(BOOL)isFinished
{
    return _finished;
}

-(BOOL)isExecuting
{
    return _executing;
}

-(BOOL)isReady
{
    return _ready;
}

-(void)setIsReady:(BOOL)value
{
    [self willChangeValueForKey:@"isReady"];
    _ready = value;
    [self didChangeValueForKey:@"isReady"];
}

-(void)operationAboutToStart
{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

-(TaskResponseHandler)taskResponseHandler
{
    __weak NetworkOperation *weakself = self;
    
    ServiceCompleteHandler handler = ^(NSData *data, NSURLResponse *response, NSError *error)
    {
        if( error )
        {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            [weakself handleErrorOrNil:error responseOrNil:httpResponse];
        }
        else
        {
            [weakself handleResponse:data response:response];
        }
    };
    
    return handler;
}

-(void)start
{
    [self operationAboutToStart];
    _sessionTask = [self.session dataTaskWithRequest:self.request completionHandler:self.taskResponseHandler];
    [_sessionTask resume];
}

-(void)main
{
    NSLog(@"%@ main" , self);
}

-(void)cancel
{
    [_sessionTask cancel];
    [super cancel];
}

-(void)handleResponse:(NSData *)data response:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    switch (httpResponse.statusCode)
    {
        case 200:
        case 201:
        case 202:
        case 203:
            _resultData = data;
            [self willChangeValueForKey:@"isExecuting"];
            _executing = NO;
            [self didChangeValueForKey:@"isExecuting"];
            [self willChangeValueForKey:@"isFinished"];
            _finished = YES;
            [self didChangeValueForKey:@"isFinished"];
            break;
        default:
            // TODO : create error object here
            break;
    }
}

-(void)handleErrorOrNil:(NSError *)error responseOrNil:(NSHTTPURLResponse *)httpresponse
{
    
    // TO DO : better error management ideally this class will be assess the content of the json as well as
    // NSHTTPURLResponse object to determine if this was a successfull request. Its often in ( oauth ) you can get
    // a 200 response code with an error message of "invalid user name" , this is to help with those custom cases
    
  //  NSAssert( (error && httpresponse), @"<SSNetworkOperation:> A valild cocoa error or an HTTP Response ( NSURLHTTPResponse  ) is required to create an error object");
    _error = [[NetworkError alloc]initWithResponseObject:httpresponse andErrorOrNil:error];
}

@end
