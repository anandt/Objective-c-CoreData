//
//  EmployeeDetails.m
//  CoreDataRelationShip
//
//  Created by others on 25/05/16.
//  Copyright © 2016 Quadratics Software systems Inc. All rights reserved.
//

#import "EmployeeDetails.h"

@interface EmployeeDetails ()

@end

@implementation EmployeeDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.companyName.text = [self.company valueForKey:@"companyName"];
    
    self.employeeName.delegate=self;
    self.salary.delegate=self;
    self.experience.delegate=self;
    self.location.delegate=self;
    _employeeTable.delegate=self;
    _employeeTable.dataSource=self;
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (IBAction)saveEmployee:(id)sender {
    
    if(![self.employeeName.text isEqualToString:@""])
    {
        NSEntityDescription *managerEntityDescription = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:self.managedObjectContext];
        
        Employee *newEmployee = (Employee *)[[NSManagedObject alloc] initWithEntity:managerEntityDescription
                                                     insertIntoManagedObjectContext:self.managedObjectContext];
        
        newEmployee.name = self.employeeName.text;
        newEmployee.salary=[NSNumber numberWithDouble:[[self.salary text] doubleValue]];
        newEmployee.experience=[NSNumber numberWithInt:[[self.experience text] intValue]];
        newEmployee.address=self.location.text;
        
        [self.company addEmployeeObject:newEmployee];
        
        NSError *error = nil;
        
        if (![[self managedObjectContext] save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        else
        {
            [self viewWillAppear:YES];
        }
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Missing Information" message:@"Hey man you totally forgot to input some information!" delegate:nil cancelButtonTitle:@"Got It!" otherButtonTitles:nil];
        [alertView show];
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    self.employeeName.text = @"";
    self.experience.text=@"";
    self.salary.text=@"";
    self.location.text=@"";
    [self.employeeTable reloadData];
    self.navigationController.navigationBarHidden=NO;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.employeeName resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu=",(long)self.company.employee.count);
    
    return self.company.employee.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EmployeeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Employee *employee = [self.company.employee.allObjects objectAtIndex:indexPath.row];
    NSLog(@"employee ==%@",employee.name);
    cell.textLabel.text = employee.name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",employee.experience];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arrEmployee = [[NSMutableArray alloc] init];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Employee"];
    arrEmployee = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    for(int i=0; i<[arrEmployee count]; i++)
    {
        NSLog(@"Employee:%d Name:%@",i,[[arrEmployee objectAtIndex:i] valueForKey:@"name"]);
    }
}



@end
