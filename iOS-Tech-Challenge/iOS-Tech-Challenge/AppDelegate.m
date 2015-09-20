//
//  AppDelegate.m
//  iOS-Tech-Challenge
//
//  Created by AKI on 2015/9/19.
//  Copyright © 2015年 AKI. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import <Parse/Parse.h>

@interface AppDelegate () <DFBlunoDelegate>
@property(strong, nonatomic) NSMutableArray* aryDevices;

@property (strong, nonatomic) IBOutlet UILabel *lbReceivedMsg;
@property (weak, nonatomic) IBOutlet UITextField *txtSendMsg;
@property (weak, nonatomic) IBOutlet UILabel *lbReady;

@property (strong, nonatomic) IBOutlet UIView *viewDevices;
@property (weak, nonatomic) IBOutlet UITableView *tbDevices;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *SearchIndicator;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellDevices;

- (IBAction)actionSearch:(id)sender;
- (IBAction)actionReturn:(id)sender;
- (IBAction)actionSend:(id)sender;
- (IBAction)actionDidEnd:(id)sender;
@end

@implementation AppDelegate
@synthesize nav;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.blunoManager = [DFBlunoManager sharedInstance];
    self.blunoManager.delegate = self;
    self.aryDevices = [[NSMutableArray alloc] init];
    [self.blunoManager scan];
    self.lbReceivedMsg = [UILabel new];
    [self actionSend:nil];

    
