//
//  AddViewController.m
//  Flashcards
//
//  Created by Johnathan Mai on 4/8/16.
//  Copyright © 2016 Johnathan Mai. All rights reserved.
//

#import "AddViewController.h"
#import "FlashcardsModel.h"

@interface AddViewController () <UITextViewDelegate, UITextFieldDelegate>

    @property (weak, nonatomic) IBOutlet UITextView *textViewQuestion;
    @property (weak, nonatomic) IBOutlet UITextField *textFieldAnswer;
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonSaveFlashcard;
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonCancel;
    @property (strong, nonatomic) FlashcardsModel *flashcardsModel;


@end

@implementation AddViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.flashcardsModel = [FlashcardsModel sharedModel];
    self.buttonSaveFlashcard.enabled = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (IBAction)saveTouched:(id)sender {
    NSDictionary *flashcard = [[NSDictionary alloc] initWithObjectsAndKeys: self.textFieldAnswer.text, kAnswerKey, self.textViewQuestion.text, kQuestionKey, nil];
    [self.flashcardsModel insertFlashcard:flashcard];
    
    self.textViewQuestion.text = nil;
    self.textFieldAnswer.text = nil;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow: [self.flashcardsModel numberOfFlashcards] inSection: 0];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) textView:(UITextView *) textViewQuestion shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (self.textViewQuestion.text.length > 0 && self.textFieldAnswer.text.length > 0) {
        self.buttonSaveFlashcard.enabled = YES;
    } else {
        self.buttonSaveFlashcard.enabled = NO;
    }
    
    return YES;
}

/*
- (void)textViewDidChange:(UITextView *)textViewQuestion {
    if (self.textViewQuestion.text.length > 0 && self.textFieldAnswer.text.length > 0) {
        self.buttonSaveFlashcard.enabled = YES;
    } else {
        self.buttonSaveFlashcard.enabled = NO;
    }
}*/
/*
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    NSString *changedString = [self.textFieldAnswer.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.textViewQuestion.text.length > 0 && self.textFieldAnswer.text.length > 0) {
        self.buttonSaveFlashcard.enabled = YES;
    } else {
        self.buttonSaveFlashcard.enabled = NO;
    }
    
    return YES;
}*/

/*
- (IBAction)textChanged {
    if (self.textViewQuestion.text.length > 0 && self.textFieldAnswer.text.length != 0) {
        self.buttonSaveFlashcard.enabled = YES;
    }
    else {
        self.buttonSaveFlashcard.enabled = NO;
    }
}*/

- (IBAction)backgroundTouched:(id)sender {
    [self.textFieldAnswer resignFirstResponder];
    [self.textViewQuestion resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

