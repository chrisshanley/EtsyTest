//
//  iPadSearchViewController.h
//  EtsyTest
//
//  Created by christopher shanley on 10/26/14.
//  Copyright (c) 2014 christopher shanley. All rights reserved.
//

#import "SearchViewController.h"

@interface iPadSearchViewController : SearchViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)IBOutlet UICollectionView *collectionView;
@end
