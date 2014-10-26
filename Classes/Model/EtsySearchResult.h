//
//  EtsySearchResult.h
//  EtsyTest
//
//  Created by christopher shanley on 10/26/14.
//  Copyright (c) 2014 christopher shanley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EtsySearchResult : NSObject


-(id)initWithServerJSON:(NSDictionary *)json;

@property(nonatomic, strong)NSString   *listingTitle;
@property(nonatomic, strong)NSURL      *listingBitmapURL;

@end
