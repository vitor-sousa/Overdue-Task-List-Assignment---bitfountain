//
//  ListTaskTableViewController.m
//  Overdue Task List Assignment
//
//  Created by Vitor Sousa on 13/12/16.
//  Copyright © 2016 Vitor Sousa. All rights reserved.
//

#import "ListTaskTableViewController.h"

@interface ListTaskTableViewController ()

@end

@implementation ListTaskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_taskObjects){
        _taskObjects = [[NSMutableArray alloc] init];
    }
    
    self.tableView.delegate = self;
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY];
    
    for (NSDictionary *dictionary in tasksAsPropertyLists) {
        Task *taskObject = [Task propertyListsToTaskObject:dictionary];
        [_taskObjects addObject:taskObject];
    }
        
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - IBActions Methods
- (IBAction)addNewTaskBarButtonPressed:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"segueToAddTaskViewController" sender:nil];
    
}

- (IBAction)reorderTasksBarButtonPressed:(UIBarButtonItem *)sender {
    
    if (self.tableView.editing == NO) {
        
        [self.tableView setEditing:YES animated:YES];
        
        sender.title = @"Done";
        sender.tintColor = [UIColor colorWithRed:0.251 green:0.686 blue:0.153 alpha:1.00];
        sender.image = nil;
    
    }else{
        
        [self.tableView setEditing:NO animated:YES];
        
        sender.title = nil;
        sender.tintColor = [UIColor colorWithRed:0.082 green:0.494 blue:0.984 alpha:1.00];
        sender.image = [UIImage imageNamed:@"Reorder"];

    }
    
}



#pragma mark - Navigation Prepare For Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.destinationViewController isKindOfClass:[AddTaskViewController class]]) {
        
        AddTaskViewController *addTaskVC = segue.destinationViewController;
        addTaskVC.delegate = self;
    
    }else if ([segue.destinationViewController isKindOfClass:[DetailTaskViewController class]]) {
        
        DetailTaskViewController *detailTaskVC = segue.destinationViewController;
        detailTaskVC.delegate = self;
        
        NSIndexPath *path = sender;

        Task *taskDetail = [_taskObjects objectAtIndex:path.row];
        
        detailTaskVC.task = taskDetail;
        
    }
    
}



#pragma mark - AddTaskViewController Delegate Methods
- (void)didAddTask:(Task *)task{
    
    [_taskObjects addObject: task];
    
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY] mutableCopy];
    
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [taskObjectsAsPropertyLists addObject:[Task taskObjectToPropertyList:task]];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECT_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
    
}


- (void)saveTasks {
    
    NSMutableArray *taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    for (Task *task in _taskObjects) {
        [taskObjectsAsPropertyLists addObject:[Task taskObjectToPropertyList:task]];
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECT_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - DetailTaskViewController Delegate Methods
- (void)updateTask {
    
    [self saveTasks];
    [self.tableView reloadData];
    
}


#pragma mark - Helper Methods
- (void)updateCompletionTask:(Task *)task forIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECT_KEY] mutableCopy];
    
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
        
    
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    if (task.taskIsCompleted == YES) task.taskIsCompleted = NO;
    else task.taskIsCompleted = YES;
    
    [taskObjectsAsPropertyLists insertObject:[Task taskObjectToPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECT_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
    
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _taskObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    Task *taskObject = _taskObjects[indexPath.row];
    
    cell.textLabel.text = taskObject.taskName;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:taskObject.taskDate];

    
    cell.detailTextLabel.text = stringFromDate;
    
    if ([taskObject.taskDate timeIntervalSinceNow] < 0 && taskObject.taskIsCompleted == NO) {
        cell.backgroundColor = [UIColor colorWithRed:0.859 green:0.235 blue:0.255 alpha:1.00]; //Red color
    }else if ([taskObject.taskDate timeIntervalSinceNow] > 0 && taskObject.taskIsCompleted == NO){
        cell.backgroundColor = [UIColor colorWithRed:0.969 green:0.788 blue:0.180 alpha:1.00];
    }else if (taskObject.taskIsCompleted == YES){
        cell.backgroundColor = [UIColor colorWithRed:0.337 green:0.761 blue:0.333 alpha:1.00]; // Greeen color
    }
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Task *task = _taskObjects[indexPath.row];
    [self updateCompletionTask:task forIndexPath:indexPath];
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [_taskObjects removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newTaskObjects = [[NSMutableArray alloc] init];
        
        for (Task *task in _taskObjects) {
            
            [newTaskObjects addObject:[Task taskObjectToPropertyList:task]];
            
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjects forKey:TASK_OBJECT_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"segueToDetailTaskViewController" sender:indexPath];
    
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    Task *task = _taskObjects[fromIndexPath.row];
    [_taskObjects removeObjectAtIndex:fromIndexPath.row];
    [_taskObjects insertObject:task atIndex:toIndexPath.row];
    
    [self saveTasks];
    
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


@end
