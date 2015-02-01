//
//  AllIssuesTableViewController.m
//  GitHubIssue
//
//  Created by XiaoYifan on 1/30/15.
//  Copyright (c) 2015 XiaoYifan. All rights reserved.
//

#import "AllIssuesTableViewController.h"
#import "IssueTableViewCell.h"
#import "IssueTableViewController.h"
#import "detailTableViewController.h"
@interface AllIssuesTableViewController ()

@property (strong, nonatomic) NSMutableArray *allIssueData;

@end

@implementation AllIssuesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //Initialize the RefreshControl in second UIViewController
    UIRefreshControl *pullDown2 = [[UIRefreshControl alloc] init];
    pullDown2.tintColor = [UIColor grayColor];
    [pullDown2 addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = pullDown2;
    

    
    
}

-(void)refresh{
    [self downloadGithubIssueData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self downloadGithubIssueData];
}

-(void)downloadGithubIssueData{
    
    // GitHub API url
    NSString *url = @"https://api.github.com/repos/uchicago-mobi/2015-Winter-Forum/issues?state=all";
    
    // Create NSUrlSession
    NSURLSession *session = [NSURLSession sharedSession];
    
    // Create data download taks
    [[session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                
                NSError *jsonError;
                self.allIssueData = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&jsonError];
                // Log the data for debugging
               // NSLog(@"DownloadeData:%@",self.allIssueData);
                
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    NSUInteger num  = [self.allIssueData count];
    NSLog(@"%lu",(unsigned long)num);
    return num;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllIssue" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSDictionary *issue = [self.allIssueData objectAtIndex:indexPath.row];
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




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller
    if ([[segue identifier] isEqualToString:@"AllDetail"]) {
        NSLog(@"The method is called");
        
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSDictionary * issueItem = [self.allIssueData objectAtIndex:indexPath.row];
        
        detailTableViewController *idvc  = [segue destinationViewController];
        
        [idvc setCurrentIssue:issueItem];
        //idvc.currentIssue = issueItem;
        
    }
}


@end
