//
//  Item.h
//  Lighter Core Data
//
//  Created by Jozsef Vesza on 23/05/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * title;

+ (instancetype)insertItemWithTitle:(NSString *)title withDate:(NSDate *)date inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
