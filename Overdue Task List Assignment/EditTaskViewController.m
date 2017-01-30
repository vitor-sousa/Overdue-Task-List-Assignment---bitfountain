//
//  EditTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Vitor Sousa on 13/12/16.
//  Copyright © 2016 Vitor Sousa. All rights reserved.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _taskDescriptionTextView.delegate = self;
    _taskNameEditTaskTextField.delegate = self;
    
    _taskNameEditTaskTextField.text = _task.taskName;
    _taskDescriptionTextView.text = _task.taskDescription;
    _dateEditTaskDatePicker.date = _task.taskDate;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)updateTask {
    
    _task.taskName = _taskNameEditTaskTextField.text;
    _task.taskDescription = _taskDescriptionTextView.text;
    _task.taskDate = _dateEditTaskDatePicker.date;
    
}

- (IBAction)saveEditTaskBarButtonPressed:(UIBarButtonItem *)sender {
    
    [self updateTask];
    [_delegate didUpdateTask];

}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_taskNameEditTaskTextField resignFirstResponder];
    return YES;
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]){
        
        [_taskDescriptionTextView resignFirstResponder];
        return NO;
        
    }
    
    return YES;
    
}
@end
