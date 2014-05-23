JVRFetchedResultsControllerDataSource [![Build Status](https://travis-ci.org/jozsef-vesza/JVRFetchedResultsControllerDataSource.svg?branch=master)](https://travis-ci.org/jozsef-vesza/JVRFetchedResultsControllerDataSource)
=====================================

A reusable class that combines `UITableViewDataSource` and `NSFetchedResultsControllerDelegate`. Deletion and addition of table view cells are also supported. To use it, you will also need a class that conforms to the `JVRFetchedResultsControllerDataSourceDelegate` protocol, which will handle the setup and deletion of individual cells. For details about the usage, see the simple examples below, or refer to the example project.

### Example for helper delegate
This object can be used to configure individual table view cells using the logic in the `tableView:cellForRowAtIndexPath:` method found in the `UITableViewDataSource` protocol. It also has access to the `NSManagedObjectContext` property of the data source, so it is responsible for handling item removal.

```objc
// MyHelperDelegate.h

#import "JVRFetchedResultsControllerDataSource.h"

@interface MyHelperDelegate : NSObject<JVRFetchedResultsControllerDataSourceDelegate>

@property (nonatomic, strong) NSManagedObjectContext

@end

// MyHelperDelegate.m
@implementation MyHelperDelegate

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

- (UITableViewCell *)configureCell:(MyCell *)cell withObject:(NSManagedObject *)object
{
    cell.textLabel.text = object.property;
}

- (void)deleteObject:(NSManagedObject *)object
{
    [self.managedObjectContext deleteObject:object];
    NSError *e;
    [self.managedObjectContext save:&e];
}

@end
```

### Example usage in a Table View Controller:
With the help of `JVRFetchedResultsControllerDataSource`, regular table view setup and `NSFetchedResultsControllerDelegate` methods can be removed from `UITableViewController` classes, leaving room for more important parts. The data source class requires a configured `NSFetchedResultsController` object and a helper delegate.

```objc
// MyTableViewController.h

@implementation JVEItemsView

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
    self.fetchResultsControllerDataSource = [JVRFetchedResultsControllerDataSource dataSourceForTableView:self.tableView
                                                                             withFetchedResultsController:self.fetchedResultsController
                                                                                            usingDelegate:[MyHelperDelegate delegateWithManagedObjectContext:self.managedObjectContext]];
}

@end
```

### Installation
The recommended way of using this class in your project is installing through [CocoaPods](http://cocoapods.org), using this Podfile:
```ruby
platform :ios, "7.1"

pod 'JVRFetchedResultsControllerDataSource'
```
