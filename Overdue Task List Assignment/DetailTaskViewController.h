//
//  DetailTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Vitor Sousa on 13/12/16.
//  Copyright © 2016 Vitor Sousa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditTaskViewController.h"
#import "Task.h"

@protocol DetailTaskViewControllerDelegate <NSObject>

- (void)updateTask;

@end

@interface DetailTaskViewController : UIViewController <EditTaskViewControllerDelegate>

@property (strong, nonatomic) Task *task;

@property (weak, nonatomic) id <DetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *nameTaskDetailTaskLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDescriptionDetailTaskLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateTaskDetailTaskLabel;



- (IBAction)editTaskDetailTaskBarButtonPressed:(UIBarButtonItem *)sender;

@end
