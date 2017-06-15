//
//  SharedData.m
//  SaferApp
//
//  Created by Granjur on 2/11/2016.
//  Copyright © 2016 Granjur. All rights reserved.
//

#import "SharedData.h"
#import <UIKit/UIKit.h>


@interface SharedData ()

@end
@implementation SharedData

static SharedData * staticSharedDataInstance = NULL;

+(SharedData * ) getSharedInstance
{
    
    if(staticSharedDataInstance == NULL)
    {
        staticSharedDataInstance = [[SharedData alloc] init];
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
    }
    
    return self;
    
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
- (CGFloat)textViewHeightForAttributedText: (NSString*)text andWidth: (CGFloat)width heightWithoutText:(float)h {
    
    UITextView *calculationView = [[UITextView alloc] initWithFrame:CGRectMake(0.0, 0.0, width, 0.0)];
    
    [calculationView setTextContainerInset:UIEdgeInsetsZero];
    calculationView.textContainer.lineFragmentPadding = 0.0;
    calculationView.textAlignment = NSTextAlignmentLeft;
    calculationView.font = [UIFont systemFontOfSize:16];
//    [calculationView setAttributedText:text];
    calculationView.text = text;
    [calculationView sizeToFit];
//    CGSize size = [calculationView sizeThatFits:CGSizeMake(width, DBL_MAX)];
    
    if (text.length>0)
    {
        return calculationView.frame.size.height + h;
    }
    else
    {
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

-(NSString*) dayByNumber:(int) dayNum
{
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
/*
#pragma mark VideoConversion
-(void)exportVideo:(NSURL*)videoPath completionHanlder:(RequestCompletionHandler) handler{
    
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

-(UIImage*)getVideoThumbnail:(NSURL*)filePath{
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



-(NSString*)imageUploadCompleteURL:(UploadClassType) uploadType withFileType:(UploadObjectType)fileType withRecordId:(NSString*)recordId andReportId:(NSString*)reportId{
    
   NSString*url =  [NSString stringWithFormat:@"%@%@&type=%lu&filetype=%lu&record_id=%@&report_id=%@",API_IMAGE_UPLOAD_GENERIC,[GTAuthorizationManager getSharedInstance].accessToken,(unsigned long)uploadType,(unsigned long)fileType,recordId,reportId];
    return url;
    
}

- (NSString *)urlencode:(NSString*)str {
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
*/

@end


