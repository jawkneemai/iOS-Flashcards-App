//
//  FlashcardsModel.m
//  Lab4
//
//  Created by Johnathan Mai on 3/22/16.
//  Copyright © 2016 Johnathan Mai. All rights reserved.
//

#import "FlashcardsModel.h"

@interface FlashcardsModel ()

    @property (strong, nonatomic) NSMutableArray *flashcards;
    @property (strong, nonatomic) NSString *filepath;

@end

@implementation FlashcardsModel

+ (instancetype) sharedModel {
    static FlashcardsModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        _filepath = [documentsDirectory stringByAppendingPathComponent: kFlashcardsPList];
        _flashcards = [NSMutableArray arrayWithContentsOfFile:_filepath];
        
        if (!_flashcards) {
            NSDictionary *flashcard1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Flashcard 1 answer!", kAnswerKey, @"Flashcard 1 question?", kQuestionKey, nil];
            NSDictionary *flashcard2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Flashcard 2 answer!", kAnswerKey, @"Flashcard 2 question?", kQuestionKey, nil];
            NSDictionary *flashcard3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Flashcard 3 answer!", kAnswerKey, @"Flashcard 3 question?", kQuestionKey, nil];
            NSDictionary *flashcard4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Flashcard 4 answer!", kAnswerKey, @"Flashcard 4 question?", kQuestionKey, nil];
            NSDictionary *flashcard5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Flashcard 5 answer!", kAnswerKey, @"Flashcard 5 question?", kQuestionKey, nil];
            
            _flashcards = [[NSMutableArray alloc] initWithObjects: flashcard1, flashcard2, flashcard3, flashcard4, flashcard5, nil];
        }
    }
    return self;
}

- (NSDictionary *) randomFlashcard {
    NSDictionary *flashcard = [self.flashcards objectAtIndex: (random() % [self numberOfFlashcards])];
    return flashcard;
    
}

- (NSUInteger) numberOfFlashcards {
    return [self.flashcards count];
}

- (NSDictionary *) flashcardAtIndex: (NSUInteger) index {
    return self.flashcards[index];
}

- (void) removeFlashcardAtIndex: (NSUInteger) index {
    if (index < self.numberOfFlashcards) {
        [self.flashcards removeObjectAtIndex: index];
    }
    [self save];
    return;
}

- (void) insertFlashcard: (NSDictionary *) flashcard {
    [self.flashcards addObject: flashcard];
    [self save];
}

- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer {
    NSDictionary *flashcard = [NSDictionary dictionaryWithObjectsAndKeys: answer, kAnswerKey, question, kQuestionKey, nil];
    [self insertFlashcard: flashcard];
    [self save];
}

- (void) insertFlashcard: (NSDictionary *) flashcard
                 atIndex: (NSUInteger) index {
    if (index < self.numberOfFlashcards) {
        [self.flashcards insertObject: flashcard atIndex: index];
    }
    [self save];
}


- (void) insertFlashcard: (NSString *) question
                  answer: (NSString *) answer
                 atIndex: (NSUInteger) index {
    if (index < self.numberOfFlashcards) {
        NSDictionary *flashcard = [NSDictionary dictionaryWithObjectsAndKeys: answer, kAnswerKey, question, kQuestionKey, nil];
        [self.flashcards insertObject: flashcard atIndex: index];
    }
    [self save];
}

- (NSDictionary *) nextFlashcard {
    if (self.currentIndex == [self.flashcards count] - 1) {
        self.currentIndex = 0;
        return [self flashcardAtIndex: self.currentIndex];
    } else {
        self.currentIndex++;
        return [self flashcardAtIndex: self.currentIndex];
    }
}

- (NSDictionary *) prevFlashcard {
    if (self.currentIndex == 0) {
        self.currentIndex = [self.flashcards count] - 1;
        return [self flashcardAtIndex: self.currentIndex];
    } else {
        self.currentIndex--;
        return [self flashcardAtIndex: self.currentIndex];
    }
}

- (void) save {
    [self.flashcards writeToFile:self.filepath atomically:YES];
}


@end
