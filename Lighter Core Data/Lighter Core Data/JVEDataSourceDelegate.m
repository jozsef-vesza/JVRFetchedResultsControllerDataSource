//
//  JVEDataSourceDelegate.m
//  Lighter Core Data
//
//  Created by Jozsef Vesza on 23/05/14.
//
//

#import "JVEDataSourceDelegate.h"
#import "Item.h"

@interface JVEDataSourceDelegate ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation JVEDataSourceDelegate

+ (instancetype)delegateWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    return [[self alloc] initWithManagedObjectContext:managedObjectContext];
}

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
{
    self = [super init];
    if (self)
    {
        _managedObjectContext = managedObjectContext;
    }
    
    return self;
}

- (NSString *)fetchReuseIdentifierForObject:(id)object
{
    return @"Cell";
}

- (UITableViewCell *)configureCell:(UITableViewCell *)cell withObject:(Item *)object
{
    cell.textLabel.text = object.title;
    return cell;
}

- (void)deleteObject:(Item *)object
{
    [self.managedObjectContext deleteObject:object];
    NSError *e;
    [self.managedObjectContext save:&e];
}

@end
