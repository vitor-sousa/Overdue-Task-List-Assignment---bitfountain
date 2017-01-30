//
//  AddTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Vitor Sousa on 13/12/16.
//  Copyright © 2016 Vitor Sousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol AddTaskViewControllerDelegate <NSObject>

@required
- (void)didAddTask:(Task *)task;

@end


@interface AddTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) id <AddTaskViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *taskNameAddTaskTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionAddTaskTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateAddTaskDatePicker;


- (IBAction)saveNewTaskBarButtonPressed:(UIBarButtonItem *)sender;

@end
