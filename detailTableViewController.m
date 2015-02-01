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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
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

- (IBAction)browseInSafari:(id)sender {
    
    NSLog(@"browsing safari");
    
    NSURL *url = [NSURL URLWithString:self.url];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
