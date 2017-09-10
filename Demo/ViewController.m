
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showPickBtnTapped:(id)sender {
    NSDate* currentDate = [NSDate dateWithTimeIntervalSinceNow:3600 * 24 * 7]; //One week from now
    
    NSDateComponents* dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = -3;
    NSDate* threeYearsAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    LSLDatePickerDialog *dialog = [[LSLDatePickerDialog alloc] initWithTextColor:[UIColor redColor] buttonColor:[UIColor redColor] font:[UIFont boldSystemFontOfSize:14.0] locale:nil cancelButton:YES];
    [dialog showWithTitle:@"Demo" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" defaultDate:[NSDate date] minimumDate:threeYearsAgo maximumDate:currentDate datePickerMode:UIDatePickerModeDate callback:^(NSDate * _Nullable date) {
        if(date)
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterLongStyle];
            [formatter setTimeStyle:NSDateFormatterLongStyle];
            [_dateTextField setText:[formatter stringFromDate:date]];
        }
    }];
}
@end
