//
//  NetworkManagerTests.m
//  WeatherAppTests
//
//  Created by Ahmed Elsman on 05/08/2024.
//

#import <XCTest/XCTest.h>
#import "NetworkManager.h"
#import "URLSessionProtocol.h"

@interface MockURLSession : NSObject <URLSessionProtocol>
@property (nonatomic, strong) NSData *mockData;
@property (nonatomic, strong) NSError *mockError;
@property (nonatomic, assign) NSInteger mockStatusCode;
@end

@implementation MockURLSession

- (void)dataWithRequest:(NSURLRequest *)request completion:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion {
    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:request.URL
                                                              statusCode:self.mockStatusCode
                                                             HTTPVersion:nil
                                                            headerFields:nil];
    completion(self.mockData, response, self.mockError);
}

@end

@interface NetworkManagerTests : XCTestCase
@property (nonatomic, strong) NetworkManager *networkManager;
@property (nonatomic, strong) MockURLSession *mockSession;
@end

@implementation NetworkManagerTests

- (void)setUp {
    [super setUp];
    self.mockSession = [[MockURLSession alloc] init];
    self.networkManager = [[NetworkManager alloc] initWithSession:self.mockSession];
}

- (void)testFetchDataSuccess {
    // Setup mock data and response
    self.mockSession.mockData = [@"{\"key\":\"value\"}" dataUsingEncoding:NSUTF8StringEncoding];
    self.mockSession.mockStatusCode = 200;

    // Create a URL request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.example.com/data"]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Data fetch expectation"];
    
    [self.networkManager fetchDataFrom:request completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        XCTAssertNotNil(data);
        XCTAssertNil(error);
        
        // Further assertions can be made here
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:nil];
}

- (void)testFetchDataFailure {
    self.mockSession.mockError = [NSError errorWithDomain:@"com.example.error" code:1001 userInfo:@{NSLocalizedDescriptionKey: @"Network error"}];
    self.mockSession.mockStatusCode = 500;

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.example.com/data"]];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Data fetch expectation"];
    
    [self.networkManager fetchDataFrom:request completion:^(NSData * _Nullable data, NSError * _Nullable error) {
        XCTAssertNil(data);
        XCTAssertNotNil(error);
        XCTAssertEqual(error.code, 1001);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:2 handler:nil];
}

@end
