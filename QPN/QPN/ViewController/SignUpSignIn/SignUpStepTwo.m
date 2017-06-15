//
//  SignUpStepTwo.m
//  QPN
//
//  Created by Muhammad Usman on 12/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "SignUpStepTwo.h"
#import "TextFieldCell.h"
#import "ButtonCell.h"
#import "MyCustomTF.h"
#import "EMCCountryPickerController.h"
#import "CheckBoxCell.h"
#import "SignUpStepThree.h"
#import "SignUpPayload.h"
#import "QPNSharedData.h"
#import "UIView+Toast.h"
#import "IndustryVC.h"
#import "Industry.h"
#import "AppDelegate.h"


@interface SignUpStepTwo ()<UITableViewDelegate,UITableViewDataSource,ButtonCellDelegate,EMCCountryDelegate,CheckBoxCellDelegate,TextFieldCellDelegate,IndustryVCDelegate>

@property (nonatomic,strong) NSMutableArray* allData;
@property (nonatomic,readwrite) bool isQatarCountrySelected;

@end
typedef enum : NSUInteger {
    SimpleText,
    EmailText,
    NumberText,
    PickerText,
    PasswordText,
    NoneEditable,
    ChechBox,
    None
}TextFieldsType;


@implementation SignUpStepTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isEmployed = false;
    self.isQatarCountrySelected = false;
    [self cellData];
    
    self.transparentLayer.hidden = YES;
    self.optionPopup.hidden = YES;
}
-(void)cellData
{
    self.allData = [NSMutableArray array];
//    if (self.asPartner == false)
//    {
        if (NSStringIsEqual(SHARED_MANAGER.signUpPayload.member_type, @"Professional"))
        {
            [self.allData addObject:@{@"FieldType":[NSNumber numberWithInt:ChechBox]}];
            [self.allData addObject:@{@"placeholder":@"Industry Name",@"FieldType":[NSNumber numberWithInt:PickerText],@"PayLoad":SHARED_MANAGER.signUpPayload.industry_name}];
        }
        else
        {
            [self.allData addObject:@{@"placeholder":@"Institute Name",@"FieldType":[NSNumber numberWithInt:PickerText],@"PayLoad":SHARED_MANAGER.signUpPayload.institute_name}];
        }
        [self.allData addObject:@{@"placeholder":@"Nationality",@"FieldType":[NSNumber numberWithInt:PickerText],@"PayLoad":SHARED_MANAGER.signUpPayload.nationality}];
        [self.allData addObject:@{@"placeholder":@"Country",@"FieldType":[NSNumber numberWithInt:PickerText],@"PayLoad":SHARED_MANAGER.signUpPayload.country}];
        if(SHARED_MANAGER.signUpPayload.country_code.length > 0) {
            [self.allData removeLastObject];
            NSString *countryWithCode = [NSString stringWithFormat:@"(+%@) %@",SHARED_MANAGER.signUpPayload.country_code,SHARED_MANAGER.signUpPayload.country];
            [self.allData addObject:@{@"placeholder":@"Country",@"FieldType":[NSNumber numberWithInt:PickerText],@"PayLoad":countryWithCode}];
        }
        [self.allData addObject:@{@"placeholder":@"City",@"FieldType":[NSNumber numberWithInt:PickerText],@"PayLoad":SHARED_MANAGER.signUpPayload.city}];
        [self.allData addObject:@{@"placeholder":@"Enter Your Mobile Number",@"FieldType":[NSNumber numberWithInt:NumberText],@"PayLoad":SHARED_MANAGER.signUpPayload.mobile_number}];

        if (self.isEmployed)
        {
            [self.allData insertObject:@{@"placeholder":@"Employer Name",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.employer_name} atIndex:1];
            [self.allData insertObject:@{@"placeholder":@"Job Title",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.job_title} atIndex:2];
        }
        if(self.isQatarCountrySelected) {
            [self.allData addObject:@{@"placeholder":@"ID Card Number",@"FieldType":[NSNumber numberWithInt:NumberText],@"PayLoad":SHARED_MANAGER.signUpPayload.qID}];

        }
//    }
//    else
//    {
//        [self.allData addObject:@{@"placeholder":@"Title",@"FieldType":[NSNumber numberWithInt:PickerText],@"PayLoad":SHARED_MANAGER.signUpPayload.title}];
//        [self.allData addObject:@{@"placeholder":@"Name",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.first_name}];
//        [self.allData addObject:@{@"placeholder":@"Conact Number",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.mobile_number}];
//    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBtnPressed:(UIButton *)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma -mark Private Method
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
        
        if ([data[@"FieldType"] intValue] == ChechBox && NSStringIsEqual(SHARED_MANAGER.signUpPayload.member_type, @"Professional"))
        {
            static NSString *simpleTableIdentifier = @"CheckBoxCell";
            
            CheckBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CheckBoxCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.checkBoxDelegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else
        {
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
            cell.TFCellDelegate = self;
            cell.textField.placeholder = data[@"placeholder"];
            cell.textField.row = (int)indexPath.row;
            cell.textField.text = data[@"PayLoad"];
            [cell.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllEditingEvents];
            if (NSStringIsEqual(SHARED_MANAGER.signUpPayload.member_type, @"Professional"))
            {
                cell.btn.hidden = NO;
                if(!self.isEmployed)
                {
                    if (indexPath.row == 4 || (self.isQatarCountrySelected && indexPath.row == 5)) {
                        cell.btn.hidden = YES;
                    }
                }
                else
                {
                    cell.btn.hidden = YES;
                    if (indexPath.row == 3||  indexPath.row == 4 || indexPath.row == 5) {
                        cell.btn.hidden = NO;
                    }
                }
            }
            else
            {
                cell.btn.hidden = YES;
                if (indexPath.row == 1 || indexPath.row == 2) {
                    cell.btn.hidden = NO;
                }
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    else
    {
        static NSString *simpleTableIdentifier = @"ButtonCell";
        
        ButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ButtonCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            [cell.ButtonClick setTitle:@"Next" forState:UIControlStateNormal];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.btnDelegate = self;
        return  cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- textfiled
-(void)textFieldDidChange:(MyCustomTF *)textField{
//   if(!self.asPartner)
   {
        if(!self.isEmployed)
        {
            if (NSStringIsEqual(SHARED_MANAGER.signUpPayload.member_type, @"Professional")) {
                switch (textField.row)
                {
                    case 1:
                        SHARED_MANAGER.signUpPayload.institute_name = textField.text;
                        break;
                    case 4:
                        SHARED_MANAGER.signUpPayload.city = textField.text;
                        break;
                    case 5:
                        SHARED_MANAGER.signUpPayload.qID = textField.text;
                        break;
                    default:
                        break;
                }
            } else {
                switch (textField.row)
                {
                    case 0:
                        SHARED_MANAGER.signUpPayload.institute_name = textField.text;
                        break;
                    case 3:
                        SHARED_MANAGER.signUpPayload.city = textField.text;
                        break;
                    case 4:
                        SHARED_MANAGER.signUpPayload.mobile_number = textField.text;
                        break;
                    case 5:
                        SHARED_MANAGER.signUpPayload.qID = textField.text;
                        break;
                    default:
                        break;
                }
            }
        }
        else
        {
            switch (textField.row)
            {
                case 1:
                    SHARED_MANAGER.signUpPayload.employer_name = textField.text;
                    break;
                    
                case 2:
                    SHARED_MANAGER.signUpPayload.job_title = textField.text;
                    break;
                case 3:
                    SHARED_MANAGER.signUpPayload.industry_name = textField.text;
                    break;
                    
                case 6:
                    SHARED_MANAGER.signUpPayload.city = textField.text;
                    break;
                case 7:
                    SHARED_MANAGER.signUpPayload.mobile_number = textField.text;
                    break;
                case 8:
                    SHARED_MANAGER.signUpPayload.qID = textField.text;
                    break;
                    
                default:
                    break;
            }
        }
   }
//    else
//    {
//        switch (textField.row)
//        {
//            case 1:
//                SHARED_MANAGER.signUpPayload.first_name = textField.text;
//                break;
//                
//            case 2:
//                SHARED_MANAGER.signUpPayload.mobile_number = textField.text;
//                break;
//                
//            default:
//                break;
//        }
//    }
    NSMutableDictionary * dic = [[self.allData objectAtIndex:textField.row] mutableCopy];
    dic[@"PayLoad"] = textField.text;
    [self.allData replaceObjectAtIndex:textField.row withObject:dic];

}

-(void) optionPicker:(id) sender cellIndexD:(int) ind
{
    [self.view endEditing:YES];
//    if (!self.asPartner)
    if (NSStringIsEqual(SHARED_MANAGER.signUpPayload.member_type, @"Professional")){
        if(!self.isEmployed)
        {
            switch (ind)
            {
               case 1:
                {
                    IndustryVC * vc;
                    vc = [[IndustryVC alloc] initWithNibName:@"IndustryVC" bundle:[NSBundle mainBundle]];
                    vc.delegate = self;
                    self.navigationController.navigationBar.hidden = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                break;
                case 2:
                    self.countryPicker = 1;
                    [self showCountryPicker];
                    break;
                case 3:
                    self.countryPicker = 2;
                    [self showCountryPicker];
                    break;
                default:
                    break;
            }
        }
        else
        {
            switch (ind)
            {
                case 3:
                {
                    IndustryVC * vc;
                    vc = [[IndustryVC alloc] initWithNibName:@"IndustryVC" bundle:[NSBundle mainBundle]];
                    vc.delegate = self;
                    self.navigationController.navigationBar.hidden = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 4:
                    self.countryPicker = 1;
                    [self showCountryPicker];
                    break;
                case 5:
                    self.countryPicker = 2;
                    [self showCountryPicker];
                    break;
                default:
                    break;
            }

        }
    }
    else
    {
        switch (ind)
        {
            case 1:
                self.countryPicker = 1;
                [self showCountryPicker];
                break;
            case 2:
                self.countryPicker = 2;
                [self showCountryPicker];
                break;
            default:
                break;
        }

    }
}

#pragma mark- BtnCell Delegate
-(void) btnClicked:(id) sender cellIndexD:(NSIndexPath*) ind
{
    SignUpStepThree * vc;
    vc = [[SignUpStepThree alloc] initWithNibName:@"SignUpStepThree" bundle:[NSBundle mainBundle]];
    vc.asPartner = self.asPartner;
    self.navigationController.navigationBar.hidden = YES;

    {
        if (SHARED_MANAGER.signUpPayload.employer_name.length == 0 && SHARED_MANAGER.signUpPayload.job_title.length == 0 && SHARED_MANAGER.signUpPayload.industry_name.length == 0 && SHARED_MANAGER.signUpPayload.nationality.length == 0 && SHARED_MANAGER.signUpPayload.company_url.length == 0  && SHARED_MANAGER.signUpPayload.city.length == 0)
        {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Can't go next with Empty Fields"];
            return;
        }
        if (self.isEmployed) {
            if (SHARED_MANAGER.signUpPayload.employer_name.length == 0)
            {
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.window makeToast:@"Employer Name Missing"];
                return;
            }
            else if ( SHARED_MANAGER.signUpPayload.job_title.length == 0)
            {
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.window makeToast:@"Job Title Missing"];
                return;
            }
        }
        
        else if ( SHARED_MANAGER.signUpPayload.nationality.length == 0)
        {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Nationality Missing"];
            return;
        }
        if (SHARED_MANAGER.signUpPayload.country.length == 0)
        {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Country Name Missing"];
            return;
        }
        else if ( SHARED_MANAGER.signUpPayload.city.length == 0)
        {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"City Name Missing"];
            return;
        }
        else if (self.isQatarCountrySelected  && SHARED_MANAGER.signUpPayload.qID.length == 0)
        {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Id Card Number is Missing"];
            return;
        }
        else if (SHARED_MANAGER.signUpPayload.mobile_number.length < 8) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Number should be atleast 8 digits long and do not start with 0"];
            return;
        }
        else if (![self isNumberOnly:SHARED_MANAGER.signUpPayload.mobile_number]) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Invalid Number."];
        }
        else if (SHARED_MANAGER.signUpPayload.mobile_number.length == 0) {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [appdelegate.window makeToast:@"Mobile Number Missing"];
            return;
        }
        else if (NSStringIsEqual(SHARED_MANAGER.signUpPayload.member_type, @"Professional"))
        {
            if (SHARED_MANAGER.signUpPayload.industry_name.length == 0)
            {
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.window makeToast:@"Industry Name Missing"];
                return;
            }
        }
        else if (NSStringIsEqual(SHARED_MANAGER.signUpPayload.member_type, @"Student"))
        {
            if (SHARED_MANAGER.signUpPayload.institute_name.length == 0)
            {
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [appdelegate.window makeToast:@"Institute Name Missing"];
                return;
            }
        }
        
        [self.navigationController pushViewController:vc animated:YES];
   
    }
    /*else
    {
        if (SHARED_MANAGER.signUpPayload.title.length == 0 && SHARED_MANAGER.signUpPayload.first_name.length == 0 && SHARED_MANAGER.signUpPayload.mobile_number.length == 0)
        {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Can't go next with Empty Fields"];
        }
        else if (SHARED_MANAGER.signUpPayload.title.length == 0)
        {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Title Missing"];
        }
        else if (SHARED_MANAGER.signUpPayload.first_name.length == 0)
        {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Name Missing"];
        }
        else if (SHARED_MANAGER.signUpPayload.mobile_number.length == 0)
        {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Contact Number Missing"];
        }
        else
        {
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    */
}
-(void) employedBtnClicked:(id) sender isEmployed:(bool)employed
{
//    if (employed)
//    {
//        [self.allData insertObject:@{@"placeholder":@"Employer Name",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.employer_name} atIndex:1];
//        [self.allData insertObject:@{@"placeholder":@"Job Title",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.job_title} atIndex:2];
        
        self.isEmployed = employed;
//    }
//    else
//    {
//        [self.allData removeObjectAtIndex:1];
//        [self.allData removeObjectAtIndex:1];
//        self.isEmployed = employed;
//    }
    [self cellData];
    [self.tableView reloadData];
}

-(void)showCountryPicker{
    
    EMCCountryPickerController *countryPicker = [[EMCCountryPickerController alloc] initWithNibName:@"EMCCountryPickerController" bundle:[NSBundle mainBundle]];
    countryPicker.countryDelegate = self;
    [self.navigationController presentViewController:countryPicker animated:YES completion:Nil];
    
}
#pragma mark CountryPickerDelegate
- (void)countryController:(id)sender didSelectCountry:(EMCCountry *)chosenCountry{
    
    EMCCountryPickerController*vc = (EMCCountryPickerController*)sender;
    if (self.countryPicker == 1)
    {
        SHARED_MANAGER.signUpPayload.nationality = chosenCountry.countryName;
        SHARED_MANAGER.signUpPayload.nationality_code =
        [SHARED_MANAGER getIdOfCountry:chosenCountry.countryCode];
        
        if([SHARED_MANAGER.signUpPayload.nationality_code isEqualToString:@"188"]||[SHARED_MANAGER.signUpPayload.country_id isEqualToString:@"188"]){
            self.isQatarCountrySelected = YES;
        }else{
            self.isQatarCountrySelected = NO;
        }
    }
    else if (self.countryPicker == 2)
    {
        SHARED_MANAGER.signUpPayload.country = chosenCountry.countryName;
        SHARED_MANAGER.signUpPayload.country_id =
        [SHARED_MANAGER getIdOfCountry:chosenCountry.countryCode];
        [AUTH_MAN getCountryDialCode:SHARED_MANAGER.signUpPayload.country_id parameterEncoding:URL completionHanlder:^(id response, NSError *error) {
            
            if(response[@"country_code"]) {
                SHARED_MANAGER.signUpPayload.country_code = response[@"country_code"][@"code"];
                [self cellData];
                [self.tableView reloadData];
            }
        }];
        
        if([SHARED_MANAGER.signUpPayload.nationality_code isEqualToString:@"188"]||[SHARED_MANAGER.signUpPayload.country_id isEqualToString:@"188"]){
            self.isQatarCountrySelected = YES;
        }else{
            self.isQatarCountrySelected = NO;
        }
        

    }
    
    [self cellData];
    [self.tableView reloadData];
    
    [vc dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark - Option popup
- (IBAction)optionOneBtnPressed:(UIButton *)sender {
    
    self.transparentLayer.hidden = YES;
    self.optionPopup.hidden =  YES;
    
    SHARED_MANAGER.signUpPayload.title = @"Mr",
    [self cellData];
    [self.tableView reloadData];
    
}
- (IBAction)optionTwoBtnPressed:(UIButton *)sender {
    
    self.transparentLayer.hidden = YES;
    self.transparentLayer.hidden = YES;
    SHARED_MANAGER.signUpPayload.title = @"Ms",
    [self cellData];
    [self.tableView reloadData];
}

#pragma industry Delegate

- (void)selectedIndustry:(Industry *)industry
{
    SHARED_MANAGER.signUpPayload.industry_name = industry.industryName;

    [self cellData];
    [self.tableView reloadData];
}



@end
