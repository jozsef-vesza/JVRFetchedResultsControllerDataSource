//
//  JVENewItemView.h
//  Lighter Core Data
//
//  Created by Jozsef Vesza on 23/05/14.
//
//

#import <UIKit/UIKit.h>
@class Item;

@interface JVENewItemView : UIViewController

@property (nonatomic,strong) Item *item;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;

@end
