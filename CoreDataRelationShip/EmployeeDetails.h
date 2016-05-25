//
//  EmployeeDetails.h
//  CoreDataRelationShip
//
//  Created by others on 25/05/16.
//  Copyright © 2016 Quadratics Software systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company+CoreDataProperties.h"
#import "Employee+CoreDataProperties.h"

@interface EmployeeDetails : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *employeeTable;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UITextField *employeeName;
@property (weak, nonatomic) IBOutlet UITextField *salary;
@property (weak, nonatomic) IBOutlet UITextField *experience;
- (IBAction)saveEmployee:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property(nonatomic,strong) Company *company;
@end
