//
//  JVRFetchedResultsControllerDataSource.h
//  Lighter TVC Core Data
//
//  Created by Jozsef Vesza on 19/05/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol JVRFetchedResultsControllerDataSourceDelegate

- (NSString *)fetchReuseIdentifierForObject:(id)object;
- (UITableViewCell *)configureCell:(id)cell withObject:(id)object;
- (void)deleteObject:(id)object;

@end

@interface JVRFetchedResultsControllerDataSource : NSObject<NSFetchedResultsControllerDelegate, UITableViewDataSource>

@property (nonatomic) BOOL paused;

+ (instancetype)dataSourceForTableView:(UITableView *)tableView
          withFetchedResultsController:(NSFetchedResultsController *)controller
                         usingDelegate:(id <JVRFetchedResultsControllerDataSourceDelegate>)delegate;

- (id)selectedItem;

@end
