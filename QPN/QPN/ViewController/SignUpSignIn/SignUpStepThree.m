//
//  SignUpStepThree.m
//  QPN
//
//  Created by Muhammad Usman on 12/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.
//

#import "SignUpStepThree.h"
#import "TextFieldCell.h"
#import "ButtonCell.h"
#import "MyCustomTF.h"
#import "UIView+Toast.h"
#import "SignUpPayload.h"
#import "SignInSignUpVC.h"
#import "QPNAuthorizationManager.h"
#import "QPNSharedData.h"
#import "AppDelegate.h"
#define AUTH_MAN [QPNAuthorizationManager getSharedInstance]



@interface SignUpStepThree ()<UITableViewDelegate,UITableViewDataSource,ButtonCellDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray* allData;

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


@implementation SignUpStepThree

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.allData = [NSMutableArray array];
//    if (self.asPartner == false)
//    {
//        [self.allData addObject:@{@"placeholder":@"Company Land Line",@"FieldType":[NSNumber numberWithInt:SimpleText],@"PayLoad":SHARED_MANAGER.signUpPayload.company_land_line}];
//    }
    [self.allData addObject:@{@"placeholder":@"Email",@"FieldType":[NSNumber numberWithInt:EmailText],@"PayLoad":SHARED_MANAGER.signUpPayload.email}];
    [self.allData addObject:@{@"placeholder":@"Password (6 char. min)",@"FieldType":[NSNumber numberWithInt:PasswordText],@"PayLoad":SHARED_MANAGER.signUpPayload.password}];
    [self.allData addObject:@{@"placeholder":@"Confirm Password",@"FieldType":[NSNumber numberWithInt:PasswordText],@"PayLoad":SHARED_MANAGER.signUpPayload.confirm_password}];
    
    
    self.varifCodeLayer.hidden = YES;
    [self.charOne addTarget:self action:@selector(codetextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.charTwo addTarget:self action:@selector(codetextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.charThree addTarget:self action:@selector(codetextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.charFour addTarget:self action:@selector(codetextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.charFive addTarget:self action:@selector(codetextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.charSix addTarget:self action:@selector(codetextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
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
        
        static NSString *simpleTableIdentifier = @"textField";
        
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TextFieldCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        NSDictionary * data = [self.allData objectAtIndex:indexPath.row];
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
        cell.btn.hidden = YES;
        cell.textField.placeholder = data[@"placeholder"];
        cell.textField.row = (int)indexPath.row;
        cell.textField.text = data[@"PayLoad"];
        [cell.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllEditingEvents];
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
            [cell.ButtonClick setTitle:@"Sign Up" forState:UIControlStateNormal];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.btnDelegate = self;
        return  cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark- textfiled
-(void)textFieldDidChange:(MyCustomTF *)textField{
    
//    if (!self.asPartner)
//    {
//        switch (textField.row)
//        {
//            case 0:
//                SHARED_MANAGER.signUpPayload.company_land_line = textField.text;
//                break;
//            case 1:
//                SHARED_MANAGER.signUpPayload.email = textField.text;
//                break;
//            case 2:
//                SHARED_MANAGER.signUpPayload.password = textField.text;
//                break;
//            case 3:
//                SHARED_MANAGER.signUpPayload.confirm_password = textField.text;
//                break;
//                
//            default:
//                break;
//        }
//    }
//    else
//    {
        switch (textField.row)
        {
            case 0:
                SHARED_MANAGER.signUpPayload.email = textField.text;
                break;
            case 1:
                SHARED_MANAGER.signUpPayload.password = textField.text;
                break;
            case 2:
                SHARED_MANAGER.signUpPayload.confirm_password = textField.text;
                break;
                
            default:
                break;
        }
//    }
    NSMutableDictionary * dic = [[self.allData objectAtIndex:textField.row] mutableCopy];
    dic[@"PayLoad"] = textField.text;
    [self.allData replaceObjectAtIndex:textField.row withObject:dic];

}
#pragma mark- BtnCell Delegate
-(void) btnClicked:(id) sender cellIndexD:(NSIndexPath*) ind
{
    [self.view endEditing:YES];
    if (!SHARED_MANAGER.hasInet)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Please check your internet connection"];
        return;
    }
    if(SHARED_MANAGER.signUpPayload.email.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Email Missing"];
        return;
    }
    else if(![AUTH_MAN NSStringIsValidEmail: SHARED_MANAGER.signUpPayload.email])
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Email is not valid"];
        return;
    }
    else if(SHARED_MANAGER.signUpPayload.password.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Password Missing"];
        return;
    }
    else if(SHARED_MANAGER.signUpPayload.confirm_password.length == 0)
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Confirm Password Missing"];
        return;
    }
    else if(SHARED_MANAGER.signUpPayload.confirm_password.length > 0 && SHARED_MANAGER.signUpPayload.password.length > 0 && !NSStringIsEqual(SHARED_MANAGER.signUpPayload.confirm_password, SHARED_MANAGER.signUpPayload.password))
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Incorrect Confirm Password"];
        return;
    }
    else
    {
        [SHARED_MANAGER showWorkingSpinner:self.view text:@"SigningUp.."];
    
        NSDictionary *parameters = @{@"user": [SHARED_MANAGER.signUpPayload givePayloadDictionary] };
        [AUTH_MAN registerWithParameters:parameters parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
            [SHARED_MANAGER hideWorkingSpinner:self.view];
            
            if(response) {
                
                AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate.window makeToast:@"A verification code has been sent."];
                double delayInSeconds = 2.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
                    [nc postNotificationName:@"showVarifCodePopUp" object:self userInfo:nil];
                    self.varifCodeLayer.hidden = NO;
                    
//                    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
//                    for (UIViewController *aViewController in allViewControllers) {
//                        if ([aViewController isKindOfClass:[SignInSignUpVC class]]) {
//                            [self.navigationController popToViewController:aViewController animated:NO];
//                        }
//                    }
                });
            }
            else {
                if(error) {
                    NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                    NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                    if(errorDic[@"error"])
                    {
                        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                            [appdelegate.window makeToast:errorDic[@"errors"]];
                    }
                }
            }
        }];
    }
}
//**************************//
//*******Varif Code *******//
//*************************//

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length == 1 && string.length != 0 ) {
        return NO;
    }
    
    return YES;
}


