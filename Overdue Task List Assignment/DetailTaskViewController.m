//
//  DetailTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Vitor Sousa on 13/12/16.
//  Copyright © 2016 Vitor Sousa. All rights reserved.
//

#import "DetailTaskViewController.h"

@interface DetailTaskViewController ()

@end

@implementation DetailTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _nameTaskDetailTaskLabel.text = _task.taskName;
    _taskDescriptionDetailTaskLabel.text = _task.taskDescription;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:_task.taskDate];
    
    _dateTaskDetailTaskLabel.text = stringFromDate;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[EditTaskViewController class]]){
        
        EditTaskViewController *EditVC = segue.destinationViewController;
        EditVC.task = _task;
        EditVC.delegate = self;
        
    }
    
}


- (IBAction)editTaskDetailTaskBarButtonPressed:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"segueToEditTaskViewController" sender:nil];
    
}

- (void)didUpdateTask {
    
    _nameTaskDetailTaskLabel.text = _task.taskName;
    _taskDescriptionDetailTaskLabel.text = _task.taskDescription;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:_task.taskDate];
    
    _dateTaskDetailTaskLabel.text = stringFromDate;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate updateTask];
    
}
@end
