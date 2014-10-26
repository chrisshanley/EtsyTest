//
//  SearchResultsCell.h
//  EtsyTest
//
//  Created by christopher shanley on 10/26/14.
//  Copyright (c) 2014 christopher shanley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EtsySearchResult.h"

@interface SearchResultsCell : UICollectionViewCell


//memory managed by view controller
-(void)render;

@property(nonatomic, weak)EtsySearchResult *results;

@end