-(void)codetextFieldDidChange:(UITextField *)textField{
    
    
    if (textField.tag == 96)
    {
        if (textField.text.length == 1)
        {
            [self.view endEditing:YES];
            return;
        }
    }
    else
    {
        if (textField.text.length == 1)
        {
            UITextField *tf = (UITextField*)[self.view viewWithTag: textField.tag+1];
            [tf becomeFirstResponder];
            return;
        }
    }
    
    
}
- (IBAction)sendVarifCodePewssed:(UIButton *)sender {
    
    if (self.charOne.text.length != 1 || self.charTwo.text.length != 1 || self.charThree.text.length != 1 || self.charFour.text.length != 1 || self.charFive.text.length != 1 || self.charSix.text.length != 1 )
    {
        AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Code is not complete"];
    }
    else
    {
        if (!SHARED_MANAGER.hasInet)
        {
            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appdelegate.window makeToast:@"Please check your internet connection"];
            return;
        }
        else
        {
            NSString * smsVarifCode = [NSString stringWithFormat:@"%@%@%@%@%@%@",self.charOne.text,self.charTwo.text,self.charThree.text,self.charFour.text,self.charFive.text,self.charSix.text];
            NSLog(@"%@",smsVarifCode);
            
            [SHARED_MANAGER showWorkingSpinner:self.view text:@"Sending Code.."];
            NSDictionary *parameters = @{ @"user": @{ @"code": smsVarifCode } };
            [AUTH_MAN smsCodeApproval:parameters parameterEncoding:JSON completionHanlder:^(id response, NSError *error) {
                [SHARED_MANAGER hideWorkingSpinner:self.view];
                if(response) {
                    NSArray *array = [self.navigationController viewControllers];
                    
                    [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
                    AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                        [appdelegate.window makeToast:@"Your account have been sms approved"];
                } else {
                    if(error) {
                        NSData *data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
                        if (data) {
                            NSDictionary *errorDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                            AppDelegate* appdelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                            [appdelegate.window makeToast:errorDic[@"errors"]];
                        }
                    }
                }
            }];
        }
        
    }
    
}


@end
