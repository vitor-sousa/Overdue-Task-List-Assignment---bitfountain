//
//  Task.m
//  Overdue Task List Assignment
//
//  Created by Vitor Sousa on 12/01/17.
//  Copyright © 2017 Vitor Sousa. All rights reserved.
//

#import "Task.h"

@implementation Task

- (id)initWithData:(NSDictionary *)data{
    
    self = [super init];
    
    if (self){
    
        _taskName = data[TASK_NAME];
        _taskDescription = data[TASK_DESCRIPTION];
        _taskDate = data[TASK_DATE];
        _taskIsCompleted = [data[TASK_COMPLETION] boolValue];
        
    }
    
    return self;
    
}


- (id)init{
    
    self = [self initWithData:nil];
    
    return self;
    
}



#pragma mark - Methods
+ (NSDictionary *)taskObjectToPropertyList:(Task *)task{
    
    NSDictionary *dictionary = @{TASK_NAME : task.taskName, TASK_DESCRIPTION : task.taskDescription, TASK_DATE : task.taskDate, TASK_COMPLETION : @(task.taskIsCompleted)};
    
    
    return dictionary;
    
}


+ (Task *)propertyListsToTaskObject:(NSDictionary *)dictionary{
    
    Task *task = [[Task alloc] initWithData:dictionary];
    
    return task;
    
}



@end
