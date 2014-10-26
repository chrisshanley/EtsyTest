//
//  SearchViewController.m
//  EtsyTest
//
//  Created by christopher shanley on 10/26/14.
//  Copyright (c) 2014 christopher shanley. All rights reserved.
//

#import "SearchViewController.h"
#import "EtsyAPIClient.h"
#import "AppDelegate.h"
#import "EtsySearchResult.h"

@interface SearchViewController ()<UISearchBarDelegate>


@property(nonatomic, strong)EtsyAPIClient  *client;

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _searchResults = [NSMutableArray array];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _searchResults = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _searchBar                    = [[UISearchBar alloc]initWithFrame:CGRectZero];
    
    self.client                   = [[EtsyAPIClient alloc]initWithAuthToken:AUTH_TOKEN andHost:API_HOST];
    self.currentPage              = 1;
    self.searchBar.delegate       = self;
    self.navigationItem.titleView = self.searchBar;
    UIBarButtonItem *item         = [[UIBarButtonItem alloc]initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(performSearch)];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - search
-(void)enterKeyword
{
    [self.searchBar resignFirstResponder];
    self.currentPage = 1;
    [self.searchResults removeAllObjects];
}

-(void)performSearch
{
    /*
     In an production environment, we should check and alret the user to connectivity issues 
     and also dispaly a loading icon or progress bar being the API takes several second to resond on home WIFI
     */
    __weak SearchViewController *weakself = self;
    
    NSDictionary *params = @{@"includes":@"MainImage", @"keywords":self.searchBar.text, @"page" : [NSString stringWithFormat:@"%ld", (long)self.currentPage] } ;
    [self.client searchForListings:params withBlock:^(NSDictionary *json) {
        if( json )
        {
           
            [weakself handleResultsLoaded:[weakself formatResults:json]];
        }
        else
        {
            [weakself showErrorMessage];
        }
    }];
}

-(NSArray *)formatResults:(NSDictionary *)serverResonse
{
    NSArray *reslts = serverResonse[@"results"];
    EtsySearchResult *result;
    NSMutableArray   *newItems = [NSMutableArray array];
    
    for( NSDictionary *info in reslts)
    {
        result = [[EtsySearchResult alloc]initWithServerJSON:info];
        [newItems addObject:result];
    }
    return newItems;
}

// override me
-(void)handleResultsLoaded:(NSArray *)newItems
{
    
}

-(void)showErrorMessage
{
    /*
     error message would be localized strings in an production environment 
     */
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"whoops" message:@"we are having API issues, sorry" delegate:nil cancelButtonTitle:@"bummer" otherButtonTitles:nil];
    [av show];
}

#pragma mark - search bar delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self enterKeyword];
    [self performSearch];
}

@end
