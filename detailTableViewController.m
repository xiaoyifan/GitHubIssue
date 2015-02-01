//
//  detailTableViewController.m
//  GitHubIssue
//
//  Created by XiaoYifan on 1/31/15.
//  Copyright (c) 2015 XiaoYifan. All rights reserved.
//

#import "detailTableViewController.h"

@interface detailTableViewController ()

@property (nonatomic, strong) NSString *url;

@end

@implementation detailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Show all the issue details
    self.issueTitle.text = [self.currentIssue objectForKey:@"title"];
    
    NSNumber *number = [self.currentIssue objectForKey:@"number"];
    self.issueNumber.text = [NSString stringWithFormat:@"#%@",number];
    
    self.issueAuthor = [[self.currentIssue objectForKey:@"user"] objectForKey:@"login"];
    
    
    NSNumber *commentNumber  = [self.currentIssue objectForKey:@"comments"];
    self.commentNumber.text= [NSString stringWithFormat:@"comments: %@",commentNumber];
    
    self.updateTime.text  = [self.currentIssue objectForKey:@"updated_at"];
    
    self.body.text = [self.currentIssue objectForKey:@"body"];
    
    self.url = [self.currentIssue objectForKey:@"html_url"];
   
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-Safari browsing
- (IBAction)browseInSafari:(id)sender {
    
    NSLog(@"browsing safari");
    
    NSURL *url = [NSURL URLWithString:self.url];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}



@end
