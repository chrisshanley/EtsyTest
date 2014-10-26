//
//  SearchViewController.h
//  EtsyTest
//
//  Created by christopher shanley on 10/26/14.
//  Copyright (c) 2014 christopher shanley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

//called when the keyword has been changed
-(void)enterKeyword;
// when you hit the search button or you the user srolls to the next page
-(void)performSearch;
// yay theres new stuff to sell. get them in the list asap.
-(void)handleResultsLoaded:(NSArray *)newItems;

// incrememnt this value before calling -(void)performSearch if you want this to get new stuff to sell
@property(nonatomic, assign)NSInteger                 currentPage;
// this may be better implemented with a search results controller or some other UIKit componented this will work for educational purposes
@property(nonatomic, strong, readonly)UISearchBar    *searchBar;
// array of EtsySearchResult objects 
@property(nonatomic, strong, readonly)NSMutableArray *searchResults;
@end