//    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    
//    ViewController *viewC = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
//    
//    nav = [[mNav alloc] initWithRootViewController:viewC];
//    
//    [self.window setRootViewController:nav];
//    
//    
//    [self.window makeKeyAndVisible];

    
    [Parse setApplicationId:@"J5WZOPN3ntsHOZqeuU6Mx5ciAGgsYNoIAPBhfCmT"
                  clientKey:@"D5U8OOsxPREgxjaLEYRSnnVoN9j3zBWwNS9s8eoY"];
    
    [PFUser enableAutomaticUser];
    
    PFACL *defaultACL = [PFACL ACL];
    
    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    
    if (application.applicationState != UIApplicationStateBackground) {
        // Track an app open here if we launch with a push, unless
        // "content_available" was used to trigger a background push (introduced in iOS 7).
        // In that case, we skip tracking here to avoid double counting the app-open.
        BOOL preBackgroundPush = ![application respondsToSelector:@selector(backgroundRefreshStatus)];
        BOOL oldPushHandlerOnly = ![self respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)];
        BOOL noPushPayload = ![launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
            [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        }
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else
#endif
    {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
    
    [PFPush subscribeToChannelInBackground:@"" block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
        } else {
            NSLog(@"ParseStarterProject failed to subscribe to push notifications on the broadcast channel.");
        }
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    
    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

#pragma mark- Actions

- (IBAction)actionSearch:(id)sender
{
    [self.aryDevices removeAllObjects];
    [self.tbDevices reloadData];
    [self.SearchIndicator startAnimating];
    self.viewDevices.hidden = NO;
    
    [self.blunoManager scan];
}

- (IBAction)actionReturn:(id)sender
{
    [self.SearchIndicator stopAnimating];
    [self.blunoManager stop];
    self.viewDevices.hidden = YES;
}

- (IBAction)actionSend:(id)sender
{
    [self.txtSendMsg resignFirstResponder];
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
    NSLog(@"%lld",dTime);
    
    if (self.blunoDev.bReadyToWrite)
    {
        //        NSString* strTemp = self.txtSendMsg.text;
        
        //        NSString* strTemp = @"T 1442262933\n";
        NSString * strTemp = [[NSString alloc]initWithFormat:@"T %lld\n",dTime ];
        NSData* data = [strTemp dataUsingEncoding:NSUTF8StringEncoding];
        [self.blunoManager writeDataToDevice:data Device:self.blunoDev];
    }
}

- (IBAction)actionSendSetime:(id)sender
{
    [self.txtSendMsg resignFirstResponder];
    if (self.blunoDev.bReadyToWrite)
    {
        //        NSString* strTemp = self.txtSendMsg.text;
        NSString* strTemp = @"S 10\n";
        NSLog(@"%@",strTemp);
        NSData* data = [strTemp dataUsingEncoding:NSUTF8StringEncoding];
        [self.blunoManager writeDataToDevice:data Device:self.blunoDev];
    }
}


- (IBAction)actionDidEnd:(id)sender
{
    [self.txtSendMsg resignFirstResponder];
}

#pragma mark- DFBlunoDelegate

-(void)bleDidUpdateState:(BOOL)bleSupported
{
    if(bleSupported)
    {
        [self.blunoManager scan];
    }
}
-(void)didDiscoverDevice:(DFBlunoDevice*)dev
{
    BOOL bRepeat = NO;
    for (DFBlunoDevice* bleDevice in self.aryDevices)
    {
        if ([bleDevice isEqual:dev])
        {
            bRepeat = YES;
            break;
        }
    }
    if (!bRepeat)
    {
        [self.aryDevices addObject:dev];
    }
    //[self.tbDevices reloadData];
    DFBlunoDevice* device = [self.aryDevices objectAtIndex:0];
    //裝置不存在
    if (self.blunoDev == nil)
    {
        self.blunoDev = device;
        [self.blunoManager connectToDevice:self.blunoDev];
    }
    //裝置等於
    else if ([device isEqual:self.blunoDev])
    {
        if (!self.blunoDev.bReadyToWrite)
        {
            [self.blunoManager connectToDevice:self.blunoDev];
        }
    }
    else
    {
        if (self.blunoDev.bReadyToWrite)
        {
            [self.blunoManager disconnectToDevice:self.blunoDev];
            self.blunoDev = nil;
        }
        
        [self.blunoManager connectToDevice:device];
    }
    self.viewDevices.hidden = YES;
    [self.SearchIndicator stopAnimating];
    
    
    
}
-(void)readyToCommunicate:(DFBlunoDevice*)dev
{
    self.blunoDev = dev;
    self.lbReady.text = @"Ready!";
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] + 32*60*60;
    long long dTime = [[NSNumber numberWithDouble:time] longLongValue];
    NSLog(@"%lld",dTime);
    
    if (self.blunoDev.bReadyToWrite)
    {
        //        NSString* strTemp = self.txtSendMsg.text;
        
        //        NSString* strTemp = @"T 1442262933\n";
        NSString * strTemp = [[NSString alloc]initWithFormat:@"T %lld\n",dTime ];
        NSLog(@"%@",strTemp);
        NSData* data = [strTemp dataUsingEncoding:NSUTF8StringEncoding];
        [self.blunoManager writeDataToDevice:data Device:self.blunoDev];
    }
}
-(void)didDisconnectDevice:(DFBlunoDevice*)dev
{
    self.lbReady.text = @"Not Ready!";
}
-(void)didWriteData:(DFBlunoDevice*)dev
{
    
}
-(void)didReceiveData:(NSData*)data Device:(DFBlunoDevice*)dev
{
    NSString* itemName = self.itemName;
    self.lbReceivedMsg.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",self.lbReceivedMsg.text);
    if([self.lbReceivedMsg.text isEqualToString:@"Timer Alarm!!\r\n"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                              //上面是標題的設定
                                                        message:itemName  //警告訊息內文的設定
                                                       delegate:self // 叫出AlertView之後，要給該ViewController去處理
                              
                                              cancelButtonTitle:@"OK"  //cancel按鈕文字的設定
                                              otherButtonTitles: nil]; // 其他按鈕的設定
        // 如果要多個其他按鈕 >> otherButtonTitles: @"check1", @"check2", nil];
        
        [alert show];  // 把alert這個物件秀出來
    }
    //    [alert release]; //釋放alert這個物件
    
}

@end
