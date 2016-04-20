//
//  ViewController.m
//  Lab4
//
//  Created by Johnathan Mai on 3/22/16.
//  Copyright © 2016 Johnathan Mai. All rights reserved.
//

#import "ViewController.h"
#import "FlashcardsModel.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

// private properties
@property (strong, nonatomic) FlashcardsModel *flashcardsModel;
@property bool onQuestion; // Used to determine if screen is on question or answer
@property (readonly) SystemSoundID soundFileID;

// IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    NSLog(@"hi");
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.flashcardsModel = [FlashcardsModel sharedModel];
    self.onQuestion = true;
    
    // Display the first flash card in the set
    if ([self.flashcardsModel numberOfFlashcards] != 0) {
        int i = rand() % [self.flashcardsModel numberOfFlashcards];
        self.questionLabel.text = [self.flashcardsModel flashcardAtIndex: i][kQuestionKey];
        self.flashcardsModel.currentIndex = i;
    } else if ([self.flashcardsModel numberOfFlashcards] == 0) {
        self.questionLabel.text = @"There are no flashcards!";
    }
    
    // Gestures - Taps
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapRecognized:)];
    [self.view addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapRecognized:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail: doubleTap];
    
    // Gestures - Swipes
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeGestureRecognized:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeGestureRecognized:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    
    // Sound
    //NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"fadein" ofType:@"wav"];
    //NSURL *soundURL = [NSURL fileURLWithPath:soundFilePath];
    
    //AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &_soundFileID);
    
    
}

- (void) singleTapRecognized: (UITapGestureRecognizer *) recognizer {
    
    if ([self.flashcardsModel numberOfFlashcards] == 0) { // handles when there are no flashcards to display
        self.questionLabel.text = @"There are no flashcards!";
    }
    
    int i = random()%[self.flashcardsModel numberOfFlashcards];
    self.questionLabel.text = [self.flashcardsModel flashcardAtIndex: i][kQuestionKey];
    self.flashcardsModel.currentIndex = i;
    
    [self fadeInCard:i];
    self.onQuestion = YES;

    //AudioServicesPlaySystemSound(self.soundFileID);
}

- (void) doubleTapRecognized: (UITapGestureRecognizer *) recognizer {
    
    if ([self.flashcardsModel numberOfFlashcards] == 0) { // handles when there are no flashcards to display
        self.questionLabel.text = @"There are no flashcards!";
    }
    
    if (self.onQuestion == true) {
        self.questionLabel.text = [self.flashcardsModel flashcardAtIndex: self.flashcardsModel.currentIndex][ kAnswerKey];
        self.onQuestion = false;
    } else {
        self.questionLabel.text = [self.flashcardsModel flashcardAtIndex: self.flashcardsModel.currentIndex][kQuestionKey];
        self.onQuestion = true;
    }
}

- (void) rightSwipeGestureRecognized: (UITapGestureRecognizer *) recognizer {
    
    if ([self.flashcardsModel numberOfFlashcards] == 0) { // handles when there are no flashcards to display
        self.questionLabel.text = @"There are no flashcards!";
    }
    
    NSLog(@"Right Swipe");
    [self.flashcardsModel nextFlashcard]; // sets currentIndex in method
    self.questionLabel.text = [self.flashcardsModel flashcardAtIndex: self.flashcardsModel.currentIndex][kQuestionKey];
    [self fadeInCard:self.flashcardsModel.currentIndex];
    self.onQuestion = YES;
}

- (void) leftSwipeGestureRecognized: (UITapGestureRecognizer *) recognizer {
    
    if ([self.flashcardsModel numberOfFlashcards] == 0) { // handles when there are no flashcards to display
        self.questionLabel.text = @"There are no flashcards!";
    }
    
    NSLog(@"Left Swipe");
    [self.flashcardsModel prevFlashcard]; // sets currentIndex in method
    [self fadeInCard:self.flashcardsModel.currentIndex];
    self.onQuestion = YES;
}


- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void) motionEnded: (UIEventSubtype) motion
           withEvent: (UIEvent *) event {
    
    if (motion == UIEventSubtypeMotionShake) {
        
        if ([self.flashcardsModel numberOfFlashcards] == 0) { // handles when there are no flashcards to display
            self.questionLabel.text = @"There are no flashcards!";
        }
        
        int i = random()%[self.flashcardsModel numberOfFlashcards];
        self.questionLabel.text = [self.flashcardsModel flashcardAtIndex: i][kQuestionKey];
        self.flashcardsModel.currentIndex = i;
    }
    
}

// Animation

- (void) fadeInCard: (int) flashcardIndex {
    self.questionLabel.alpha = 0;
    self.questionLabel.text = [self.flashcardsModel flashcardAtIndex: flashcardIndex][kQuestionKey];
    
    [UIView animateWithDuration: 1.0 animations:^{
        self.questionLabel.alpha = 1;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
