//
//  EventScheduleView.m
//  Xmas-app-iOS
//
//  Created by Vincent Brubaker-Gianakos on 10/19/14.
//  Copyright (c) 2014 MZ. All rights reserved.
//

#import "EventScheduleViewController.h"

@interface EventScheduleViewController ()
@end

@implementation EventScheduleViewController

@synthesize myWebView;

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
    // Do any additional setup after loading the view.
    //NSString *url_string = @"http://christmasinthepark.com/calendar.html";
    NSString *url_string = [[NSBundle mainBundle] pathForResource:@"event_schedule" ofType:@"html" inDirectory:@"html"];
    //NSURL *url = [NSURL URLWithString:url_string];
    NSURL *url = [NSURL fileURLWithPath:url_string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init]; // I don't know what this line does
    [NSURLConnection sendAsynchronousRequest:request queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if([data length] > 0 && error == nil)
            [self.myWebView loadRequest:request];
        else if(error != nil)
            NSLog(@"Error: %@", error);
    }];
}

- (BOOL)webView:(UIWebView *)webView ShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];

    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"myapp"])
    {
        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"myfunction"])
        {
            NSLog([components objectAtIndex:2]);
        }
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
