
#import "LSLDatePickerDialog.h"

@interface LSLDatePickerDialog()


@property (nonatomic,weak) UIView* dialogView;
@property (nonatomic,weak) UILabel* titleLabel;
@property (nonatomic,weak) UIButton* cancelButton;
@property (nonatomic,weak) UIButton* doneButton;

@property (nonatomic,strong) NSDate* defaultDate;
@property (nonatomic) UIDatePickerMode datePickerMode;
@property (nonatomic,strong) DatePickerCallback callback;

@property BOOL showCancelButton;
@property (nonatomic,strong) NSLocale *locale;

@property (nonatomic,strong) UIColor* textColor;
@property (nonatomic,strong) UIColor* buttonColor;
@property (nonatomic,strong) UIFont* font;
@end

@implementation LSLDatePickerDialog
static CGFloat const kDatePickerDialogDefaultButtonHeight = 50.0;
static CGFloat const kDatePickerDialogDefaultButtonSpacerHeight = 1.0;
static CGFloat const kDatePickerDialogCornerRadius = 7.0;
static NSInteger const kDatePickerDialogDoneButtonTag = 1;


-(instancetype)init{
    self = [self initWithCancelButton:YES];
    return self;
}

-(instancetype)initWithLocale:(NSLocale*)locale{
    self = [self initWithTextColor:nil buttonColor:nil font:nil locale:locale cancelButton:YES];
    return self;
}

-(instancetype)initWithCancelButton:(BOOL)showCancelButton{
    self = [self initWithTextColor:nil buttonColor:nil font:nil locale:nil cancelButton:showCancelButton];
    return self;
}


-(instancetype)initWithLocale:(NSLocale*)locale cancelButton:(BOOL)showCancelButton{
    self = [self initWithTextColor:nil buttonColor:nil font:nil locale:locale cancelButton:showCancelButton];
    return self;
}

-(instancetype)initWithTextColor:(UIColor*)textColor buttonColor:(UIColor*)buttonColor font:(UIFont*)font locale:(NSLocale*)locale cancelButton:(BOOL)showCancelButton{
    self = [super initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width,UIScreen.mainScreen.bounds.size.height)];
    if(self)
    {
        self.textColor = textColor ? textColor : [UIColor blackColor];
        self.buttonColor = buttonColor ? buttonColor : [UIColor blueColor];
        self.font = font ? font : [UIFont boldSystemFontOfSize:15.0];
        self.showCancelButton = showCancelButton;
        self.locale = locale;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UIView* dialogView = [self createContainerView];
    
    dialogView.layer.shouldRasterize = YES;
    dialogView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    dialogView.layer.opacity = 0.5;
    dialogView.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1);
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [self addSubview:dialogView];
    self.dialogView = dialogView;
}

/** Handle device orientation changes */
- (void)deviceOrientationDidChangeWithNotification:(NSNotification*)notification {
    self.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = CGSizeMake(300,230 + kDatePickerDialogDefaultButtonHeight + kDatePickerDialogDefaultButtonSpacerHeight);
    _dialogView.frame = CGRectMake((screenSize.width - dialogSize.width) / 2,(screenSize.height - dialogSize.height) / 2, dialogSize.width, dialogSize.height);
}

