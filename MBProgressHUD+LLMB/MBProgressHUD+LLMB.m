//
//  MBProgressHUD+LLMB.m
//  Mutable
//
//  Created by 嘚嘚以嘚嘚 on 2018/5/20.
//  Copyright © 2018年 嘚嘚以嘚嘚. All rights reserved.
//

#import "MBProgressHUD+LLMB.h"

@implementation MBProgressHUD (LLMB)

/**
 创建mbprogress

 @param message 显示的标题
 @param isWindow 是否在window上
 @return 创建完成的hud
 */
+ (MBProgressHUD *)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow
{
    UIView  *view = isWindow? (UIView*)[UIApplication sharedApplication].delegate.window:[self getCurrentUIVC].view;
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    
//    hud.mode =MBProgressHUDModeCustomView;
//    hud.customView = [[UIImageView alloc]initWithImage:[UIImage sd_animatedGIFNamed:@"loading5"]];
//    hud.color = [UIColor blackColor];
//    hud.color = [hud.color colorWithAlphaComponent:0.5];
    
    hud.detailsLabel.text = message?message:@"加载中.....";
    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    hud.removeFromSuperViewOnHide = YES;
//    hud.dimBackground = YES;
    return hud;
}

#pragma mark-------------------- show Tip----------------------------

+ (void)showTipMessageInWindow:(NSString*)message
{
    [self showTipMessage:message isWindow:true timer:1];
}
+ (void)showTipMessageInView:(NSString*)message
{
    [self showTipMessage:message isWindow:false timer:1];
}
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:true timer:aTimer];
}
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:false timer:aTimer];
}
+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:1];
    
}

#pragma mark-------------------- show Activity----------------------------

+ (void)showActivityMessageInWindow:(NSString*)message
{
    [self showActivityMessage:message isWindow:true timer:0];
}
+ (void)showActivityMessageInView:(NSString*)message
{
    [self showActivityMessage:message isWindow:false timer:0];
}
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:true timer:aTimer];
}
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:false timer:aTimer];
}
+ (void)showActivityMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
        hud.mode = MBProgressHUDModeIndeterminate;
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];

    }
}

#pragma mark-------------------- show Image----------------------------

+ (void)showSuccessMessage:(NSString *)Message
{
    [self showCustomIconInWindow:@"MBHUD_Success" message:Message];
}
+ (void)showErrorMessage:(NSString *)Message
{
    [self showCustomIconInWindow:@"MBHUD_Error" message:Message];
}
+ (void)showInfoMessage:(NSString *)Message
{
    [self showCustomIconInWindow:@"MBHUD_Info" message:Message];
}
+ (void)showWarnMessage:(NSString *)Message
{
    [self showCustomIconInWindow:@"MBHUD_Warn" message:Message];
}
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:true timer:1.5];
    
}
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:false timer:1.5];
}
+ (void)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[@"MBProgressHUD+LLMB.bundle/MBProgressHUD" stringByAppendingPathComponent:iconName]]];
    hud.mode = MBProgressHUDModeCustomView;
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
}


+(void)showCustomMessage:(NSString * )message
                    type:(BWMMBProgressHUDMsgType)type
                isWindow:(BOOL)isWindow
                   timer:(NSTimeInterval)aTimer
              completion:(void(^)(void))completion
{
    
    NSString * imgName = [NSString string];
    switch (type) {
        case BWMMBProgressHUDMsgTypeSuccessful:
            imgName = @"MBHUD_Success";
            break;
            
        case BWMMBProgressHUDMsgTypeInfo:
            imgName = @"MBHUD_Info";
            break;
            
        case BWMMBProgressHUDMsgTypeError:
            imgName = @"MBHUD_Error";
            break;
            
        case BWMMBProgressHUDMsgTypeWarning:
            imgName = @"MBHUD_Warn";
            break;
        default:
            break;
    }
    
    
    if (aTimer > 0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(aTimer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completion();
        });
    }
    [self showCustomIcon:imgName message:message isWindow:isWindow timer:aTimer];
    
}

+ (void)hideHUD
{
    UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:winView animated:YES];
    [self hideHUDForView:[self getCurrentUIVC].view animated:YES];
}
//获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentWindowVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] firstObject];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else
    {
        result = window.rootViewController;
    }
    return  result;
}
+(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [[self class]  getCurrentWindowVC ];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}
@end
