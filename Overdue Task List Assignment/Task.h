//
//  Task.h
//  Overdue Task List Assignment
//
//  Created by Vitor Sousa on 12/01/17.
//  Copyright © 2017 Vitor Sousa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (strong, nonatomic) NSString * taskName;
@property (strong, nonatomic) NSString * taskDescription;
@property (strong, nonatomic) NSDate * taskDate;
@property (nonatomic) BOOL taskIsCompleted;

- (id)initWithData:(NSDictionary *)data;

+ (NSDictionary *)taskObjectToPropertyList:(Task *)task;
+ (Task *)propertyListsToTaskObject:(NSDictionary *)dictionary;

@end
