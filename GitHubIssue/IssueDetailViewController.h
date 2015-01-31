//
//  IssueDetailViewController.h
//  GitHubIssue
//
//  Created by XiaoYifan on 1/30/15.
//  Copyright (c) 2015 XiaoYifan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IssueDetailViewController : UIViewController


@property (nonatomic, weak) IBOutlet UILabel *issueTitle;
@property (nonatomic, weak) IBOutlet UILabel *issueNumber;
@property (nonatomic, weak) IBOutlet UILabel *author;
@property (nonatomic, weak) IBOutlet UITextView *body;
@property (nonatomic, weak) IBOutlet UILabel *updateTime;


@property (strong, nonatomic) NSDictionary * currentIssue;


@end
