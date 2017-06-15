//
//  QPNSharedData.m
//  QPN
//
//  Created by Muhammad Usman on 01/04/2017.
//  Copyright © 2017 Muhammad Usman. All rights reserved.

//

#import "QPNSharedData.h"
#import "GTConstants.h"
#import "GTColorConstants.h"
#import "QPNAuthorizationManager.h"
#import "THCircularProgressView.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
@interface QPNSharedData ()

@property (nonatomic,assign) id<CutsomAlertDelegate> alertDelegate;
@property (nonatomic,strong) UIView *  customAlert;
@property (nonatomic,strong) THCircularProgressView * progressCircle;
@property (nonatomic, strong) NSTimer * uploadProgressTimer;
@end
@implementation QPNSharedData

static QPNSharedData * staticSharedDataInstance = NULL;

+(QPNSharedData * ) getSharedInstance
{
    
    if(staticSharedDataInstance == NULL)
    {
        staticSharedDataInstance = [[QPNSharedData alloc] init];
    }
    return staticSharedDataInstance;
}

+(void) releaseSharedInstance
{
    if(staticSharedDataInstance)
    {
        staticSharedDataInstance = NULL;
    }
}
-(id)init
{
    self = [super init];
    if(self)
    {
        self.signUpPayload = [[SignUpPayload alloc] init];
        self.qpnUser = [[QPNUser alloc] init];
        self.QPNPostArray = [NSMutableArray array];
        self.wyDropDownArray = [NSMutableArray array];
    }
    
    return self;
    
}
#pragma mark BarButton
- (UIBarButtonItem*) barButtonWithTitle:(NSString*) titleText target:(id)target selector:(SEL) selector
{
    UIBarButtonItem * Button = [[UIBarButtonItem alloc] initWithTitle:titleText style:UIBarButtonItemStylePlain target:target action:selector];
    
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, APP_FONT(16.0), NSFontAttributeName, nil];
    [Button setTitleTextAttributes:textTitleOptions forState:UIControlStateNormal];
    
    NSDictionary *textTitleOptions2 = [NSDictionary dictionaryWithObjectsAndKeys: [UIColor lightGrayColor], NSForegroundColorAttributeName, APP_FONT(16.0), NSFontAttributeName, nil];
    [Button setTitleTextAttributes:textTitleOptions2 forState:UIControlStateDisabled];
    
    return Button;
}
-(UIBarButtonItem*) barButtonWithImage:(NSString*) imageName target:(id)target selector:(SEL) selector
{
    UIBarButtonItem * Button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:target action:selector];
    
