JVRFetchedResultsControllerDataSource
=====================================

A reusable class that combines UITableViewDataSource and NSFetchedResultsControllerDelegate. Deletion and addition of table view cells are also supported. To use it, you will also need a class that conforms to the JVRFetchedResultsControllerDataSourceDelegate protocol, which will handle the setup and deletion of individual cells.

### Example for the delegate

```objc
- (NSString *)fetchCellIdentifierForObject:(id)anObject
{
    if ([anObject isKindOfClass:[MyClass class]])
    {
        return @"myCell";
    }
    else
    {
        return @"regularCell";
    }
}

- (UITableViewCell *)configureCell:(MyCell *)cell withObject:(Item *)object
{
    UITableViewCell *currentCell = cell;
    currentCell.textLabel.text = object.title;
}

- (void)deleteObject:(Item *)object
{
    [self.managedObjectContext deleteObject:object];
    NSError *e;
    [self.managedObjectContext save:&e];
}

```

### Example usage in a UITableViewController class:

```objc
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupFetchedResultsDataSource];
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

- (void)setupFetchedResultsDataSource
{
    self.fetchedResultsController = [JVRFetchedResultsControllerDataSource dataSourceForTableView:self.tableView
                                                                     withFetchedResultsController:self.fetchedResultsController
                                                                                    usingDelegate:[[MyCellConfigurator alloc] init]];
}

```
