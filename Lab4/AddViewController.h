//
//  AddViewController.h
//  Flashcards
//
//  Created by Johnathan Mai on 4/8/16.
//  Copyright © 2016 Johnathan Mai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddNoteHandler)(NSString* question, NSString* answer);

@interface AddViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

    @property (copy, nonatomic) AddNoteHandler addNoteHandler;

@end