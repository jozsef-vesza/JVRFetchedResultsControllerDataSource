//
//  JVRFetchedResultsControllerDataSource.m
//  Lighter TVC Core Data
//
//  Created by Jozsef Vesza on 19/05/14.
//
//

#import "JVRFetchedResultsControllerDataSource.h"
#import "JVRCellConfiguratorDelegate.h"

@interface JVRFetchedResultsControllerDataSource ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) id<JVRCoreDataHelperDelegate> delegate;
@property (nonatomic, strong) id<JVRCellConfiguratorDelegate> cellConfigurator;

@end

@implementation JVRFetchedResultsControllerDataSource

+ (instancetype)dataSourceForTableView:(UITableView *)tableView withFetchedResultsController:(NSFetchedResultsController *)controller usingDelegate:(id <JVRCoreDataHelperDelegate>)delegate usingCellConfigurator:(id <JVRCellConfiguratorDelegate>)cellConfigurator
{
    return [[self alloc] initWithTableView:tableView withFetchedResultsController:controller withDelegate:delegate usingCellConfigurator:cellConfigurator];
}

- (instancetype)initWithTableView:(UITableView *)tableView withFetchedResultsController:(NSFetchedResultsController *)controller withDelegate:(id<JVRCoreDataHelperDelegate>)delegate usingCellConfigurator:(id <JVRCellConfiguratorDelegate>)cellConfigurator
{
    self = [super init];
    if (self)
    {
        _tableView = tableView;
        _tableView.dataSource = self;
        _fetchedResultsController = controller;
        _fetchedResultsController.delegate = self;
        _delegate = delegate;
        _cellConfigurator = cellConfigurator;
        NSError *error;
        [_fetchedResultsController performFetch:&error];
    }

    return self;
}


#pragma mark - Table view datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.fetchedResultsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    id<NSFetchedResultsSectionInfo> section = self.fetchedResultsController.sections[sectionIndex];
    return section.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id objectAtIndex = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *reuseIdentifierForCell = [self.cellConfigurator fetchReuseIdentifierForObject:objectAtIndex];
    id cellAtIndex = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierForCell forIndexPath:indexPath];
    cellAtIndex = [self.cellConfigurator configureCell:cellAtIndex withObject:objectAtIndex];

    return cellAtIndex;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.delegate deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    }
}

- (id)selectedItem
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    return indexPath ? [self.fetchedResultsController objectAtIndexPath:indexPath] : nil;
}

#pragma mark - Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)setPaused:(BOOL)paused
{
    _paused = paused;
    if (paused)
    {
        self.fetchedResultsController.delegate = nil;
    }
    else
    {
        self.fetchedResultsController.delegate = self;
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        [self.tableView reloadData];
    }
}


@end
