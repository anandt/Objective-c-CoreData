//
//  Employee+CoreDataProperties.h
//  CoreDataRelationShip
//
//  Created by others on 25/05/16.
//  Copyright © 2016 Quadratics Software systems Inc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *salary;
@property (nullable, nonatomic, retain) NSNumber *experience;
@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) Company *company;

@end

NS_ASSUME_NONNULL_END
