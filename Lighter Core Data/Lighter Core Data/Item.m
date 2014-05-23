//
//  Item.m
//  Lighter Core Data
//
//  Created by Jozsef Vesza on 23/05/14.
//
//

#import "Item.h"


@implementation Item

@dynamic date;
@dynamic title;

+ (instancetype)insertItemWithTitle:(NSString *)title withDate:(NSDate *)date inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    Item *item = [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:managedObjectContext];
    item.title = title;
    item.date = date;
    
    return item;
}

+ (NSString *)entityName
{
    return @"Item";
}

@end
