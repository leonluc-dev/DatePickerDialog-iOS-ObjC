
#import <UIKit/UIKit.h>

@interface LSLDatePickerDialog : UIView
typedef void (^DatePickerCallback)(NSDate* __nullable date);

@property (nonatomic,strong) UIDatePicker* __nullable datePicker;

- (void)showWithCallback:(nullable DatePickerCallback)callback;
- (void)showWithTitle:(nonnull NSString*)title callback:(nullable DatePickerCallback)callback;
- (void)showWithTitle:(nonnull NSString*)title doneButtonTitle:(nonnull NSString* )doneButtonTitle cancelButtonTitle:(nonnull NSString*)cancelButtonTitle defaultDate:(nonnull NSDate* )defaultDate datePickerMode:(UIDatePickerMode)datePickerMode callback:(nullable DatePickerCallback)callback;
- (void)showWithTitle:(nonnull NSString*)title doneButtonTitle:(nonnull NSString*)doneButtonTitle cancelButtonTitle:(nonnull NSString*)cancelButtonTitle defaultDate:(nonnull NSDate*)defaultDate minimumDate:(nullable NSDate*)minimumDate maximumDate:(nullable NSDate*)maximumDate datePickerMode:(UIDatePickerMode)datePickerMode callback:(nullable DatePickerCallback)callback;
@end
