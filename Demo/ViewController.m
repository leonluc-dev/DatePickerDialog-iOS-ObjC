
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
    
    LSLDatePickerDialog *dialog = [[LSLDatePickerDialog alloc] init];
    [dialog showWithTitle:@"Demo" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" defaultDate:[NSDate date] datePickerMode:UIDatePickerModeDate callback:^(NSDate * _Nullable date) {
        if(date)
        {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [_dateLabel setText:[NSString stringWithFormat:@"Date selected: %@",[formatter stringFromDate:date]]];
        }
    }];
}
@end
