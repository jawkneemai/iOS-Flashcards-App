//
//  Lab4Tests.m
//  Lab4Tests
//
//  Created by Johnathan Mai on 3/22/16.
//  Copyright © 2016 Johnathan Mai. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlashcardsModel.h"

@interface Lab4Tests : XCTestCase

@property (strong, nonatomic) FlashcardsModel *flashcardsModel;

@end

@implementation Lab4Tests

- (void)setUp {
    [super setUp];
    self.flashcardsModel = [FlashcardsModel sharedModel];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
