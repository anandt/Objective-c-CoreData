//
//  ViewController.h
//  CoreDataRelationShip
//
//  Created by others on 25/05/16.
//  Copyright © 2016 Quadratics Software systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company+CoreDataProperties.h"
#import "EmployeeDetails.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *levelOfCompany;
@property (weak, nonatomic) IBOutlet UITextField *locationOfCompany;
@property (weak, nonatomic) IBOutlet UIButton *addEmployee;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addEmployeeAction:(id)sender;
- (IBAction)saveAction:(id)sender;

@end