-(void)showWithCallback:(DatePickerCallback)callback
{
    [self showWithTitle:@"DialogPicker" doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" defaultDate:[NSDate date] minimumDate:nil maximumDate:nil datePickerMode:UIDatePickerModeDateAndTime callback:callback];
}

-(void)showWithTitle:(NSString *)title callback:(DatePickerCallback)callback
{
    [self showWithTitle:title doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" defaultDate:[NSDate date] minimumDate:nil maximumDate:nil datePickerMode:UIDatePickerModeDateAndTime callback:callback];
}

-(void)showWithTitle:(NSString *)title doneButtonTitle:(NSString *)doneButtonTitle cancelButtonTitle:(NSString *)cancelButtonTitle defaultDate:(NSDate *)defaultDate datePickerMode:(UIDatePickerMode)datePickerMode callback:(DatePickerCallback)callback
{
    [self showWithTitle:title doneButtonTitle:doneButtonTitle cancelButtonTitle:cancelButtonTitle defaultDate:defaultDate minimumDate:nil maximumDate:nil datePickerMode:datePickerMode callback:callback];
}

/** Create the dialog view, and animate opening the dialog */
- (void)showWithTitle:(NSString*)title doneButtonTitle:(NSString*)doneButtonTitle cancelButtonTitle:(NSString*)cancelButtonTitle defaultDate:(NSDate*)defaultDate minimumDate:(NSDate*)minimumDate maximumDate:(NSDate*)maximumDate datePickerMode:(UIDatePickerMode)datePickerMode callback:(DatePickerCallback)callback {
    self.titleLabel.text = title;
    [self.doneButton setTitle:doneButtonTitle forState:UIControlStateNormal];
    if(_showCancelButton)
    {
        [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    }
    self.datePickerMode = datePickerMode;
    self.callback = callback;
    self.defaultDate = defaultDate;
    self.datePicker.datePickerMode = self.datePickerMode;
    self.datePicker.date = self.defaultDate ? self.defaultDate : [NSDate date];
    self.datePicker.maximumDate = maximumDate;
    self.datePicker.minimumDate = minimumDate;
    if(self.locale) {
        self.datePicker.locale = self.locale;
    }
    /* Add dialog to main window */
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    UIWindow* window = delegate.window;
    [window addSubview:self];
    [window bringSubviewToFront:self];
    [window endEditing:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChangeWithNotification:) name:UIDeviceOrientationDidChangeNotification object: nil];
    
    /* Anim */
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.4];
        self.dialogView.layer.opacity = 1;
        self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    } completion:^(BOOL finished) {
        
    }];
}

/** Dialog close animation then cleaning and removing the view from the parent */
- (void)close{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    CATransform3D currentTransform = self.dialogView.layer.transform;
    
    CGFloat startRotation = [[self valueForKeyPath:@"layer.transform.rotation.z"] doubleValue];
    CATransform3D rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + M_PI * 270 / 180), 0, 0, 0);
    
    self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1));
    self.dialogView.layer.opacity = 1;
    
     [UIView animateWithDuration:0.2 delay:0 options:0 animations:^{
         self.backgroundColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0];
         self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1));
         self.dialogView.layer.opacity = 0;
     } completion:^(BOOL finished) {
       for(UIView* v in self.subviews) {
           [v removeFromSuperview];
       }
           
         [self removeFromSuperview];
         [self setupView];
     }];
}

/** Creates the container view here: create the dialog, then add the custom content and buttons*/
- (UIView*)createContainerView{
    CGSize screenSize = [self countScreenSize];
    CGSize dialogSize = CGSizeMake(300,230 + kDatePickerDialogDefaultButtonHeight + kDatePickerDialogDefaultButtonSpacerHeight);
    
    // For the black background
    self.frame = CGRectMake(0,0,screenSize.width,screenSize.height);
    
    // This is the dialog's container; we attach the custom content and the buttons to this one
    UIView* dialogContainer = [[UIView alloc] initWithFrame:CGRectMake((screenSize.width - dialogSize.width) / 2.0,(screenSize.height - dialogSize.height) / 2.0,dialogSize.width,dialogSize.height)];
    
    // First, we style the dialog to match the iOS8 UIAlertView >>>
    CAGradientLayer* gradient = [[CAGradientLayer alloc] initWithLayer:self.layer];
    gradient.frame = dialogContainer.bounds;
    gradient.colors = (@[(id)[UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1.0].CGColor,
                         (id)[UIColor colorWithRed: 233.0/255.0 green: 233.0/255.0 blue: 233.0/255.0 alpha: 1.0].CGColor,
                         (id)[UIColor colorWithRed: 218.0/255.0 green: 218.0/255.0 blue: 218.0/255.0 alpha: 1.0].CGColor]);
    
    CGFloat cornerRadius = kDatePickerDialogCornerRadius;
    gradient.cornerRadius = cornerRadius;
    [dialogContainer.layer insertSublayer:gradient above:0];
    
    dialogContainer.layer.cornerRadius = cornerRadius;
    dialogContainer.layer.borderColor = [UIColor colorWithRed: 198.0/255.0 green: 198.0/255.0 blue: 198.0/255.0 alpha: 1.0].CGColor;
    dialogContainer.layer.borderWidth = 1;
    dialogContainer.layer.shadowRadius = cornerRadius + 5.0;
    dialogContainer.layer.shadowOpacity = 0.1;
    dialogContainer.layer.shadowOffset = CGSizeMake(0 - (cornerRadius + 5.0) / 2.0, 0 - (cornerRadius + 5.0) / 2.0);
    dialogContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    dialogContainer.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:dialogContainer.bounds cornerRadius:dialogContainer.layer.cornerRadius].CGPath;
    
    // There is a line above the button
    UIView* lineView = [[UIView alloc] initWithFrame:CGRectMake(0,dialogContainer.bounds.size.height - kDatePickerDialogDefaultButtonHeight - kDatePickerDialogDefaultButtonSpacerHeight,dialogContainer.bounds.size.width,kDatePickerDialogDefaultButtonSpacerHeight)];
    lineView.backgroundColor = [UIColor colorWithRed: 198.0/255.0 green: 198.0/255.0 blue: 198.0/255.0 alpha: 1.0];
    [dialogContainer addSubview:lineView];
    
    //Title
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10,280,30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = self.textColor;
    titleLabel.font = [self.font fontWithSize:17.0f];
    [dialogContainer addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 30, 0, 0)];
    [datePicker setValue:self.textColor forKeyPath:@"textColor"];
    datePicker.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    CGRect datePickerFrame = datePicker.frame;
    datePickerFrame.size.width = 300;
    datePickerFrame.size.height = 216;
    datePicker.frame = datePickerFrame;
    [dialogContainer addSubview:datePicker];
    self.datePicker = datePicker;
    
    // Add the buttons
    [self addButtonsToView:dialogContainer];
    
    return dialogContainer;
}