//    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, APP_FONT(16.0), NSFontAttributeName, nil];
//    [Button setTitleTextAttributes:textTitleOptions forState:UIControlStateNormal];
    
    return Button;
}
-(void) showUploadProgressAlert:(NSString*) title  delegate:(id<CutsomAlertDelegate>)delegate
{
    [self showAlertView:title description:nil positiveBtn:nil negativeBtn:nil delegate:delegate alertViewTag:-2];
}
-(void) uploadProgressUpdate
{
    if (self.alertDelegate && [self.alertDelegate respondsToSelector:@selector(updateUploadProgress)])
    {
        float progress = [self.alertDelegate updateUploadProgress];
        if (self.progressCircle)
        {
            self.progressCircle.percentage = progress;
        }
    }
}
-(void) showAlertView:(NSString*) title description:(NSString*) description positiveBtn:(NSString*) positiveBtn negativeBtn:(NSString*) negativeBtn delegate:(id<CutsomAlertDelegate>) delegate  alertViewTag:(int) tag
{

    if (self.customAlert)
    {
        if (self.uploadProgressTimer)
        {
            [self.uploadProgressTimer invalidate];
            self.uploadProgressTimer = nil;
        }
        [self.customAlert removeFromSuperview];
        self.progressCircle = nil;
        self.customAlert = nil;
    }
    if (delegate)
    {
        self.alertDelegate = delegate;
    }else{
        self.alertDelegate = nil;
    }
    CGRect baseFrame = [UIScreen mainScreen].bounds;
    UIView * baseContainer = [[UIView alloc] initWithFrame:baseFrame];
    baseContainer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    CGRect boxFrame = CGRectMake(50.0, 100.0, baseFrame.size.width-100.0, 380.0);
    UIView * box = [[UIView alloc] initWithFrame:boxFrame];
    box.backgroundColor = [UIColor clearColor];//[UIColor whiteColor];
    [baseContainer addSubview:box];
    
    UIView * blueHeader = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, boxFrame.size.width, 44.0)];
    blueHeader.backgroundColor = [UIColor clearColor];//COLOR_WITH_RGB(115, 117, 118);
    [box addSubview:blueHeader];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:blueHeader.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(5.0, 5.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = blueHeader.bounds;
    maskLayer.path  = maskPath.CGPath;
    blueHeader.layer.mask = maskLayer;
    
    UIView * progressView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
    progressView.backgroundColor = [UIColor clearColor];//COLOR_WITH_RGB(43, 7, 19);//COLOR_PURPLE;
    progressView.center = CGPointMake(blueHeader.center.x, blueHeader.frame.size.height-8.0);
    [box addSubview:progressView];
    progressView.layer.cornerRadius = CGRectGetWidth(progressView.frame)*0.5;
    
    if (tag == -1)
    {
        UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        spinner.center = CGPointMake(progressView.frame.size.width*0.5, progressView.frame.size.height*0.5);
        spinner.color = [UIColor whiteColor];//COLOR_WITH_RGB(115, 117, 118);//COLOR_WITH_RGB(132, 0, 42);
        [progressView addSubview:spinner];
        [spinner startAnimating];
    }
    else if (tag == -2)
    {
        THCircularProgressView * progressCircle = [[THCircularProgressView alloc] initWithCenter:CGPointMake(25.0, 25.0) radius:25.0 lineWidth:25.0 progressMode:THProgressModeFill progressColor:COLOR_RED progressBackgroundMode:THProgressBackgroundModeCircle progressBackgroundColor:[COLOR_WITH_RGB(255, 255, 255) colorWithAlphaComponent:0.6] percentage:0.0];
        [progressView addSubview:progressCircle];
        self.progressCircle = progressCircle;
        self.uploadProgressTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(uploadProgressUpdate) userInfo:nil repeats:YES];
    }
    else if (tag == -3)
    {
        UIImageView * status = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
        status.image = [UIImage imageNamed:@"verification-mark"];
        [progressView addSubview:status];
    }
    else
    {
        UIImageView * status = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
        status.image = [UIImage imageNamed:@"attention"];
        [progressView addSubview:status];

    }
    
    CGRect titleRect = CGRectMake(5.0,progressView.center.y + progressView.frame.size.height*0.7, boxFrame.size.width-10.0, 100.0);
    UITextView * titleLabel = [[UITextView alloc] initWithFrame:titleRect];
    titleLabel.font = APP_FONT(15.0);
    titleLabel.text = title;
    titleLabel.textColor = [UIColor clearColor];//COLOR_WITH_RGB(43, 7, 19);//COLOR_WITH_RGB(132, 0, 42);
    titleLabel.textContainerInset = UIEdgeInsetsZero;
    titleLabel.textContainer.lineFragmentPadding = 0.0;
    titleLabel.textContainer.maximumNumberOfLines = 5;
    titleLabel.scrollEnabled = NO;
    titleLabel.editable = NO;
    titleLabel.selectable = NO;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel sizeToFit];
    titleRect = titleLabel.frame;
    titleRect.size.width = boxFrame.size.width-10.0;
    titleLabel.frame = titleRect;
    [box addSubview:titleLabel];
    
    CGRect messageLabelRect = titleRect;
    if (description)
    {
        messageLabelRect = CGRectMake(5.0, titleRect.origin.y+titleRect.size.height + 10.0,boxFrame.size.width-10.0, 100.0);
        
        UITextView * messageLabel = [[UITextView alloc] initWithFrame:messageLabelRect];
        messageLabel.font = APP_FONT(14.0);
        messageLabel.text = description;
        messageLabel.textColor = COLOR_GREY;
        messageLabel.textContainerInset = UIEdgeInsetsZero;
        messageLabel.textContainer.lineFragmentPadding = 0.0;
        messageLabel.textContainer.maximumNumberOfLines = 10;
        messageLabel.scrollEnabled = NO;
        messageLabel.editable = NO;
        messageLabel.selectable = NO;
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        messageLabelRect = messageLabel.frame;
        messageLabelRect.size.width = boxFrame.size.width-10.0;
        messageLabel.frame = messageLabelRect;
        [box addSubview:messageLabel];
    }
    
    float buttonOffset = 20.0;
    float buttonWidth = (boxFrame.size.width- buttonOffset*3.0)*0.5;
    float buttonHeight = buttonWidth * 0.33;
    
    if (!negativeBtn && !positiveBtn)
    {
        boxFrame.size.height = messageLabelRect.origin.y+messageLabelRect.size.height+10.0;
    }
    else
    {
        boxFrame.size.height = messageLabelRect.origin.y+messageLabelRect.size.height+10.0+buttonHeight;
    }
    UIView * cancelView;
    if (negativeBtn)
    {
        cancelView = [[UIView alloc] initWithFrame:CGRectMake(boxFrame.origin.x+buttonOffset, boxFrame.origin.y+boxFrame.size.height-buttonHeight*0.5, buttonWidth, buttonHeight)];
        UIButton* cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0.0, 0.0, buttonWidth, buttonHeight);
        UIView * btnBGCancel = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, buttonWidth, buttonHeight)];
        btnBGCancel.backgroundColor = COLOR_RED;
        btnBGCancel.layer.cornerRadius = 5.0;
        btnBGCancel.clipsToBounds = YES;
        [cancelView addSubview:btnBGCancel];
        [cancelButton setTitle:negativeBtn forState:UIControlStateNormal];
        cancelButton.layer.cornerRadius = 5.0;
        cancelButton.titleLabel.font = APP_FONT(16.0);
        [cancelView addSubview:cancelButton];
        cancelButton.contentEdgeInsets = UIEdgeInsetsMake(2.0, 0.0, 0.0, 0.0);
        cancelView.layer.shadowOpacity = 0.25;
        cancelView.layer.shadowRadius = 6.0;
        cancelView.layer.shadowColor = [UIColor blackColor].CGColor;
        cancelView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        [cancelButton addTarget:self action:@selector(alertNegativeClicked) forControlEvents:UIControlEventTouchUpInside];
        [baseContainer addSubview:cancelView];
    }
    
    UIView * doneView;
    if (positiveBtn)
    {
        doneView = [[UIView alloc] initWithFrame:CGRectMake(box.frame.origin.x+box.frame.size.width-buttonOffset-buttonWidth, boxFrame.origin.y+boxFrame.size.height-buttonHeight*0.5, buttonWidth, buttonHeight)];
        UIButton * doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame = CGRectMake(0.0, 0.0, buttonWidth, buttonHeight);
        UIView * btnBG = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, buttonWidth, buttonHeight)];
        btnBG.backgroundColor = COLOR_GREEN;
        btnBG.layer.cornerRadius = 5.0;
        btnBG.clipsToBounds = YES;
        [doneView addSubview:btnBG];
        [doneButton sendSubviewToBack:btnBG];
        [doneButton setTitle:positiveBtn forState:UIControlStateNormal];
        doneButton.titleLabel.font = APP_FONT(16.0);
        [doneView addSubview:doneButton];
        doneButton.contentEdgeInsets = UIEdgeInsetsMake(2.0, 0.0, 0.0, 0.0);
        doneView.layer.shadowOpacity = 0.25;
        doneView.layer.shadowRadius = 6.0;
        doneView.layer.shadowColor = [UIColor blackColor].CGColor;
        doneView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
        doneButton.tag = tag;
        [doneButton addTarget:self action:@selector(alertPositiveClicked:) forControlEvents:UIControlEventTouchUpInside];
        [baseContainer addSubview:doneView];
    }
    
    box.layer.shadowOpacity = 0.25;
    box.backgroundColor = [UIColor clearColor];
    box.layer.shadowRadius = 6.0;
    box.layer.shadowColor = [UIColor blackColor].CGColor;
    box.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    box.layer.cornerRadius = 5.0;
    box.frame = boxFrame;
    
    box.center = CGPointMake(baseFrame.size.width*0.5, baseFrame.size.height*0.5);
    
    if (doneView)
    {
        if (!cancelView)
        {
            doneView.center = CGPointMake(box.center.x, box.frame.origin.y+box.frame.size.height);
        }
        else
        {
            doneView.center = CGPointMake(doneView.center.x, box.frame.origin.y+box.frame.size.height);
        }
    }
    
    if (cancelView)
    {
        if (!doneView)
        {
            cancelView.center = CGPointMake(box.center.x, box.frame.origin.y+box.frame.size.height);
        }
        else
        {
            cancelView.center = CGPointMake(cancelView.center.x, box.frame.origin.y+box.frame.size.height);
        }
    }
    
    self.customAlert = baseContainer;
    AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.customAlert.tag = tag;
    [appDelegate.window addSubview:baseContainer];
}
-(void) alertPositiveClicked:(id)sender
{
    if (self.alertDelegate && [self.alertDelegate respondsToSelector:@selector(alertPositiveButtonClicked:)]) {
        [self.alertDelegate alertPositiveButtonClicked:sender];
    }
    if (self.customAlert)
    {
        [self.customAlert removeFromSuperview];
        self.customAlert = nil;
    }
}
-(void) alertNegativeClicked
{
    if (self.alertDelegate && [self.alertDelegate respondsToSelector:@selector(alertNegativeButtonClicked:)]) {
        [self.alertDelegate alertNegativeButtonClicked:nil];
    }
    if (self.customAlert)
    {
        [self.customAlert removeFromSuperview];
        self.customAlert = nil;
    }
}
-(void) showWorkingSpinner:(UIView*) view text:(NSString*) text;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self showAlertView:text description:nil positiveBtn:nil negativeBtn:nil delegate:nil alertViewTag:-1];
        
    });
    
}
-(void) hideWorkingSpinner:(UIView*) view
{
    if(self.customAlert.tag  == -3){
        return;
    }
    
//    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.uploadProgressTimer)
        {
            [self.uploadProgressTimer invalidate];
            self.uploadProgressTimer = nil;
        }
        if (self.customAlert)
        {
            [self.customAlert removeFromSuperview];
            self.customAlert = nil;
        }

}
-(void) hideWorkingSpinner:(UIView*) view after:(float) seconds
{
//    dispatch_async(dispatch_get_main_queue(), ^{
    if (self.uploadProgressTimer)
    {
        [self.uploadProgressTimer invalidate];
        self.uploadProgressTimer = nil;
    }
        if (self.customAlert)
        {
            [self.customAlert removeFromSuperview];
            self.customAlert = nil;
        }
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
-(BOOL) CheckPasswordIsValid:(NSString *)checkString
{
    // Not Used 
    
    NSString *stricterFilterString = @"^(?=.*\\d)(?=.*[a-z])[0-9a-zA-Z]{8,16}$";
    NSString *emailRegex = stricterFilterString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark SharedEntities
-(void)UpdateReport{

}
-(NSString*) convert24hTo12h:(NSString*)time{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSDate * timeNotFormatted = [dateFormatter dateFromString:time];
    [dateFormatter setDateFormat: @"hh:mm a"];
    NSString * timeFormatted = [dateFormatter stringFromDate:timeNotFormatted];
    return timeFormatted;
    
}
-(NSString*) convert12To24h:(NSString*)time{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSDate * timeNotFormatted = [dateFormatter dateFromString:time];
    [dateFormatter setDateFormat: @"HH:mm"];
    NSString * timeFormatted = [dateFormatter stringFromDate:timeNotFormatted];
    return timeFormatted;
    
}
#pragma -mark conver to comma seprated String
-(NSString*)commaSepratedString:(NSMutableArray*)array
{
    NSString* commasepratedString;
    for (NSString* tempStr in array)
    {
        if (commasepratedString.length ==0)
        {
            commasepratedString = [NSString stringWithFormat:@"%@", tempStr];
        }
        else
        {
            commasepratedString = [NSString stringWithFormat:@"%@,%@",commasepratedString,tempStr];
        }
    }
    return commasepratedString;

}
#pragma -mark  textView Height Calculater
//- (CGFloat)textViewHeightForAttributedText: (NSString*)text andWidth: (CGFloat)width heightWithoutText:(float)h {
//    
//    UITextView *calculationView = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, 0.0)];
//    
//    [calculationView setTextContainerInset:UIEdgeInsetsZero];
//    calculationView.textContainer.lineFragmentPadding = 0.0;
//    calculationView.textAlignment = NSTextAlignmentLeft;
//    calculationView.font = [UIFont systemFontOfSize:16];
//    calculationView.text = text;
//    [calculationView sizeToFit];
//    
//    if (text.length>0)
//    {
//        return calculationView.frame.size.height + h;
//    }
//    else
//    {
//        return h;
//    }
//
//}
- (CGFloat)postTextViewHeightForAttributedText:(NSString*)text andWidth:(CGFloat)width heightWithoutText:(float)h {
    
    UITextView *calculationView = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, 0.0)];
    calculationView.font = [UIFont systemFontOfSize:13];
    calculationView.text = text;
    [calculationView sizeToFit];
    if(text.length > 0) {
        h = h + calculationView.frame.size.height;
        if (h > (50))
        {
            h = (50);
        }
        
        return h;
    }
    else {
        return h;
    }
}


