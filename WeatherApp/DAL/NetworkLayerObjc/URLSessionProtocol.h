//
//  URLSessionProtocol.h
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

#import <Foundation/Foundation.h>

@protocol URLSessionProtocol <NSObject>
- (void)dataWithRequest:(NSURLRequest *)request completion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion;
@end
