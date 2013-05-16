//
//  AppDelegate.h
//  SinaWEIBO
//
//  Created by L on 13-3-1.
//  Copyright (c) 2013年 L. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define kAppKey @"3639664697"
//#define kAppSecret @"dfe663094b6b28fc1ca8bf6f3d1d3473"
//#define kAppRedirectURI @"www.im20.com.cn"
#define kAppKey @"3298532718"
#define kAppSecret @"211dee8153bdd59dfb4f8034bb8cc546"
#define kAppRedirectURI @"http://www.chihao.com/index.php?app=home&mod=public&act=callback"
@class SinaWeibo;
@class HomeViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    SinaWeibo *sinaweibo;
}

@property (strong, nonatomic) HomeViewController *viewController;
@property (readonly, nonatomic) SinaWeibo *sinaweibo;
@property (strong, nonatomic) UIWindow *window;

@end
