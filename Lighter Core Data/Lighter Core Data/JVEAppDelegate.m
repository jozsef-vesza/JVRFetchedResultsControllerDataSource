//
//  JVEAppDelegate.m
//  Lighter Core Data
//
//  Created by Jozsef Vesza on 22/05/14.
//
//

#import "JVEAppDelegate.h"
#import "JVEPersistentStack.h"
#import "JVEItemsView.h"

@implementation JVEAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    JVEPersistentStack *initialStack = [[JVEPersistentStack alloc] initWithStoreURL:[self storeURL] modelURL:[self modelURL]];
    UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    JVEItemsView *mainController = (JVEItemsView *)navController.topViewController;
    mainController.managedObjectContext = initialStack.managedObjectContext;
    return YES;
}

- (NSURL *)storeURL
{
    NSURL *documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:NULL];
    return [documentsDirectory URLByAppendingPathComponent:@"db.sqlite"];
}

- (NSURL *)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"Lighter_Core_Data" withExtension:@"momd"];
}

@end
