//
//  JVRFetchedResultsControllerDataSource.h
//  Lighter TVC Core Data
//
//  Created by Jozsef Vesza on 19/05/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 *  Helper delegate implemented by the class responsible for table view cell configuration and handling of item deletion
 */
@protocol JVRFetchedResultsControllerDataSourceDelegate

/**
 *  Retrieve the reuse identifier for a table view cell based on an object shown in it
 *
 *  @param object The object in the cell
 *
 *  @return An NSString instance with the identifier
 */
- (NSString *)fetchReuseIdentifierForObject:(id)object;

/**
 *  Customize a given table view cell using the properties of an object
 *
 *  @param cell   The cell to be configured
 *  @param object The object in the cell
 *
 *  @return The configured UITableViewCell instance
 */
- (UITableViewCell *)configureCell:(id)cell withObject:(id)object;

/**
 *  Handle deletion of an object shown in the table view
 *
 *  @param object The object to be deleted
 */
- (void)deleteObject:(id)object;

@end

/**
 *  JVRBaseTableViewDataSource is meant to be used by UITableViewController classes as data source and by NSFetchedResultsController as delegate
 */
@interface JVRFetchedResultsControllerDataSource : NSObject<NSFetchedResultsControllerDelegate, UITableViewDataSource>

/**
 *  Property to assure the data source is up to date
 */
@property (nonatomic) BOOL paused;

/**
 *  Convenience initializer method
 *
 *  @param tableView  The table view which will use this instance as data source
 *  @param controller The fetched results controller which will use this instance as delegate
 *  @param delegate   The helper delegate instance for customizing cells and handling item deletion
 *
 *  @return An initialized instance of JVRFetchedResultsControllerDataSourceDelegate
 */
+ (instancetype)dataSourceForTableView:(UITableView *)tableView
          withFetchedResultsController:(NSFetchedResultsController *)controller
                         usingDelegate:(id <JVRFetchedResultsControllerDataSourceDelegate>)delegate;

/**
 *  The object at the current index path
 *
 *  @return The selected object
 */
- (id)selectedItem;

@end
