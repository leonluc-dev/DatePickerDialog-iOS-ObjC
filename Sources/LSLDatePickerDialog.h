
#import <UIKit/UIKit.h>

/**
 LSLDatePickerDialog displays an UIDatePicker in a dialog similar in style to UIAlertView/UIAlertController
 */
@interface LSLDatePickerDialog : UIView
typedef void (^DatePickerCallback)(NSDate* __nullable date);

@property (nonatomic,weak) UIDatePicker* __nullable datePicker;

/**
 Shows a LSLDatePickerDialog on the current UIWindow
 @param callback The block to execute when the dialog closes. The date parameter will be nil if the cancel button was tapped
 */
- (void)showWithCallback:(nullable DatePickerCallback)callback;

/**
 Shows a LSLDatePickerDialog on the current UIWindow
 @param title     The title to show on the dialog
 @param callback  The block to execute when the dialog closes. The date parameter will be nil if the cancel button was tapped
 */
- (void)showWithTitle:(nonnull NSString*)title callback:(nullable DatePickerCallback)callback;

/**
 Shows a LSLDatePickerDialog on the current UIWindow
 @param title                 The title to show on the dialog
 @param doneButtonTitle       The title to show on the done button of the dialog
 @param cancelButtonTitle     The title to show on the cancel button of the dialog
 @param defaultDate           The initially selected date of the dialog
 @param datePickerMode        The type of information displayed on the dialog's picker
 @param callback              The block to execute when the dialog closes. The date parameter will be nil if the cancel button was tapped
 */
- (void)showWithTitle:(nonnull NSString*)title doneButtonTitle:(nonnull NSString* )doneButtonTitle cancelButtonTitle:(nonnull NSString*)cancelButtonTitle defaultDate:(nonnull NSDate* )defaultDate datePickerMode:(UIDatePickerMode)datePickerMode callback:(nullable DatePickerCallback)callback;

/**
 Shows a LSLDatePickerDialog on the current UIWindow
 @param title                 The title to show on the dialog
 @param doneButtonTitle       The title to show on the done button of the dialog
 @param cancelButtonTitle     The title to show on the cancel button of the dialog
 @param defaultDate           The initially selected date of the dialog
 @param minimumDate           The earliest date selectable on the dialog's picker
 @param maximumDate           The latest date selectable on the dialog's picker
 @param datePickerMode        The type of information displayed on the dialog's picker
 @param callback              The block to execute when the dialog closes. The date parameter will be nil if the cancel button was tapped
 */
- (void)showWithTitle:(nonnull NSString*)title doneButtonTitle:(nonnull NSString*)doneButtonTitle cancelButtonTitle:(nonnull NSString*)cancelButtonTitle defaultDate:(nonnull NSDate*)defaultDate minimumDate:(nullable NSDate*)minimumDate maximumDate:(nullable NSDate*)maximumDate datePickerMode:(UIDatePickerMode)datePickerMode callback:(nullable DatePickerCallback)callback;
@end
