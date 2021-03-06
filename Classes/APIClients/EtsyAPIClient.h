//
//  EtsyAPIClient.h
//  EtsyTest
//
//  Created by christopher shanley on 10/26/14.
//  Copyright (c) 2014 christopher shanley. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSEARCH_ENDPOITN @"/v2/listings/active"


/*
 intened as a layer between the low level code and you UIViewController subclasses
 giving the networking a more reusable interface and also giving easy access to company 
 wide API interfaces. 
 */
typedef void (^SearchCompleteBlock) (NSDictionary *json);
typedef void (^SearchFailedBlock)   ();

@interface EtsyAPIClient : NSObject

@property(nonatomic, strong, readonly)NSOperationQueue *clientOperations;
@property(nonatomic, strong, readonly)NSString *host;
@property(nonatomic, strong, readonly)NSString *token;
@property(nonatomic, copy)SearchCompleteBlock   completeBlock;
@property(nonatomic, copy)SearchFailedBlock     failedBlock;



-(instancetype)initWithAuthToken:(NSString *)token andHost:(NSString *)apihost;
-(void)searchForListings:(NSDictionary *)params withBlock:(SearchCompleteBlock)block;

@end
