//
//  MBProgressHUD+LLMB.h
//  Mutable
//
//  Created by 嘚嘚以嘚嘚 on 2018/5/20.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (LLMB)
typedef NS_ENUM(NSUInteger, BWMMBProgressHUDMsgType) {
    BWMMBProgressHUDMsgTypeSuccessful,
    BWMMBProgressHUDMsgTypeError,
    BWMMBProgressHUDMsgTypeWarning,
    BWMMBProgressHUDMsgTypeInfo
};


+ (void)showTipMessageInWindow:(NSString*)message;
+ (void)showTipMessageInView:(NSString*)message;
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer;


+ (void)showActivityMessageInWindow:(NSString*)message;
+ (void)showActivityMessageInView:(NSString*)message;
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer;


+ (void)showSuccessMessage:(NSString *)Message;
+ (void)showErrorMessage:(NSString *)Message;
+ (void)showInfoMessage:(NSString *)Message;
+ (void)showWarnMessage:(NSString *)Message;


//+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
//+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message;


+ (void)hideHUD;


+(void)showCustomMessage:(NSString * )message
                    type:(BWMMBProgressHUDMsgType)type
                isWindow:(BOOL)isWindow
                   timer:(NSTimeInterval)aTimer
              completion:(void(^)(void))completion;


@end
