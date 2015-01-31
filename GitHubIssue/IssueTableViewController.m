//
//  IssueTableViewController.m
//  GitHubIssue
//
//  Created by XiaoYifan on 1/30/15.
//  Copyright (c) 2015 XiaoYifan. All rights reserved.
//

#import "IssueTableViewController.h"
#import "IssueTableViewCell.h"
#import "IssueDetailViewController.h"

@interface IssueTableViewController ()

@property (nonatomic, strong) NSMutableArray *issueData;


@end

@implementation IssueTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIRefreshControl *pullDown = [[UIRefreshControl alloc] init];
    pullDown.tintColor = [UIColor grayColor];
    [pullDown addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = pullDown;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refresh{
    // Refreshing Issues
    NSLog(@"The tableView is refreshing.");
    [self downloadGithubIssueData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self downloadGithubIssueData];
}

-(void)downloadGithubIssueData{
    
    // GitHub API url
    NSString *url = @"https://api.github.com/repos/uchicago-mobi/2015-Winter-Forum/issues?state=open";
    
    // Create NSUrlSession
    NSURLSession *session = [NSURLSession sharedSession];
    
    // Create data download taks
    [[session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                
                NSError *jsonError;
                self.issueData = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&jsonError];
                // Log the data for debugging
                //NSLog(@"DownloadeData:%@",self.issueData);
                
                // Use dispatch_async to update the table on the main thread
                // Remember that NSURLSession is downloading in the background
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    
                    if(self.refreshControl.refreshing){
                        [self.refreshControl endRefreshing];
                        NSLog(@"refresh end");
                    }
                });
            }] resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSUInteger num  = [self.issueData count];
    return num;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IssueCell" forIndexPath:indexPath];
    
    // Configure the cell...
    //set the content of each cell here
    
    NSDictionary *issue = [self.issueData objectAtIndex:indexPath.row];
    cell.title.text = [issue objectForKey:@"title"];
    cell.author.text = [[issue objectForKey:@"user"] objectForKey:@"login"];
    cell.date.text = [issue objectForKey:@"updated_at"];
    
    NSString *status = [issue objectForKey:@"state"];
    if ([status  isEqual: @"open"]) {
      cell.imageStatus.image = [UIImage imageNamed:@"Image-boxOpen.png"];
    }
    else{
      cell.imageStatus.image =[UIImage imageNamed:@"Image-boxClosed.png"];
    }
    
    
    
    return cell;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller
    if ([[segue identifier] isEqualToString:@"moreDetail"]) {
        NSLog(@"The method is called");
        
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSDictionary * issueItem = [self.issueData objectAtIndex:indexPath.row];
        
        IssueDetailViewController *idvc  = [segue destinationViewController];
        
        [idvc setCurrentIssue:issueItem];
        //idvc.currentIssue = issueItem;
        
    }
}



@end