-(NSString*) urlBy:(NSString*)lat and:(NSString*)lng
{
    return [NSString stringWithFormat:@"http://www.google.com/maps/place/%@,%@",lat,lng];
}
-(NSMutableArray*)dataBreaker: (NSString*)date
{
    NSString * character = @"-";
    if ([date rangeOfString:@"-"].location == NSNotFound){
        character = @"/";
       }
    NSMutableArray* foo = (NSMutableArray*)[date componentsSeparatedByString: character];
    if(foo.count>1){
    
    if (NSStringIsEqual(foo[1],@"01"))
    {
        [foo replaceObjectAtIndex:1 withObject:@"JAN"];
    }
    if (NSStringIsEqual(foo[1],@"02"))
    {
        [foo replaceObjectAtIndex:1 withObject:@"FEB"];
    }
    if (NSStringIsEqual(foo[1],@"03"))
    {
        [foo replaceObjectAtIndex:1 withObject:@"MAR"];
    }
    if (NSStringIsEqual(foo[1],@"04"))
    {
        [foo replaceObjectAtIndex:1 withObject:@"APR"];
    }
    if (NSStringIsEqual(foo[1],@"05"))
    {
        [foo replaceObjectAtIndex:1 withObject:@"MAY"];
    }
    if (NSStringIsEqual(foo[1],@"06"))
    {
        [foo replaceObjectAtIndex:1 withObject:@"JUN"];
    }
    if (NSStringIsEqual(foo[1],@"07"))
    {
        [foo replaceObjectAtIndex:1 withObject:@"JUL"];
    }
    if (NSStringIsEqual(foo[1],@"08"))
    {
        [foo replaceObjectAtIndex:1 withObject:@"AUG"];
    }
    if (NSStringIsEqual(foo[1],@"09"))
    {
        [foo replaceObjectAtIndex:1 withObject:@"SEP"];
    }
    if (NSStringIsEqual(foo[1],@"10"))
    {
        [foo replaceObjectAtIndex:1 withObject:@"OCT"];
    }
    if (NSStringIsEqual(foo[1],@"11"))
    {
        [foo replaceObjectAtIndex:1 withObject:@"NOV"];
    }
    if (NSStringIsEqual(foo[1],@"12"))
    {
        [foo replaceObjectAtIndex:1 withObject:@"DEC"];
    }
        return foo;
    }
    return [NSMutableArray array];
}

