## A port of the [Swift library](https://www.github.com/squimer/DatePickerDialog-iOS-Swift/) by Squimer

This port was made so that the features of the DatePickerDialog could be used in a Objective-C project without having to import the Swift runtime in your app binary (which can increase the app binary size quite a bit)

# DatePickerDialog - iOS - Objective-C

DatePickerDialog is an iOS drop-in class that displays an UIDatePicker within an UIAlertView.

[![](https://raw.githubusercontent.com/gameleon-dev/DatePickerDialog-iOS-ObjC/master/screen1.png)](https://github.com/gameleon-dev/DatePickerDialog-iOS-ObjC/tree/master)

## Requirements

DatePickerDialog works on iOS 8, 9 and 10. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

* Foundation
* UIKit

## Installation
#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `DatePickerDialog-ObjC` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
pod 'DatePickerDialog-ObjC'
```

To get the full benefits import `LSLDatePickerDialog` wherever you import UIKit

``` objective-c
#import <UIKit/UIKit.h>
#import "LSLDatePickerDialog.h"
```

#### Manually
1. Download and drop ```LSLDatePickerDialog.h``` and  ```LSLDatePickerDialog.m``` in your project.
2. Congratulations!

## Example

```objective-c
#import "LSLDatePickerDialog.h"

@implementation ViewController {


-(void)openDatePicker {
      LSLDatePickerDialog *dpDialog = [[LSLDatePickerDialog alloc] init];
	    [dpDialog showWithTitle:@"DatePicker" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel"
		      defaultDate:[NSDate date] minimumDate:nil maximumDate:nil datePickerMode:UIDatePickerModeDate
		      callback:^(NSDate * _Nullable date){
		  	  if(date)
         		  {
			  	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            		 	[formatter setDateStyle:NSDateFormatterMediumStyle];
				NSLog(@"Date selected: %@",[formatter stringFromDate:date]);
	 		  }
		      }
	     ];
}
```

## Dialog initalizer parameters
- showCancelButton: Bool - default true
- locale: Locale - default nil

Example initialization without 'Cancel' button:
```objective-c
LSLDatePickerDialog *dpDialog = [[LSLDatePickerDialog alloc] initWithCancelButton:NO];

```
Example initialization with locale:
```objective-c
LSLDatePickerDialog *dpDialog = [[LSLDatePickerDialog alloc] initWithLocale:[Locale localeWithLocaleIdentifier:@“ja_JP”]];
```

## Show parameters

- title: String **(Required)**
- doneButtonTitle: String
- cancelButtonTitle: String
- defaultDate: Date
- minimumDate: Date
- maximumDate: Date
- datePickerMode: UIDatePickerMode **(Required)**
- callback: ((date: Date) -> Void) **(Required)**

## Special thanks to

* [@squimer](https://github.com/squimer) for creating [the Swift version](https://github.com/wimagguc/ios-custom-alertview) of this library, where this library was ported from.
* [@wimagguc](https://github.com/wimagguc) for the work with [ios-custom-alertview](https://github.com/wimagguc/ios-custom-alertview) library.

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
