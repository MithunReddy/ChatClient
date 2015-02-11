//
//  LoginViewController.h
//  ChatClient
//
//  Created by nunc03 on 2/6/15.
//  Copyright (c) 2015 Mithun Reddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPStream.h"
#import "XMPPJID.h"
#import "XMPPRoster.h"
#import "XMPPvCardTemp.h"
#import "XMPPvCardTempModule.h"
#import "XMPPvCardCoreDataStorage.h"
#import "XMPPReconnect.h"
#import "XMPPRoster.h"
#import "XMPPRosterCoreDataStorage.h"
#import "XMPPCapabilities.h"
#import "XMPPCapabilitiesCoreDataStorage.h"
@interface LoginViewController : UIViewController<XMPPStreamDelegate,XMPPvCardTempModuleDelegate>{
    
    XMPPStream *xmppStream;
    XMPPRoster *xmppRoster;
    XMPPvCardCoreDataStorage *xmppvCardStorage;
    XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;
    NSString *password;
    
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordtextField;
- (IBAction)login:(id)sender;
@property (nonatomic, readonly) XMPPStream *xmppStream;
@property (nonatomic, readonly) XMPPRoster *xmppRoster;

@property (nonatomic, strong, readonly) XMPPReconnect *xmppReconnect;
@property (nonatomic, strong, readonly) XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic, strong, readonly) XMPPvCardTempModule *xmppvCardTempModule;
@property (nonatomic, strong, readonly) XMPPvCardAvatarModule *xmppvCardAvatarModule;
@property (nonatomic, strong, readonly) XMPPCapabilities *xmppCapabilities;
@property (nonatomic, strong, readonly) XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;


@end
