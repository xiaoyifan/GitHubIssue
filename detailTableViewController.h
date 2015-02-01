//
//  detailTableViewController.h
//  GitHubIssue
//
//  Created by XiaoYifan on 1/31/15.
//  Copyright (c) 2015 XiaoYifan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailTableViewController : UITableViewController

@property (nonatomic, strong) NSDictionary * currentIssue;

@property (weak, nonatomic) IBOutlet UILabel *issueTitle;

@property (weak, nonatomic) IBOutlet UILabel *issueNumber;

@property (weak, nonatomic) IBOutlet UILabel *issueAuthor;

@property (weak, nonatomic) IBOutlet UILabel *commentNumber;

@property (weak, nonatomic) IBOutlet UILabel *body;

@property (weak, nonatomic) IBOutlet UILabel *updateTime;

@end
