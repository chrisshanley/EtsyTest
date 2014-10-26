//
//  SSJSONNetworkOperation.h
//  NetworkingFramework
//
//  Created by Chris on 8/21/14.
//  Copyright (c) 2014 Chris. All rights reserved.
//

#import "NetworkOperation.h"

@interface JSONNetworkOperation : NetworkOperation<NSURLSessionDelegate>

// Sub class for JSON endcoding 

@property(nonatomic, strong)id json;

@end
