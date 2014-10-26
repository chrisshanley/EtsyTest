//
//  EtsySearchResult.m
//  EtsyTest
//
//  Created by christopher shanley on 10/26/14.
//  Copyright (c) 2014 christopher shanley. All rights reserved.
//

#import "EtsySearchResult.h"

@implementation EtsySearchResult

-(id)initWithServerJSON:(NSDictionary *)json
{
    self = [super init];
    if( self )
    {
        /*  
         in an produciton environment, we should have some server JSON validation to 
         handle missing key/value pairs and or bad content or missing URLS
         */
        _listingBitmapURL = [NSURL URLWithString:json[@"MainImage"][@"url_570xN"]];
        _listingTitle     = json[@"title"];
    }
    return self;
}

@end
