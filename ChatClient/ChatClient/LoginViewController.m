//
//  LoginViewController.m
//  ChatClient
//
//  Created by nunc03 on 2/6/15.
//  Copyright (c) 2015 Mithun Reddy. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
{
}
@end

@implementation LoginViewController
@synthesize xmppStream,xmppvCardTempModule,xmppvCardAvatarModule,xmppReconnect,xmppCapabilities;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {
    [self connect];
    if ([self connect]) {
        NSLog(@"Connected !!!");
    }
}
- (BOOL)connect {
    
    [self setupStream];
    
    NSString *jabberID = @"ff627038-8a59-46e9-a6fa-cef28bac1021@splash.com";
    NSString *myPassword = @"12345678";
    
    if (![xmppStream isDisconnected]) {
        return YES;
    }
    
    
    if (jabberID == nil || myPassword == nil) {
        
        return NO;
    }
    
    [xmppStream setMyJID:[XMPPJID jidWithString:jabberID]];
    password = myPassword;
    
    NSError *error = nil;
    if (![xmppStream connectWithTimeout:200 error:&error])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[NSString stringWithFormat:@"Can't connect to server %@", [error localizedDescription]]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok" 
                                                  otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    
    return YES;
}

- (void)setupStream {
    
    xmppStream = [[XMPPStream alloc] init];
    [xmppStream setHostName:@"192.168.1.34"];
    [xmppStream setHostPort:5222];
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    xmppvCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    xmppvCardTempModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:xmppvCardStorage];
    xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:xmppvCardTempModule];
    xmppCapabilitiesStorage = [XMPPCapabilitiesCoreDataStorage sharedInstance];
    xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:xmppCapabilitiesStorage];
    
    xmppCapabilities.autoFetchHashedCapabilities = YES;
    xmppCapabilities.autoFetchNonHashedCapabilities = NO;
    
    // Activate xmpp modules
    
    [xmppReconnect         activate:xmppStream];
    [xmppRoster            activate:xmppStream];
    [xmppvCardTempModule   activate:xmppStream];
    [xmppvCardAvatarModule activate:xmppStream];
    [xmppCapabilities      activate:xmppStream];
    
    // Add ourself as a delegate to anything we may be interested in
    
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];

    
    
    
    
    
    
}
#pragma mark -
#pragma mark XMPP delegates
- (void)xmppStreamDidConnect:(XMPPStream *)sender {
    NSLog(@"Connected");

    NSError *error = nil;
    [[self xmppStream] authenticateWithPassword:password error:&error];
    
}
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error;
{
    NSLog(@"Not Authenticated %@",error);
}
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
    
    NSLog(@"Authenticated");
//    XMPPvCardCoreDataStorage *xmppvCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
//   xmppvCardTempModule = [[XMPPvCardTempModule alloc]initWithvCardStorage:xmppvCardStorage];
//    XMPPvCardTemp *temp = [cardTemp vCardTempForJID:[XMPPJID jidWithString:@"ff627038-8a59-46e9-a6fa-cef28bac1021@splash.com"] shouldFetch:YES];
//    NSLog(@"Temp:%@",temp.name);
    //XMPPvCardTempModule *vCardTempModule = [[XMPPvCardTempModule alloc]init];
    XMPPvCardTemp *myVcardTemp = [xmppvCardTempModule myvCardTemp];
   // [myVcardTemp setName:[NSString stringWithFormat:@"jsdbsdjkbsdjb"]];
    //[vCardTempModule updateMyvCardTemp:myVcardTemp];
//    XMPPvCardTemp *temp = [xmppvCardTempModule vCardTempForJID:nil shouldFetch:YES];
    
//    [xmppvCardTempModule vCardTempForJID:@"" xmppStream:@""];
//]

    
}


- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq {
    
    return NO;
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message {
    
    NSLog(@"Authenticated");
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence {
    
    NSLog(@"Authenticated");

}
- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule
        didReceivevCardTemp:(XMPPvCardTemp *)vCardTemp
                     forJID:(XMPPJID *)jid;
{
    
}
- (void)xmppvCardTempModuleDidUpdateMyvCard:(XMPPvCardTempModule *)vCardTempModule;
{
    
}
- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule failedToUpdateMyvCard:(NSXMLElement *)error;{
    
}

@end
