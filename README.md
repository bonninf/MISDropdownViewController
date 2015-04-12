MISDropdownViewController
=============

Simple UI component that represents content as dropdown on iPhone and popover on iPad by default.

Configurable to show the content always as dropdown or as popover (iPad only) and if the dropdown should appear at the top or bottom. Automatically detects a navigation or tabbar.

MISDropdownViewController uses ARC and supports iOS 7.0+

<center>
<img src="http://i.imgur.com/c5Ly2hZ.png" width="300"/>
</center>

## Installing

MISDropdownViewController can be installed by [CocoaPods](http://cocoapods.org). Simply add this line to your `Podfile`:
````
pod 'MISDropdownViewController'
````

And run `pod install`.

Or just add the files from the MISDropdownViewController folder to your project.


## Usage

```objective-c
// Create MISDropdownViewController
MISDropdownViewController dropdownViewController = [[MISDropdownViewController alloc] initWithPresentationMode:MISDropdownViewControllerPresentationModeAutomatic];
dropdownViewController.contentView = dropdownMenuView; // Some content view

// Show and sender is UIBarButtonItem and show from top
[self.dropdownViewController presentDropdownFromBarButtonItem:sender inViewController:self position:MISDropdownViewControllerPositionTop];

// Show and sender is UIButton and show bottom
CGRect rect = [sender convertRect:[sender bounds] toView:self.view];
[dropdownViewController presentDropdownFromRect:rect inViewController:self position:MISDropdownViewControllerPositionBottom];

// Hide
[dropdownViewController dismissDropdownAnimated:YES];
```


## Creator

[Michael Schneider](http://mischneider.net)
[@maicki](https://twitter.com/maicki)

## License

MISDropdownViewController is available under the MIT license. See the LICENSE file for more info.
