//
//  SSRequestFactory.h
//  NetworkingFramework
//
//  Created by Chris on 8/25/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    kGET,
    kPOST,
    kPUT,
    kDELETE
}HTTPMethod;

typedef enum {
    kJSONEncoding ,
    kFormEncoding,
    kQueryString

}HTTPRequestEncodingType;

@interface RequestFactory : NSObject

@property(nonatomic, readonly, strong)NSString *apiHost;
@property(nonatomic, readonly, strong)NSString *authtoken;

-(id)initWithAPIHost:(NSString *)host andAuthTokenOrNil:(NSString *)authToke;
-(NSURLRequest *)createRequestForEndpoint:(NSString *)endpoint method:(HTTPMethod )method params:(NSDictionary *)params encoding:(HTTPRequestEncodingType)encoding;
-(NSMutableURLRequest *)encodeParams:(NSDictionary *)params forEncoding:(HTTPRequestEncodingType)encoding forRequest:(NSMutableURLRequest *)req;
+(NSString *)httpMethodString:(HTTPMethod)method;
@end
