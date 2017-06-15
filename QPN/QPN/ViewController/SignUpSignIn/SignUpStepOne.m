//
//  SignUpStepOne.m
//  QPN
//
//  Created by Muhammad Usman on 12/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "SignUpStepOne.h"
#import "TextFieldCell.h"
#import "ButtonCell.h"
#import "MyCustomTF.h"
#import "EMCCountryPickerController.h"
#import "SignUpPayload.h"
#import "SignUpStepTwo.h"
#import "QPNSharedData.h"
#import "UIView+Toast.h"
#import "AppDelegate.h"


@interface SignUpStepOne ()<UITableViewDelegate,UITableViewDataSource,ButtonCellDelegate,EMCCountryDelegate,UITextFieldDelegate,TextFieldCellDelegate>

@property (nonatomic,strong) NSMutableArray* allData;
@property(nonatomic) NSDateFormatter *dateFormatter;


@end
typedef enum : NSUInteger {
    SimpleText,
    EmailText,
    NumberText,
    PickerText,
    PasswordText,
    NoneEditable,
    None
}TextFieldsType;


@implementation SignUpStepOne

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transparentLayer.hidden = YES;
    self.datePickerView.hidden = YES;
    self.selectionPopup.hidden = YES;
    SHARED_MANAGER.signUpPayload = nil;
    SHARED_MANAGER.signUpPayload = [[SignUpPayload alloc] init];
    [self cellsData];
    
}
-(void) cellsData
{
    self.allData = [NSMutableArray array];
    
    if (self.asPartner == false)
    {
        [self.allData addObject:@{@"placeholder":@"Member Type",@"FieldType":[NSNumber numberWithInt:PickerText],@"PayLoad":SHARED_MANAGER.signUpPayload.member_type}];
        [self.allData addObject:@{@"placeholder":@"Title",@"FieldType":[NSNumber numberWithInt:PickerText],@"PayLoad":SHARED_MANAGER.signUpPayload.title}];
        [self.allData addObject:@{@"placeholder":@"First Name",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.first_name}];
        [self.allData addObject:@{@"placeholder":@"Middle Name",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.middle_name}];
        [self.allData addObject:@{@"placeholder":@"Last Name",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.last_name}];
        [self.allData addObject:@{@"placeholder":@"Date of Birth (yyy/mm/dd)",@"FieldType":[NSNumber numberWithInt:PickerText],@"PayLoad":SHARED_MANAGER.signUpPayload.d_o_b}];
        [self.allData addObject:@{@"placeholder":@"Gender",@"FieldType":[NSNumber numberWithInt:PickerText],@"PayLoad":SHARED_MANAGER.signUpPayload.gender}];
       // [self.allData addObject:@{@"placeholder":@"Contact Number",@"FieldType":[NSNumber numberWithInt:NumberText],@"PayLoad":SHARED_MANAGER.signUpPayload.mobile_number}];
    }
    else
    {
        [self.allData addObject:@{@"placeholder":@"Company Name",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.company_name}];
        [self.allData addObject:@{@"placeholder":@"Company Address",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.company_address}];
        [self.allData addObject:@{@"placeholder":@"Country",@"FieldType":[NSNumber numberWithInt:PickerText],@"PayLoad":SHARED_MANAGER.signUpPayload.country}];
        [self.allData addObject:@{@"placeholder":@"Company url (Optional)",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.company_url}];
        [self.allData addObject:@{@"placeholder":@"Industry Name",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.industry_name}];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnPressed:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark tableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allData.count+1 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > self.allData.count-1)
    {
        return 100;
    }
    return 61.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < _allData.count)
    {
        NSDictionary * data = [self.allData objectAtIndex:indexPath.row];
        static NSString *simpleTableIdentifier = @"textField";
        
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        switch ([data[@"FieldType"] intValue])
        {
            case SimpleText:
                cell.textField.keyboardType = UIKeyboardTypeDefault;
                break;
            case EmailText:
                cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
                break;
            case NumberText:
                cell.textField.keyboardType = UIKeyboardTypeNumberPad;
                break;
            case PasswordText:
                cell.textField.secureTextEntry = YES;
                break;
                
            default:
                break;
        }
        [cell.textField addTarget:self
                      action:@selector(textFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
        cell.TFCellDelegate = self;
        cell.textField.placeholder = data[@"placeholder"];
        cell.textField.row = (int)indexPath.row;
        cell.textField.text = data[@"PayLoad"];
       
        
        
        
        
        cell.btn.hidden = NO;
        if (!self.asPartner)
        {
            if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 7) {
                cell.btn.hidden = YES;
            }
            
        }
        else
        {
            if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4) {
                cell.btn.hidden = YES;
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        static NSString *simpleTableIdentifier = @"ButtonCell";
        
        ButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ButtonCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            [cell.ButtonClick setTitle:@"Next" forState:UIControlStateNormal];
            
        }
        cell.btnDelegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- textfiled
-(void)textFieldDidChange:(MyCustomTF *)textField{
    
    if (!self.asPartner)
    {
        switch (textField.row)
        {
            case 2:
                SHARED_MANAGER.signUpPayload.first_name = textField.text;
                break;
            case 3:
                SHARED_MANAGER.signUpPayload.middle_name = textField.text;
                break;
            case 4:
                SHARED_MANAGER.signUpPayload.last_name = textField.text;
                break;
            case 7:
                SHARED_MANAGER.signUpPayload.mobile_number = textField.text;
                break;
                
            default:
                break;
        }
    }
    else
    {
        switch (textField.row)
        {
            case 0:
                SHARED_MANAGER.signUpPayload.company_name = textField.text;
                break;
            case 1:
                SHARED_MANAGER.signUpPayload.company_address = textField.text;
                break;
            case 3:
                SHARED_MANAGER.signUpPayload.company_url = textField.text;
                break;
            case 4:
                SHARED_MANAGER.signUpPayload.industry_name = textField.text;
                break;
                
            default:
                break;
        }
    }
    
    NSMutableDictionary * dic = [[self.allData objectAtIndex:textField.row] mutableCopy];
    dic[@"PayLoad"] = textField.text;
    [self.allData replaceObjectAtIndex:textField.row withObject:dic];
}

-(void) optionPicker:(id) sender cellIndexD:(int) ind
{
    [self.view endEditing:YES];
    if (!self.asPartner) {
        if (ind == 0) // member type
        {
            self.popupType = @"MemberType";
            self.transparentLayer.hidden = NO;
            self.selectionPopup.hidden = NO;
            self.selectTitle.text = @"Select Member Type";
            [self.optionOneBtn setTitle:@"Professional" forState:UIControlStateNormal];
            [self.optionTwoBtn setTitle:@"Student" forState:UIControlStateNormal];
        }
        else if(ind == 1)
        {
            self.popupType = @"TitleType";
            self.transparentLayer.hidden = NO;
            self.selectionPopup.hidden = NO;
            self.selectTitle.text = @"Select Title";
            [self.optionOneBtn setTitle:@"Mr" forState:UIControlStateNormal];
            [self.optionTwoBtn setTitle:@"Ms" forState:UIControlStateNormal];
        }
        else if(ind == 5) // date Picker
        {
            self.datePickerView.hidden = NO;
            self.transparentLayer.hidden = NO;
        }
        else if(ind == 6) //gender
        {
            self.popupType = @"GenderType";
            self.transparentLayer.hidden = NO;
            self.selectionPopup.hidden = NO;
            self.selectTitle.text = @"Select Gender";
            [self.optionOneBtn setTitle:@"Male" forState:UIControlStateNormal];
            [self.optionTwoBtn setTitle:@"Female" forState:UIControlStateNormal];
        }
    }
    else
    {
        if (ind == 2)
        {
            [self showCountryPicker];
        }
    }
}
#pragma mark- BtnCell Delegate
-(void) btnClicked:(id) sender cellIndexD:(NSIndexPath*) ind
{
    
    SignUpStepTwo * vc;
    vc = [[SignUpStepTwo alloc] initWithNibName:@"SignUpStepTwo" bundle:[NSBundle mainBundle]];
    vc.asPartner = self.asPartner;
    self.navigationController.navigationBar.hidden = YES;
    
    if (!self.asPartner) {
        if (SHARED_MANAGER.signUpPayload.member_type.length == 0 && SHARED_MANAGER.signUpPayload.title.length == 0 && SHARED_MANAGER.signUpPayload.first_name.length == 0 && SHARED_MANAGER.signUpPayload.middle_name.length == 0 && SHARED_MANAGER.signUpPayload.last_name.length == 0 && SHARED_MANAGER.signUpPayload.d_o_b.length == 0 && SHARED_MANAGER.signUpPayload.gender.length == 0 && SHARED_MANAGER.signUpPayload.mobile_number.length == 0)
        {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Can't go next with Empty Fields"];
        }
        
        else if (SHARED_MANAGER.signUpPayload.member_type.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Member Type Missing"];
        }
        else if (SHARED_MANAGER.signUpPayload.title.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Title Missing"];
        }
        else if (SHARED_MANAGER.signUpPayload.first_name.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"First Name Missing"];
        }
        else if (SHARED_MANAGER.signUpPayload.middle_name.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Middle Name Missing"];
        }
        else if (SHARED_MANAGER.signUpPayload.last_name.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Last Name Missing"];
        }
        /*else if (SHARED_MANAGER.signUpPayload.d_o_b.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Date of Birth Missing"];
        }
        else if (![self isAgeThirteen]){
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Your age should be greater than or equal to 13."];
        }
        else if (SHARED_MANAGER.signUpPayload.gender.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Gender Missing"];
        }
        else if (SHARED_MANAGER.signUpPayload.mobile_number.length < 10) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Invalid Number.Number should be 10 digits long and do not start with 0"];
        }
        else if (![self isNumberOnly:SHARED_MANAGER.signUpPayload.mobile_number]) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Invalid Number.Number should be 10 digits long and do not start with 0"];
        }
        else if (SHARED_MANAGER.signUpPayload.mobile_number.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Mobile Number Missing"];
        }*/
        else
        {
           [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else
    {
        
        if (SHARED_MANAGER.signUpPayload.company_name.length == 0 && SHARED_MANAGER.signUpPayload.company_address.length == 0 && SHARED_MANAGER.signUpPayload.country.length == 0 && SHARED_MANAGER.signUpPayload.company_url.length == 0 && SHARED_MANAGER.signUpPayload.industry_name.length == 0)
        {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Can't go next with Empty Fields"];
        }
        
        else if (SHARED_MANAGER.signUpPayload.company_name.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Company Name Missing"];
        }
        else if (SHARED_MANAGER.signUpPayload.company_address.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Company Address Missing"];
        }
        else if (SHARED_MANAGER.signUpPayload.country.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Country Missing"];
        }
        else if (SHARED_MANAGER.signUpPayload.company_url.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Company URL Missing"];
        }
        else if (SHARED_MANAGER.signUpPayload.industry_name.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Industry Name Missing"];
        }
        else
        {
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}
#pragma mark- country Picker
-(void)showCountryPicker{
    
    EMCCountryPickerController *countryPicker = [[EMCCountryPickerController alloc] initWithNibName:@"EMCCountryPickerController" bundle:[NSBundle mainBundle]];
    countryPicker.countryDelegate = self;
    [self.navigationController presentViewController:countryPicker animated:YES completion:Nil];
    
}
#pragma mark CountryPickerDelegate
- (void)countryController:(id)sender didSelectCountry:(EMCCountry *)chosenCountry{
    
    EMCCountryPickerController*vc = (EMCCountryPickerController*)sender;
    
    SHARED_MANAGER.signUpPayload.country = chosenCountry.countryName;
    SHARED_MANAGER.signUpPayload.country_code = 
    [SHARED_MANAGER getIdOfCountry:chosenCountry.countryCode];
   
    [self cellsData];
    
    [self.tableView reloadData];
    
    [vc dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark- Date Picker
- (IBAction)nextBtnDatePicker:(UIButton *)sender
{
    self.transparentLayer.hidden =  YES;
    self.datePickerView.hidden = YES;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * selectedDate = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate: self.datePicker.date]];
    SHARED_MANAGER.signUpPayload.d_o_b = selectedDate;
    
    [self cellsData];
    
    [self.tableView reloadData];
    
    NSLog(@"%@",selectedDate);
}
- (IBAction)cancleDatePicker:(UIButton *)sender {
    self.datePickerView.hidden = YES;
    self.transparentLayer.hidden = YES;
}

#pragma mark- Option popup

- (IBAction)optionOneBtnPressed:(UIButton *)sender {
    
    self.transparentLayer.hidden = YES;
    self.selectionPopup.hidden = YES;
    
    if ([self.popupType  isEqual: @"MemberType"])
    {
        SHARED_MANAGER.signUpPayload.member_type = @"Professional";
        SHARED_MANAGER.signUpPayload.user_role = @3;
    }
    else if ([self.popupType  isEqual: @"TitleType"])
    {
        SHARED_MANAGER.signUpPayload.title = @"Mr";
    }
    else if ([self.popupType  isEqual: @"GenderType"])
    {
        SHARED_MANAGER.signUpPayload.gender = @"Male";
    }
    [self cellsData];
    [self.tableView reloadData];
    
}
- (IBAction)optionTwoBtnPressed:(UIButton *)sender {
  
    self.transparentLayer.hidden = YES;
    self.selectionPopup.hidden = YES;
    
    if ([self.popupType  isEqual: @"MemberType"])
    {
        SHARED_MANAGER.signUpPayload.member_type = @"Student";
        SHARED_MANAGER.signUpPayload.user_role = @2;
    }
    else if ([self.popupType  isEqual: @"TitleType"])
    {
        SHARED_MANAGER.signUpPayload.title = @"Ms";
    }
    else if ([self.popupType  isEqual: @"GenderType"])
    {
        SHARED_MANAGER.signUpPayload.gender = @"Female";
    }
    [self cellsData];
    [self.tableView reloadData];
}
#pragma mark - Private Method 
- (bool)isAgeThirteen {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:SHARED_MANAGER.signUpPayload.d_o_b];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval secondsBetween = [currentDate timeIntervalSinceDate:date];
    int numberOfYear = ((secondsBetween / 86400)/30)/12;
    
    if(numberOfYear >= 13) {
        return YES;
    } else {
        return NO;
    }
}
- (bool)isNumberOnly:(NSString *)number {

    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([number rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        // newString consists only of the digits 0 through 9
        if ([[number substringToIndex:1]isEqualToString:@"0"]){
            return NO;
        } else {
            return YES;
        }
    }
    
    return NO;
}



@end
