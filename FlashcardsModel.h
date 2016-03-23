//
//  FlashcardsModel.h
//  Lab4
//
//  Created by Johnathan Mai on 3/22/16.
//  Copyright © 2016 Johnathan Mai. All rights reserved.
//

#import <Foundation/Foundation.h>

// constants
static NSString * const kQuestionKey = @"question";
static NSString * const kAnswerKey = @"answer";

@interface FlashcardsModel : NSObject


// public methods
+ (instancetype) sharedModel;
- (NSDictionary *) randomFlashcard;
- (NSUInteger) numberOfFlashcards;
- (NSDictionary *) flashcardAtIndex: (NSUInteger) index;
- (void) removeFlashcardAtIndex: (NSUInteger) index;
- (void) insertFlashcard: (NSDictionary *) flashcard;
- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer;
- (void) insertFlashcard: (NSDictionary *) flashcard
                 atIndex: (NSUInteger) index;
- (void) insertFlashcard: (NSString *) flashcard
                  answer: (NSString *) answer
                 atIndex: (NSUInteger) index;
- (NSDictionary *) nextFlashcard;
- (NSDictionary *) prevFlashcard;

@end
