//
//  allIssueTableViewCell.h
//  GitHubIssue
//
//  Created by XiaoYifan on 1/30/15.
//  Copyright (c) 2015 XiaoYifan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface allIssueTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UIImageView *imageStatus;

@end
