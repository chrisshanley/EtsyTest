//
//  SSRequestFactory.m
//  NetworkingFramework
//
//  Created by Chris on 8/25/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

#import "RequestFactory.h"

@interface RequestFactory()
-(NSString *)toQueryString:(NSDictionary *)params;
-(NSMutableURLRequest *)addFormEncodedParams:(NSDictionary *)params toRequest:(NSMutableURLRequest *)req encodingType:(HTTPRequestEncodingType)type;
@end

@implementation RequestFactory

-(id)initWithAPIHost:(NSString *)host andAuthTokenOrNil:(NSString *)authToken
{
    self = [super init];
    if( self )
    {
        _authtoken = authToken;
        _apiHost   = host;
    }
    return self;
}

-(NSURLRequest *)createRequestForEndpoint:(NSString *)endpoint method:(HTTPMethod )method params:(NSDictionary *)params encoding:(HTTPRequestEncodingType)encoding;
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.apiHost, endpoint];
    NSURL    *url       = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setHTTPMethod:[RequestFactory httpMethodString:method]];
    if( self.authtoken )
    {
        [request setValue:[NSString stringWithFormat:@"Bearer %@", self.authtoken] forHTTPHeaderField:@"Authorization"];
    }
    
    NSError  *encodingError;
    
    if( params )
    {
        switch (encoding )
        {
            case kJSONEncoding:
                [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&encodingError]];
                [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                break;
            default:
                request = [self addFormEncodedParams:params toRequest:request encodingType:encoding];
                break;
        }
        
    }
    
    return request;
}

-(NSMutableURLRequest *)addFormEncodedParams:(NSDictionary *)params toRequest:(NSMutableURLRequest *)req encodingType:(HTTPRequestEncodingType)type
{
    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    [req setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    NSString *queryString = [self toQueryString:params];
    
    switch (type) {
        case kFormEncoding:
            [req setHTTPBody:[queryString dataUsingEncoding:NSUTF8StringEncoding]];
            break;
            
        default:
            [req setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", req.URL.absoluteString, queryString]]];
            break;
    }
    
    return req;
}
         
-(NSMutableURLRequest *)encodeParams:(NSDictionary *)params forEncoding:(HTTPRequestEncodingType)encoding forRequest:(NSMutableURLRequest *)req
{
    NSError  *encodingError;
    switch (encoding )
    {
        case kJSONEncoding:
            [req setHTTPBody:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&encodingError]];
            [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            break;
        default:
            req = [self addFormEncodedParams:params toRequest:req encodingType:encoding];
            break;
    }
    return req;
}

+(NSString *)httpMethodString:(HTTPMethod)method
{
    NSString *stringName;
    switch (method)
    {
        case kDELETE:
            stringName = @"DELETE";
            break;
        case kGET:
            stringName = @"GET";
            break;
        case kPOST:
            stringName = @"POST";
            break;
        case kPUT:
            stringName = @"PUT";
            break;
    }
    return stringName;
}

-(NSString *)toQueryString:(NSDictionary *)params
{
    NSString       *value;
    NSString       *pair;
    NSMutableArray *values = [NSMutableArray array];
    
    for( NSString *key in params)
    {
        value = params[key];
        //likely there is a better way to encode a URL safe string but this works for a basic character set
        pair  = [NSString stringWithFormat:@"%@=%@", key, [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        [values addObject:pair];
    }
    
    return  [values componentsJoinedByString:@"&"];
}

@end
