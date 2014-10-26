//
//  EtsyAPIClient.m
//  EtsyTest
//
//  Created by christopher shanley on 10/26/14.
//  Copyright (c) 2014 christopher shanley. All rights reserved.
//

#import "EtsyAPIClient.h"
#import "SessionManager.h"
#import "RequestFactory.h"
#import "JSONNetworkOperation.h"

@interface EtsyAPIClient()
@property(nonatomic, strong)RequestFactory *factory;

@end

@implementation EtsyAPIClient

-(instancetype)initWithAuthToken:(NSString *)token andHost:(NSString *)apihost
{
    
    if( self != nil )
    {
        _clientOperations = [[NSOperationQueue alloc]init];
        _host  = apihost;
        _token = token;
        self.factory = [[RequestFactory alloc]initWithAPIHost:self.host andAuthTokenOrNil:nil];
    
    }
    return self;
}


-(void)searchForListings:(NSDictionary *)params withBlock:(SearchCompleteBlock )block
{
    self.completeBlock = block;
    NSMutableDictionary *authenticatedParams = params.mutableCopy;
    [authenticatedParams setValue:self.token forKeyPath:@"api_key"];
    
    NSURLRequest *request = [self.factory createRequestForEndpoint:kSEARCH_ENDPOITN method:kGET params:authenticatedParams encoding:kQueryString];
    
    JSONNetworkOperation *op = [[JSONNetworkOperation alloc]initWithRequest:request andSession:[SessionManager sharedSessionManager ].defaultSession];
    
    __weak JSONNetworkOperation *weakoperation = op;
    __weak EtsyAPIClient        *weakclient    = self;
    [op setCompletionBlock:^
    {
        
        NSDictionary *json = [weakoperation.json copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            if( weakoperation.error)
            {
                [weakclient handleSearchFailed];
            }
            else
            {
                [weakclient handleSearchServiceLoaded:json];
            }
     
        });
    }];
    [self.clientOperations addOperation:op];
    [op setIsReady:YES];
}

-(void)handleSearchServiceLoaded:(NSDictionary *)json
{
    if( self.completeBlock )
    {
        self.completeBlock( json );
    }
}

-(void)handleSearchFailed
{
    if( self.failedBlock )
    {
        self.failedBlock();
    }
}


@end
