//
//  CircleViewController.m
//  GitHubIssue
//
//  Created by XiaoYifan on 1/30/15.
//  Copyright (c) 2015 XiaoYifan. All rights reserved.
//

#import "CircleViewController.h"

#import "CircleView.h"

@interface CircleViewController ()
@property (strong, nonatomic) NSMutableArray *allIssueData;

@property (weak, nonatomic) IBOutlet UILabel *openLabel;
@property (weak, nonatomic) IBOutlet UILabel *openColorLabel;

@property (weak, nonatomic) IBOutlet UILabel *closeLabel;

@property (weak, nonatomic) IBOutlet UILabel *closeColorLabel;



@end

@implementation CircleViewController

#pragma mark-viewDidLoad and customize UI for iPad
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.closeColorLabel.center = CGPointMake((float)self.view.frame.size.width*0.4, (float)self.view.frame.size.height*0.75);
    
    self.openColorLabel.center = CGPointMake((float)self.view.frame.size.width*0.4, (float)self.view.frame.size.height*0.8);
    
    self.closeLabel.center =CGPointMake((float)self.view.frame.size.width*0.4+self.openLabel.frame.size.width/2+35, (float)self.view.frame.size.height*0.75);
    
    self.openLabel.center =CGPointMake((float)self.view.frame.size.width*0.4+self.openLabel.frame.size.width/2+35, (float)self.view.frame.size.height*0.8);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self downloadGithubIssueData];
}

#pragma mark - DataFetch
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
                    
                    int openNumber  = 0;
                    int closedNumber  = 0;
                    
                    for (NSDictionary* obj in self.allIssueData) {
                        if ([[obj objectForKey:@"state"] isEqualToString:@"open"]) {
                            openNumber++;
                        }
                        else{
                            closedNumber++;
                             }
                    }
                    
                    CircleView *drawView = (CircleView *)self.view;
                    drawView.openNumber = openNumber;
                    drawView.closedNumber = closedNumber;
                    
                    self.openLabel.text = [[NSString alloc] initWithFormat:@"%d Issues Open", openNumber];
                    self.closeLabel.text = [[NSString alloc] initWithFormat:@"%d Issues Closed", closedNumber];
                    
                    [self.view setNeedsDisplay];
                    
                    
                });
            }] resume];
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
