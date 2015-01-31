//
//  IssueDetailViewController.m
//  GitHubIssue
//
//  Created by XiaoYifan on 1/30/15.
//  Copyright (c) 2015 XiaoYifan. All rights reserved.
//

#import "IssueDetailViewController.h"

@interface IssueDetailViewController ()
@property (nonatomic, strong) NSString *url;
@end

@implementation IssueDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}



-(void)viewWillAppear:(BOOL)animated{
    self.issueTitle.text = [self.currentIssue objectForKey:@"title"];
    self.issueNumber.text = [NSString stringWithFormat:@"%@",[self.currentIssue objectForKey:@"number"]] ;
    self.author.text =[[self.currentIssue objectForKey:@"user"] objectForKey:@"login"];
    self.body.text =[self.currentIssue objectForKey:@"body"];
    self.updateTime.text =[self.currentIssue objectForKey:@"updated_at"];
    self.url=[self.currentIssue objectForKey:@"html_url"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)browseInSafari:(id)sender {
    
    NSURL *url = [NSURL URLWithString:self.url];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
