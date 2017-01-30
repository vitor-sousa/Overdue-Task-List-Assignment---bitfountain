//
//  ListTaskTableViewController.h
//  Overdue Task List Assignment
//
//  Created by Vitor Sousa on 13/12/16.
//  Copyright © 2016 Vitor Sousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
#import "DetailTaskViewController.h"

@interface ListTaskTableViewController : UITableViewController <AddTaskViewControllerDelegate, DetailTaskViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *taskObjects;


- (IBAction)addNewTaskBarButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)reorderTasksBarButtonPressed:(UIBarButtonItem *)sender;

@end
