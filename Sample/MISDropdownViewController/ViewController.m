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
    
    //Manage menu with attributed string (fb:gh#1)
    NSInteger menuCounter = 4;
    NSMutableArray *mutableMenus = [NSMutableArray arrayWithCapacity:menuCounter];
    for (int i = 0; i < menuCounter; i++) {
        NSString *iString = [NSString stringWithFormat:@"%d", i];
        NSAttributedString *extract1 = [[NSAttributedString alloc] initWithString:iString attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:14]}];
        NSAttributedString *extract2 = [[NSAttributedString alloc] initWithString:@"  The menu" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}];
        
        NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithAttributedString:extract1];
        [mutableString appendAttributedString:extract2];
        [mutableMenus addObject:[mutableString copy]];
        
    }
    
    self.dropdownMenuView = [[MISDropdownMenuView alloc] initWithItems:mutableMenus];
    //self.dropdownMenuView = [[MISDropdownMenuView alloc] initWithItems:@[@"menu 0", @"menu 1", @"menu 2", @"menu 3"]];
    
    self.dropdownMenuView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.dropdownMenuView addTarget:self action:@selector(dropMenuChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.selectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 200, CGRectGetWidth(self.view.frame), 20.0)];
    self.selectionLabel.textAlignment = NSTextAlignmentCenter;
    self.selectionLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //Manage menu with attributed string (fb:gh#1)
    [self setLabel:self.selectionLabel content:self.dropdownMenuView.items[self.dropdownMenuView.selectedItemIndex]];

    [self.view addSubview:self.selectionLabel];
}

/**
 * Set either text or attributed text property for the ui label in parameter according to the type of the content.
 * TODO: this method should be into a UILabel category.
 *
 * @author fb
 * @version fb:gh#1
 */
- (void)setLabel:(UILabel *)label content:(id)content
{
    if (![label isKindOfClass:[UILabel class]]) {
        return;
    }
    
    if ([content isKindOfClass:[NSString class]]) {
        label.text = (NSString *)content;
    }
    else if ([content isKindOfClass:[NSAttributedString class]]) {
        label.attributedText = (NSAttributedString *)content;
    }
}


#pragma mark - Actions

- (void)dropMenuChanged:(MISDropdownMenuView *)dropDownMenuView
{
    [self.dropdownViewController dismissDropdownAnimated:YES];
    
    NSInteger selectedItemIndex = [dropDownMenuView selectedItemIndex];

    //Manage menu with attributed string (fb:gh#1)
    [self setLabel:self.selectionLabel content:self.dropdownMenuView.items[selectedItemIndex]];
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
