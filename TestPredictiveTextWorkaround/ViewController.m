//
//  ViewController.m
//  TestPredictiveTextWorkaround
//
//  Created by Elliot Fiske on 10/11/19.
//  Copyright © 2019 elliotfiske. All rights reserved.
//

#import "ViewController.h"

#import <WebKit/WebKit.h>
#import <objc/runtime.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *uiWebView;
@property (weak, nonatomic) IBOutlet WKWebView *wkWebView;

@end

@implementation ViewController

BOOL canPerformAction(id withSender) {
   return false;
} 

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view.
   
   [self.uiWebView loadHTMLString:@"<body><form> First name:<br> <input type='text' name='firstname'><br>      </form></body>" baseURL:nil];
   [self.wkWebView loadHTMLString:@"<body><form> First name:<br> <input type='text' name='firstname'><br>      </form></body>" baseURL:nil];
   
   
   // UH OH HACK TIME
   Class class = NSClassFromString(@"UIThreadSafeNode");
   
   BOOL success = class_addMethod(class, @selector(canPerformAction:withSender:), (IMP)canPerformAction, "@@:");
   NSLog(@"canPerformAction: - %i", success);
}


@end