- (NSString*) dayBuNumber:(int) dayNum {
    switch (dayNum) {
        case 1:
            return @"MON";
            break;
        case 2:
            return @"TUS";
            break;
        case 3:
            return @"WED";
            break;
        case 4:
            return @"THUS";
                break;
        case 5:
            return @"FRI";
            break;
        case 6:
            return @"SAT";
            break;
        case 7:
            return @"SUN";
            break;


            
        default:
            break;
    }
    return @"";
}

#pragma mark VideoConversion
- (void)exportVideo:(NSURL*)videoPath completionHanlder:(RequestCompletionHandler) handler {
    
    AVURLAsset*avAsset = [[AVURLAsset alloc] initWithURL:videoPath options:nil];
    NSArray*compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if([compatiblePresets containsObject:AVAssetExportPresetHighestQuality])
    {
        AVAssetExportSession*exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString*videoPath1 = [NSString stringWithFormat:@"%@%@",documentsDirectory,@"/xyz.mp4"];
        
        if(  [[NSFileManager defaultManager] fileExistsAtPath:videoPath1]){
            
            [[NSFileManager defaultManager] removeItemAtPath:videoPath1 error:nil];
        }
        
        exportSession.outputURL =  [NSURL fileURLWithPath:videoPath1];
        
        NSLog(@"videopath of your mp4 file = %@",videoPath1);
        
        exportSession.outputFileType = @"public.mpeg-4";
        
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            
            switch ([exportSession status]) {
                    
                case AVAssetExportSessionStatusFailed:
                    NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                    
                    break;
                    
                case AVAssetExportSessionStatusCancelled:
                    
                    NSLog(@"Export canceled");
                    
                    break;
                case AVAssetExportSessionStatusCompleted:{
                    NSURL *postVideoURL;
                    postVideoURL = exportSession.outputURL;

                    handler(exportSession.outputURL,nil);
                }
                    break;
                    
                default:
                    
                    break;
                    
            }
            
        }];
    }
}
- (UIImage*)getVideoThumbnail:(NSURL*)filePath {
    AVURLAsset*asset = [[AVURLAsset alloc] initWithURL:filePath options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 1.0);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    return thumb;
}
- (NSString*)urlencode:(NSString*)str {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[str UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}
- (NSString*)getIdOfCountry:(NSString *)code {
    
    NSDictionary *codeIdDic = @{@"AD":@"1",@"AE":@"2",
                                @"AF":@"3",@"AG":@"4",
                                @"AI":@"5",
                                @"AL":@"6",
                                @"AM":@"7",
                                @"AN":@"251",
                                @"AO":@"8",
                                @"AQ":@"9",
                                @"AR":@"10",
                                @"AS":@"11",
                                @"AT":@"12",
                                @"AU":@"13",
                                @"AW":@"14",
                                @"AX":@"15",
                                @"AZ":@"16",
                                @"BA":@"17",
                                @"BB":@"18",
                                @"BD":@"19",
                                @"BE":@"20",
                                @"BF":@"21",
                                @"BG":@"22",
                                @"BH":@"23",
                                @"BI":@"24",
                                @"BJ":@"25",
                                @"BL":@"26",
                                @"BM":@"27",
                                @"BN":@"28",
                                @"BO":@"29",
                                @"BQ":@"30",
                                @"BR":@"31",
                                @"BS":@"32",
                                @"BT":@"33",
                                @"BV":@"34",
                                @"BW":@"35",
                                @"BY":@"36",
                                @"BZ":@"37",
                                @"CA":@"38",
                                @"CC":@"39",
                                @"CD":@"40",
                                @"CF":@"41",
                                @"CG":@"42",
                                @"CH":@"43",
                                @"CI":@"44",
                                @"CK":@"45",
                                @"CL":@"46",
                                @"CM":@"47",
                                @"CN":@"48",
                                @"CO":@"49",
                                @"CR":@"50",
                                @"CS":@"250",
                                @"CU":@"51",
                                @"CV":@"52",
                                @"CW":@"53",
                                @"CX":@"54",
                                @"CY":@"55",
                                @"CZ":@"56",
                                @"DE":@"57",
                                @"DJ":@"58",
                                @"DK":@"59",
                                @"DM":@"60",
                                @"DO":@"61",
                                @"DZ":@"62",
                                @"EC":@"63",
                                @"EE":@"64",
                                @"EG":@"65",
                                @"EH":@"66",
                                @"ER":@"67",
                                @"ES":@"68",
                                @"ET":@"69",
                                @"FI":@"70",
                                @"FJ":@"71",
                                @"FK":@"72",
                                @"FM":@"73",
                                @"FO":@"74",
                                @"FR":@"75",
                                @"GA":@"76",
                                @"GB":@"77",
                                @"GD":@"78",
                                @"GE":@"79",
                                @"GF":@"80",
                                @"GG":@"81",
                                @"GH":@"82",
                                @"GI":@"83",
                                @"GL":@"84",
                                @"GM":@"85",
                                @"GN":@"86",
                                @"GP":@"87",
                                @"GQ":@"88",
                                @"GR":@"89",
                                @"GS":@"90",
                                @"GT":@"91",
                                @"GU":@"92",
                                @"GW":@"93",
                                @"GY":@"94",
                                @"HK":@"95",
                                @"HM":@"96",
                                @"HN":@"97",
                                @"HR":@"98",
                                @"HT":@"99",
                                @"HU":@"100",
                                @"ID":@"101",
                                @"IE":@"102",
                                @"IL":@"103",
                                @"IM":@"104",
                                @"IN":@"105",
                                @"IO":@"106",
                                @"IQ":@"107",
                                @"IR":@"108",
                                @"IS":@"109",
                                @"IT":@"110",
                                @"JE":@"111",
                                @"JM":@"112",
                                @"JO":@"113",
                                @"JP":@"114",
                                @"KE":@"115",
                                @"KG":@"116",
                                @"KH":@"117",
                                @"KI":@"118",
                                @"KM":@"119",
                                @"KN":@"120",
                                @"KP":@"121",
                                @"KR":@"122",
                                @"KW":@"124",
                                @"KY":@"125",
                                @"KZ":@"126",
                                @"LA":@"127",
                                @"LB":@"128",
                                @"LC":@"129",
                                @"LI":@"130",
                                @"LK":@"131",
                                @"LR":@"132",
                                @"LS":@"133",
                                @"LT":@"134",
                                @"LU":@"135",
                                @"LV":@"136",
                                @"LY":@"137",
                                @"MA":@"138",
                                @"MC":@"139",
                                @"MD":@"140",
                                @"ME":@"141",
                                @"MF":@"142",
                                @"MG":@"143",
                                @"MH":@"144",
                                @"MK":@"145",
                                @"ML":@"146",
                                @"MM":@"147",
                                @"MN":@"148",
                                @"MO":@"149",
                                @"MP":@"150",
                                @"MQ":@"151",
                                @"MR":@"152",
                                @"MS":@"153",
                                @"MT":@"154",
                                @"MU":@"155",
                                @"MV":@"156",
                                @"MW":@"157",
                                @"MX":@"158",
                                @"MY":@"159",
                                @"MZ":@"160",
                                @"NA":@"161",
                                @"NC":@"162",
                                @"NE":@"163",
                                @"NF":@"164",
                                @"NG":@"165",
                                @"NI":@"166",
                                @"NL":@"167",
                                @"NO":@"168",
                                @"NP":@"169",
                                @"NR":@"170",
                                @"NU":@"171",
                                @"NZ":@"172",
                                @"OM":@"173",
                                @"PA":@"174",
                                @"PE":@"175",
                                @"PF":@"176",
                                @"PG":@"177",
                                @"PH":@"178",
                                @"PK":@"179",
                                @"PL":@"180",
                                @"PM":@"181",
                                @"PN":@"182",
                                @"PR":@"183",
                                @"PS":@"184",
                                @"PT":@"185",
                                @"PW":@"186",
                                @"PY":@"187",
                                @"QA":@"188",
                                @"RE":@"189",
                                @"RO":@"190",
                                @"RS":@"191",
                                @"RU":@"192",
                                @"RW":@"193",
                                @"SA":@"194",
                                @"SB":@"195",
                                @"SC":@"196",
                                @"SD":@"197",
                                @"SE":@"198",
                                @"SG":@"199",
                                @"SH":@"200",
                                @"SI":@"201",
                                @"SJ":@"202",
                                @"SK":@"203",
                                @"SL":@"204",
                                @"SM":@"205",
                                @"SN":@"206",
                                @"SO":@"207",
                                @"SR":@"208",
                                @"ST":@"209",
                                @"SV":@"210",
                                @"SX":@"211",
                                @"SY":@"212",
                                @"SZ":@"213",
                                @"TC":@"214",
                                @"TD":@"215",
                                @"TF":@"216",
                                @"TG":@"217",
                                @"TH":@"218",
                                @"TJ":@"219",
                                @"TK":@"220",
                                @"TL":@"221",
                                @"TM":@"222",
                                @"TN":@"223",
                                @"TO":@"224",
                                @"TR":@"225",
                                @"TT":@"226",
                                @"TV":@"227",
                                @"TW":@"228",
                                @"TZ":@"229",
                                @"UA":@"230",
                                @"UG":@"231",
                                @"UM":@"232",
                                @"US":@"233",
                                @"UY":@"234",
                                @"UZ":@"235",
                                @"VA":@"236",
                                @"VC":@"237",
                                @"VE":@"238",
                                @"VG":@"239",
                                @"VI":@"240",
                                @"VN":@"241",
                                @"VU":@"242",
                                @"WF":@"243",
                                @"WS":@"244",
                                @"XK":@"123",
                                @"YE":@"245",
                                @"YT":@"246",
                                @"ZA":@"247",
                                @"ZM":@"248",
                                @"ZW":@"249"};
    return codeIdDic[code];
    
}
@end


