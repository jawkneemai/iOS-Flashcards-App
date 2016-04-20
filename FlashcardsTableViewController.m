//
//  FlashcardsTableViewController.m
//  Flashcards
//
//  Created by Johnathan Mai on 4/8/16.
//  Copyright © 2016 Johnathan Mai. All rights reserved.
//

#import "FlashcardsTableViewController.h"
#import "FlashcardsModel.h"
#import "AddViewController.h"

@interface FlashcardsTableViewController ()

    @property (strong, nonatomic) FlashcardsModel *flashcardsModel;

@end

@implementation FlashcardsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // Getting singleton
    self.flashcardsModel = [FlashcardsModel sharedModel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addButtonPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"AddFlashcardSegue" sender:sender];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *) segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"AddFlashcardSegue"]) {
        
        // Getting child view
        AddViewController *controller = [segue destinationViewController];
        NSInteger tagIndex = [(UIButton *)sender tag];
        
        //[controller setSelectedButton:tagIndex];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.flashcardsModel.numberOfFlashcards;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FlashcardCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.flashcardsModel flashcardAtIndex: indexPath.row][kQuestionKey];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.flashcardsModel removeFlashcardAtIndex:indexPath.row];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
