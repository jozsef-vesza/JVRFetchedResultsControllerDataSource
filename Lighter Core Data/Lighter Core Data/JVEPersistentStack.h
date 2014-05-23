//
//  JVEPersistentStack.h
//  Lighter Core Data
//
//  Created by Jozsef Vesza on 23/05/14.
//
//

#import <Foundation/Foundation.h>

@interface JVEPersistentStack : NSObject

@property (nonatomic,strong,readonly) NSManagedObjectContext *managedObjectContext;

- (id)initWithStoreURL:(NSURL *)storeURL modelURL:(NSURL *)modelURL;

@end
