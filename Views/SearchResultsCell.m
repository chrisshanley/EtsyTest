 //
//  SearchResultsCell.m
//  EtsyTest
//
//  Created by christopher shanley on 10/26/14.
//  Copyright (c) 2014 christopher shanley. All rights reserved.
//

#import "SearchResultsCell.h"
#import "SessionManager.h"
#import "NetworkOperation.h"

@interface SearchResultsCell()

@property(nonatomic, strong)UIImageView *thumb;
@property(nonatomic, strong)UILabel         *label;
@property(nonatomic, strong)NSOperationQueue *queue;
@end


@implementation SearchResultsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // this que should likely be managed in a singleton but we will keep it simple for examples sake
        self.queue = [[NSOperationQueue alloc]init];
        
        
        self.thumb = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.thumb.contentMode = UIViewContentModeScaleAspectFill;
        self.thumb.clipsToBounds = YES;
        [self.contentView addSubview:self.thumb];
     
        self.label = [[UILabel alloc]initWithFrame:CGRectZero];
        self.label.lineBreakMode = NSLineBreakByWordWrapping;
        self.label.numberOfLines = 0;
        self.label.backgroundColor = [UIColor whiteColor];
        self.label.backgroundColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:12];
        self.label.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.label];
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if( self )
    {
        self.queue = [[NSOperationQueue alloc]init];
        
        
        self.thumb = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.thumb.contentMode = UIViewContentModeScaleAspectFill;
        self.thumb.clipsToBounds = YES;
        [self.contentView addSubview:self.thumb];
        
        
        self.label = [[UILabel alloc]initWithFrame:CGRectZero];
        self.label.numberOfLines = 0;
        self.label.lineBreakMode = NSLineBreakByWordWrapping;
        self.label.backgroundColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:15];
        self.label.textColor = [UIColor grayColor];
        [self.contentView addSubview:self.label];
    }
    return self;
}

-(void)prepareForReuse
{
    [super prepareForReuse ];
    [self.queue cancelAllOperations];
    self.thumb.image = nil;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.thumb.frame = self.bounds;
    
    self.backgroundColor = [UIColor redColor];
    
    CGRect r = self.label.frame;
    r.size.width = self.bounds.size.width;
    r.size.height = 50;
    r.origin.x = 0;
    r.origin.y = self.bounds.size.height - r.size.height;
    self.label.frame = r;
}

-(void)render
{
    self.label.text = [self.results.listingTitle componentsSeparatedByString:@"-"][0];
    
    NSURLRequest * req = [NSURLRequest requestWithURL:self.results.listingBitmapURL];
    NetworkOperation *op = [[NetworkOperation alloc]initWithRequest:req andSession:[SessionManager sharedSessionManager].defaultSession];
    
    __weak NetworkOperation *weakop = op;
    __weak SearchResultsCell *weakself = self;
    [op setCompletionBlock:^
    {
        NSData *resultsData = weakop.resultData.copy;
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [weakself handleImageLoaded:resultsData];
        });
    }];
    [self.queue addOperation:op];
    [op setIsReady:YES];
}

-(void)handleImageLoaded:(NSData *)data
{
    self.thumb.image = [UIImage imageWithData:data];
}

@end
