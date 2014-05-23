//
//  JVEItemsView.m
//  Lighter Core Data
//
//  Created by Jozsef Vesza on 23/05/14.
//
//

#import "JVEItemsView.h"
#import "JVRFetchedResultsControllerDataSource.h"
#import "JVEDataSourceDelegate.h"
#import "JVENewItemView.h"
#import "Item.h"

@interface JVEItemsView ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic,strong) JVRFetchedResultsControllerDataSource *fetchResultsControllerDataSource;
@property (nonatomic,strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation JVEItemsView

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupFetchedResultsController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.fetchResultsControllerDataSource.paused = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.fetchResultsControllerDataSource.paused = YES;
}

#pragma mark - Fetched results controller setup

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController)
    {
        // 1.: Load the stored fetch request from the managed object model
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
        
        // 2.: Add sort descriptors
        NSSortDescriptor *dateSorter = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
        NSArray *sortDescriptorArray = @[dateSorter];
        request.sortDescriptors = sortDescriptorArray;
        
        // 3.: Build the controller
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    }
    
    return _fetchedResultsController;
}

- (void)setupFetchedResultsController
{
    self.fetchResultsControllerDataSource = [JVRFetchedResultsControllerDataSource dataSourceForTableView:self.tableView withFetchedResultsController:self.fetchedResultsController usingDelegate:[JVEDataSourceDelegate delegateWithManagedObjectContext:self.managedObjectContext]];
}

#pragma mark - User interactions

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"JVESegueToNewItem" sender:self];
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender
{
    [self setEditing:![self isEditing] animated:YES];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    if (editing)
    {
        self.editButton.title = @"Done";
        self.editButton.tintColor = [UIColor redColor];
        self.addButton.enabled = NO;
    }
    else
    {
        self.editButton.title = @"Edit";
        self.editButton.tintColor = self.view.tintColor;
        self.addButton.enabled = YES;
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"JVESegueToNewItem"])
    {
        Item* newItem = [Item insertItemWithTitle:@"Untitled" withDate:[NSDate date] inManagedObjectContext:self.managedObjectContext];
        JVENewItemView *newItemController = segue.destinationViewController;
        newItemController.item = newItem;
        newItemController.managedObjectContext = self.managedObjectContext;
    }
}

@end
