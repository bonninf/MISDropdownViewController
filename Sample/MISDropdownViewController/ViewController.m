//
//  ViewController.m
//  MISDropdownViewController
//
//  Created by Michael Schneider on 4/11/15.
//  Copyright (c) 2015 mischneider. All rights reserved.
//

#import "ViewController.h"
#import "MISDropdownViewController.h"
#import "MISDropdownMenuView.h"

@interface ViewController ()
@property (strong, nonatomic) MISDropdownViewController *dropdownViewController;
@property (strong, nonatomic) MISDropdownMenuView *dropdownMenuView;
@property (strong, nonatomic) UILabel *selectionLabel;
@end

@implementation ViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(toggleMenu:)];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    self.dropdownMenuView = [[MISDropdownMenuView alloc] initWithItems:@[@"Item1", @"Item2", @"Item3"]];
    self.dropdownMenuView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.dropdownMenuView addTarget:self action:@selector(dropMenuChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.selectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 200, CGRectGetWidth(self.view.frame), 20.0)];
    self.selectionLabel.textAlignment = NSTextAlignmentCenter;
    self.selectionLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.selectionLabel.text = self.dropdownMenuView.items[self.dropdownMenuView.selectedItemIndex];
    [self.view addSubview:self.selectionLabel];
}


#pragma mark - Actions

- (void)dropMenuChanged:(MISDropdownMenuView *)dropDownMenuView
{
    [self.dropdownViewController dismissDropdownAnimated:YES];
    
    NSInteger selectedItemIndex = [dropDownMenuView selectedItemIndex];
    self.selectionLabel.text = dropDownMenuView.items[selectedItemIndex];
}

- (void)toggleMenu:(id)sender
{
    if (self.dropdownViewController == nil) {
        // Prepare content view
        CGFloat width = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 320.0 : self.view.bounds.size.width;
        CGSize size = [self.dropdownMenuView sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
        self.dropdownMenuView.frame = CGRectMake(self.dropdownMenuView.frame.origin.x, self.dropdownMenuView.frame.origin.y, size.width, size.height);
        
        self.dropdownViewController = [[MISDropdownViewController alloc] initWithPresentationMode:MISDropdownViewControllerPresentationModeAutomatic];
        self.dropdownViewController.contentView = self.dropdownMenuView;
    }
    
    // Show/hide dropdown view
    if ([self.dropdownViewController isDropdownVisible]) {
        [self.dropdownViewController dismissDropdownAnimated:YES];
        return;
    }

    // Sender is UIBarButtonItem
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        [self.dropdownViewController presentDropdownFromBarButtonItem:sender inViewController:self position:MISDropdownViewControllerPositionTop];
        return;
    }
    
    // Sender is UIButton
    CGRect rect = [sender convertRect:[sender bounds] toView:self.view];
    [self.dropdownViewController presentDropdownFromRect:rect inViewController:self position:MISDropdownViewControllerPositionBottom];
}

@end
