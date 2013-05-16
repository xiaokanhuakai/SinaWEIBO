//
//  HomeViewController.h
//  SinaWEIBO
//
//  Created by L on 13-3-1.
//  Copyright (c) 2013年 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
@class TCWBEngine;

@interface HomeViewController : UIViewController<SinaWeiboDelegate, SinaWeiboRequestDelegate>
{
}

@property (nonatomic, retain) TCWBEngine *tengxunWB;
@property (nonatomic, copy) NSString    *tcUrl;
// sina
- (IBAction)sinaLogin:(id)sender;
- (IBAction)sinaShare:(id)sender;
- (IBAction)sinaAttention:(id)sender;
// tc
- (IBAction)tcLogin:(id)sender;
- (IBAction)tcShare:(id)sender;
- (IBAction)tcAttention:(id)sender;
// renren
- (IBAction)renrenLogin:(id)sender;
- (IBAction)renrenShare:(id)sender;
- (IBAction)renrenAttention:(id)sender;


@end
