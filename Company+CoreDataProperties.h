//
//  Company+CoreDataProperties.h
//  CoreDataRelationShip
//
//  Created by others on 25/05/16.
//  Copyright © 2016 Quadratics Software systems Inc. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Company.h"

NS_ASSUME_NONNULL_BEGIN

@interface Company (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *companyName;
@property (nullable, nonatomic, retain) NSNumber *levelOfCompany;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSSet<Employee *> *employee;

@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addEmployeeObject:(Employee *)value;
- (void)removeEmployeeObject:(Employee *)value;
- (void)addEmployee:(NSSet<Employee *> *)values;
- (void)removeEmployee:(NSSet<Employee *> *)values;

@end

NS_ASSUME_NONNULL_END
