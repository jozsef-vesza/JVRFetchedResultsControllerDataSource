//
//  JVEDataSourceDelegate.h
//  Lighter Core Data
//
//  Created by Jozsef Vesza on 23/05/14.
//
//

#import <Foundation/Foundation.h>
#import "JVRFetchedResultsControllerDataSource.h"

@interface JVEDataSourceDelegate : NSObject<JVRFetchedResultsControllerDataSourceDelegate>

+ (instancetype)delegateWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
