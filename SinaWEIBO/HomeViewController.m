//
//  HomeViewController.m
//  SinaWEIBO
//
//  Created by L on 13-3-1.
//  Copyright (c) 2013年 L. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "SinaWeiboRequest.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    TCWBEngine *engine = [[TCWBEngine alloc] initWithAppKey:WiressSDKDemoAppKey andSecret:WiressSDKDemoAppSecret andRedirectUrl:@"http://www.ying7wang7.com"];
//    [engine setRootViewController:self];
//    //[fjkfaklfl232 setRedirectURI:@"http://www.ying7wang7.com"];
//    self.tengxunWB = engine;
//    [engine release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma sina
- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

- (IBAction)sinaLogin:(id)sender {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSLog(@"%@", [keyWindow subviews]);
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    if (![sinaweibo isAuthValid]) {
        [sinaweibo logIn];
    }
}

- (IBAction)sinaShare:(id)sender {
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"statuses/update.json"
                       params:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"sina fen xiang。http://t.cn/aOaiGp", @"status", nil]
                   httpMethod:@"POST"
                     delegate:self];
    
}

- (IBAction)sinaAttention:(id)sender
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init]autorelease];
    //    [dict setObject:sinaweibo.accessToken forKey:@"access_token"];
    [dict setObject:sinaweibo.accessToken forKey:@"access_token"];
    [dict setObject:@"明月长在心" forKey:@"screen_name"];
    SinaWeiboRequest *request = [SinaWeiboRequest requestWithURL:@"https://api.weibo.com/2/friendships/create.json" httpMethod:@"POST" params:dict delegate:self];
    [request connect];
    
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"登陆成功"
                                                       delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
    [alertView release];
    //    [self resetButtons];
    [self storeAuthData];
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"登陆失败"
                                                       delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
    [alertView release];
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"发布失败"
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Post image status failed!"
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post image status failed with error : %@", error);
    }else if ([request.url hasSuffix:@"friendships/create.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Post image status failed!"
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
        NSLog(@"Post image status failed with error : %@", error);
    }
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    
    if ([request.url hasSuffix:@"friendships/create.json"])
    {
        
        int code = [[NSString stringWithFormat:@"%@",[result objectForKey:@"error_code"]] intValue];
        switch (code) {
            case 20506:  //Already followed 已经关注此用户
                NSLog(@"已经关注此用户");
                break;
            default:
                break;
        }
        
    }
    else if ([request.url hasSuffix:@"users/show.json"])
    {
        NSLog(@"users/show.json");
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        NSLog(@"statuses/user_timeline.json");
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"发布成功"
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Post image status succeed!"
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        [alertView release];
        
    }
}

- (void)showAlertMessage:(NSString *)msg {
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
                                                       message:msg
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
    [alertView show];
    [alertView release];
    
}
#pragma tc
- (IBAction)tcLogin:(id)sender
{
    [self.tengxunWB logInWithDelegate:self
                           onSuccess:@selector(onSuccessLogin)
                           onFailure:@selector(onFailureLogin:)];
}

- (void)onLogout {
    // 注销授权
//    if ([self.wbEngine logOut]) {
//        [self showAlertMessage:@"登出成功！"];
//    }else {
//        [self showAlertMessage:@"登出失败！"];
//    }
}

- (IBAction)tcShare:(id)sender   //TC发表一条微博
{
    
//    [_wbEngine postTextTweetWithFormat:@"json"
//                              content:@"hello,world"
//                             clientIP:@"10.10.1.31"
//                            longitude:nil
//                          andLatitude:nil
//                          parReserved:nil
//                             delegate:self
//                            onSuccess:@selector(successCallBack:)
//                            onFailure:@selector(failureCallBack:)];
    
    
}

- (IBAction)tcAttention:(id)sender   //TC收听某个用户
{
//    [_wbEngine addFriendsWithFormat:@"json"
//                             names:@"api_weibo"
//                        andOpenIDs:nil
//                       parReserved:nil
//                          delegate:self
//                         onSuccess:@selector(successCallBack:)
//                         onFailure:@selector(failureCallBack:)];
}

#pragma TC delegate
//登录失败回调
- (void)onFailureLogin:(NSError *)error
{
    //    NSString *message = [[NSString alloc] initWithFormat:@"%@",[NSNumber numberWithInteger:[error code]]];
    //    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error domain]
    //                                                        message:message
    //                                                       delegate:self
    //                                              cancelButtonTitle:@"确定"
    //                                              otherButtonTitles:nil];
    //    [alertView show];
    //    [alertView release];
    //    [message release];
    [self showAlertMessage:@"登录失败"];
}

//授权成功回调
- (void)onSuccessAuthorizeLogin
{
    [self showAlertMessage:@"授权成功"];
}

#pragma mark - callback


- (void)successCallBack:(id)result{
//    TCGetTimelineController *tlController = [[TCGetTimelineController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:tlController];
//    tlController.homeDic = (NSDictionary *)result;
//    tlController.url = self.tcUrl;
//    self.tcUrl = nil;
//    [self presentViewController:nav animated:YES completion:nil];
//    
//    [tlController release];
//    [nav release];
}

- (void)failureCallBack:(NSError *)error{
    NSLog(@"error: %@", error);
}

- (IBAction)renrenLogin:(id)sender
{
    
}

- (IBAction)renrenShare:(id)sender {
    
}

- (IBAction)renrenAttention:(id)sender
{
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init]autorelease];
    [dict setObject:@"" forKey:@""];
    [dict setObject:@"" forKey:@""];
    [dict setObject:@"" forKey:@""];
    [dict setObject:@"" forKey:@""];
    [dict setObject:@"" forKey:@""];
    [dict setObject:@"" forKey:@""];
    [dict setObject:@"" forKey:@""];
    
}

- (void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"URLPost" object:nil];
//    [self.tengxunWB cancelAllRequest];
    self.tengxunWB = nil;
    [super dealloc];
    [self.tengxunWB release], _tengxunWB = nil;
    [super dealloc];
}

@end
