//
//  SearchViewController.h
//  EtsyTest
//
//  Created by christopher shanley on 10/26/14.
//  Copyright (c) 2014 christopher shanley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

-(void)enterKeyword;
-(void)performSearch;
-(void)handleResultsLoaded:(NSArray *)newItems;

@property(nonatomic, assign)NSInteger      currentPage;
@property(nonatomic, strong, readonly)UISearchBar    *searchBar;
@property(nonatomic, strong, readonly)NSMutableArray *searchResults;
@end
