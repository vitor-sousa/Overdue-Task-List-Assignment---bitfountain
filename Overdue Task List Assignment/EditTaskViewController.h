//
//  EditTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Vitor Sousa on 13/12/16.
//  Copyright © 2016 Vitor Sousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol EditTaskViewControllerDelegate <NSObject>

- (void)didUpdateTask;

@end

@interface EditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) Task *task;

@property (weak, nonatomic) id <EditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *taskNameEditTaskTextField;
@property (strong, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateEditTaskDatePicker;


- (IBAction)saveEditTaskBarButtonPressed:(UIBarButtonItem *)sender;

@end
