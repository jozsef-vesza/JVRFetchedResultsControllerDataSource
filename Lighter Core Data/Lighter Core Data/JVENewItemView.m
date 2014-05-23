//
//  JVENewItemView.m
//  Lighter Core Data
//
//  Created by Jozsef Vesza on 23/05/14.
//
//

#import "JVENewItemView.h"
#import "Item.h"

@interface JVENewItemView ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *itemTitleField;

@end

@implementation JVENewItemView

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.itemTitleField.delegate = self;
    [self.itemTitleField becomeFirstResponder];
    
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender
{
    self.item.title = self.itemTitleField.text;
    NSError *error;
    [self.managedObjectContext save:&error];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender
{
    [self.managedObjectContext deleteObject:self.item];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self saveButtonPressed:nil];
    return YES;
}

@end
