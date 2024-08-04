//
//  NetworkManaging.h
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

#import <Foundation/Foundation.h>

@protocol NetworkManaging <NSObject>
- (void)fetchDataFrom:(NSURLRequest *)request completion:(void (^)(id _Nullable, NSError * _Nullable))completion;
@end
