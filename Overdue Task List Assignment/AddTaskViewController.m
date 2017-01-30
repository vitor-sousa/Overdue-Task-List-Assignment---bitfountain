//
//  AddTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Vitor Sousa on 13/12/16.
//  Copyright © 2016 Vitor Sousa. All rights reserved.
//

#import "AddTaskViewController.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _taskNameAddTaskTextField.delegate = self;
    _taskDescriptionAddTaskTextView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Task *)returnNewTaskObject{
    
    Task *task = [[Task alloc] init];
    
    task.taskName = _taskNameAddTaskTextField.text;
    task.taskDescription = _taskDescriptionAddTaskTextView.text;
    task.taskDate = _dateAddTaskDatePicker.date;
    task.taskIsCompleted = NO;
    
    return task;
    
}

- (IBAction)saveNewTaskBarButtonPressed:(UIBarButtonItem *)sender {
    
    [self.delegate didAddTask:[self returnNewTaskObject]];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_taskNameAddTaskTextField resignFirstResponder];
    return YES;
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]){
        
        [_taskDescriptionAddTaskTextView resignFirstResponder];
        return NO;
    
    }
    
    return YES;
    
}

@end
