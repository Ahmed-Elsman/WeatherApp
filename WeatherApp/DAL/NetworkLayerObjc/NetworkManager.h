//
//  NetworkManager.h
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

#import <Foundation/Foundation.h>
#import "NetworkManaging.h"
#import "URLSessionProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject <NetworkManaging>

- (instancetype)initWithSession:(id<URLSessionProtocol>)session;

@end

NS_ASSUME_NONNULL_END

