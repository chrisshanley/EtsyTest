//
//  iPadSearchViewController.m
//  EtsyTest
//
//  Created by christopher shanley on 10/26/14.
//  Copyright (c) 2014 christopher shanley. All rights reserved.
//

#import "iPadSearchViewController.h"
#import "SearchResultsCell.h"
@interface iPadSearchViewController ()



@end

@implementation iPadSearchViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[SearchResultsCell class] forCellWithReuseIdentifier:NSStringFromClass([SearchResultsCell class])];
}

-(void)enterKeyword
{
    [self.searchResults removeAllObjects];
    [self.collectionView reloadData];
    [super enterKeyword];
}

/*
 could be an async operation depending on amount of content. 
 normally would remove loader here in the complete block
 */
-(void)handleResultsLoaded:(NSArray *)newItems
{
    __block NSIndexPath  *path;
    __block NSInteger  index = self.searchResults.count;
    NSMutableArray   *paths = [NSMutableArray array];
    
    [newItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        path = [NSIndexPath indexPathForRow:idx inSection:0];
        [paths addObject:path];
        index++;
    }];
    
    [self.searchResults addObjectsFromArray:newItems];
    
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:paths];
    } completion:^(BOOL finished) {
        self.collectionView.delegate = self;
    }];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultsCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SearchResultsCell class]) forIndexPath:indexPath];
    cell.results = self.searchResults[indexPath.row];
    [cell render];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(220, 300);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // lets not call this if we have no content
    if( self.collectionView.contentSize.height == 0 )
    {
        return;
    }
    
    NSInteger pos =  (NSInteger)(self.collectionView.contentOffset.y / (self.collectionView.contentSize.height - self.collectionView.frame.size.height));
    if( pos >= 1 )
    {
        NSLog(@"%@ -- loading next page", self);
        self.collectionView.delegate = nil;
        self.currentPage ++;
        [super performSearch];
    }
}

@end