/** Add buttons to container */
- (void)addButtonsToView:(UIView*)container {
    NSInteger buttonWidth = container.bounds.size.width / 2;
    
    CGRect leftButtonFrame = CGRectMake(0,container.bounds.size.height - kDatePickerDialogDefaultButtonHeight,buttonWidth,kDatePickerDialogDefaultButtonHeight);
    CGRect rightButtonFrame = CGRectMake(buttonWidth,container.bounds.size.height - kDatePickerDialogDefaultButtonHeight,buttonWidth,kDatePickerDialogDefaultButtonHeight);
    
    if(!_showCancelButton){
        buttonWidth = container.bounds.size.width;
        leftButtonFrame = CGRectZero;
        rightButtonFrame = CGRectMake(0,container.bounds.size.height - kDatePickerDialogDefaultButtonHeight,buttonWidth,kDatePickerDialogDefaultButtonHeight);
    }
    UIUserInterfaceLayoutDirection interfaceLayoutDirection = UIApplication.sharedApplication.userInterfaceLayoutDirection;
    BOOL isLeftToRightDirection = interfaceLayoutDirection == UIUserInterfaceLayoutDirectionLeftToRight;
    if(_showCancelButton)
    {
        UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = isLeftToRightDirection ? leftButtonFrame : rightButtonFrame;
        [cancelButton setTitleColor:self.buttonColor forState:UIControlStateNormal];
        [cancelButton setTitleColor:self.buttonColor forState:UIControlStateHighlighted];
        cancelButton.titleLabel.font = [self.font fontWithSize:14.0];
        cancelButton.layer.cornerRadius = kDatePickerDialogCornerRadius;
        [cancelButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:cancelButton];
        self.cancelButton = cancelButton;
    }
    
    UIButton* doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = isLeftToRightDirection ? rightButtonFrame : leftButtonFrame;
    doneButton.tag = kDatePickerDialogDoneButtonTag;
    [doneButton setTitleColor:self.buttonColor forState:UIControlStateNormal];
    [doneButton setTitleColor:self.buttonColor forState:UIControlStateHighlighted];
    doneButton.titleLabel.font = [self.font fontWithSize:14.0];
    doneButton.layer.cornerRadius = kDatePickerDialogCornerRadius;
    [doneButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:doneButton];
    self.doneButton = doneButton;
}

/** Selector for button tap */
- (void)buttonTapped:(UIButton*) sender {
    if(sender.tag == kDatePickerDialogDoneButtonTag) {
        _callback(self.datePicker.date);
    } else {
        _callback(nil);
    }
    
    [self close];
}

/** Count and return the screen's size */
- (CGSize)countScreenSize{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    return CGSizeMake(screenWidth,screenHeight);
}

@end
