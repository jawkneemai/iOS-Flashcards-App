//
//  ViewController.m
//  Lab4
//
//  Created by Johnathan Mai on 3/22/16.
//  Copyright © 2016 Johnathan Mai. All rights reserved.
//

#import "ViewController.h"
#import "FlashcardsModel.h"

@interface ViewController ()

// private properties
@property (strong, nonatomic) FlashcardsModel *flashcardsModel;

// IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.flashcardsModel = [FlashcardsModel sharedModel];
    
    // Display the first flash card in the set
    self.questionLabel.text = [self.flashcardsModel flashcardAtIndex: 0][kQuestionKey];
    self.answerLabel.text = [self.flashcardsModel flashcardAtIndex: 0][kAnswerKey];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
