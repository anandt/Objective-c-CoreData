//
//  ViewController.m
//  CoreDataRelationShip
//
//  Created by others on 25/05/16.
//  Copyright © 2016 Quadratics Software systems Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _companyNameTextField.delegate=self;
    _levelOfCompany.delegate=self;
    _locationOfCompany.delegate=self;
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:250.0/255 green:154.0/255 blue:43.0/255 alpha:1]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)saveAction:(id)sender {
    
    if(![self.companyNameTextField.text isEqualToString:@""])
    {
        NSEntityDescription *managerEntityDescription = [NSEntityDescription entityForName:@"Company" inManagedObjectContext:self.managedObjectContext];
        
        Company *newManager = (Company *)[[NSManagedObject alloc] initWithEntity:managerEntityDescription
                                                  insertIntoManagedObjectContext:self.managedObjectContext];
        
        newManager.companyName = self.companyNameTextField.text;
        newManager.levelOfCompany=[NSNumber numberWithDouble:[[self.levelOfCompany text] doubleValue]];
        newManager.location=self.locationOfCompany.text;
        
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.companyNameTextField.text = @"";
    self.levelOfCompany.text=@"";
    self.locationOfCompany.text=@"";
    
    //self.navigationController.navigationBarHidden=YES;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Company"];
    NSString *cacheName = @"CompanyCache";
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"companyName" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:nil cacheName:cacheName];
    NSError *error;
    if(![self.fetchedResultsController performFetch:&error])
    {
        NSLog(@"Fetch Failure: %@",error);
    }
    [self.tableView reloadData];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.companyNameTextField resignFirstResponder];
    [self.levelOfCompany resignFirstResponder];
    [self.locationOfCompany resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return self.fetchedResultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CompanyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Company *manager = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = manager.companyName;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",manager.levelOfCompany];
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EmployeeDetails *emp = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployeeDetailsID"];
    emp.company = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [[self navigationController] pushViewController:emp animated:YES];
}

- (IBAction)addEmployeeAction:(id)sender {
    
    
}


@end
