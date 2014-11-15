//
//  NewsDetailsViewController.m
//  SocialTrainer
//
//  Created by Paweł Nużka on 15/11/14.
//  Copyright (c) 2014 MediaHackDay. All rights reserved.
//

#import "NewsDetailsViewController.h"
#import "NewsFeedCell.h"
#import "NewsHeaderCell.h"
#import "NewsTitleCell.h"
#import "RecordViewCell.h"
#import "FeedCell.h"
#import "ArticleViewController.h"
#import "ArticleModel.h"
#import "Server.h"


@interface NewsDetailsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *cellsData;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *socialNews;
@end

@implementation NewsDetailsViewController
@synthesize cellsData;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.news.name;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    cellsData = @[
                @{@"cellIdentifier":[FeedCell cellIdentifier], @"height": @([FeedCell cellHeight])},
                 @{@"cellIdentifier":[NewsHeaderCell cellIdentifier], @"height": @([NewsHeaderCell cellHeight])},
                 @{@"cellIdentifier":[NewsFeedCell cellIdentifier], @"height": @([NewsFeedCell cellHeight])},
                 @{@"cellIdentifier":[RecordViewCell cellIdentifier], @"height": @([RecordViewCell cellHeight])}
                 ];
    
    // Do any additional setup after loading the view.
    
    NSString *topicId = [self.news.article valueForKey:@"id"];
    
    [[Server sharedInstance] getSocialNews:^(NSArray *socialNews) {
        self.socialNews = socialNews;
    } forTopicId:topicId failureHandler:^(NSError *e) {
        NSLog(@"error %@", e);
    }];
     

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = self.cellsData[indexPath.row];
    
    MHCell *cell = [tableView dequeueReusableCellWithIdentifier:cellData[@"cellIdentifier"]
                                                   forIndexPath:indexPath];
    
    [cell loadData:self.news];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = self.cellsData[indexPath.row];
    return [cellData[@"height"] floatValue];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellsData.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1)
    {
        [self performSegueWithIdentifier:@"showArticle" sender:nil];
    }
    else if (indexPath.row == self.cellsData.count - 1)
    {
        [self captureVideo:nil];
    }
    
    
    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showArticle"])
    {
        ArticleViewController *articleViewController = segue.destinationViewController;
        [articleViewController setUrl:self.news.article.url];
    }
}


#pragma mark - Capture Video

- (IBAction)captureVideo:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.videoURL = info[UIImagePickerControllerMediaURL];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    self.videoController = [[MPMoviePlayerController alloc] init];
    
    [self.videoController setContentURL:self.videoURL];
    [self.videoController.view setFrame:CGRectMake (0, 0, self.view.frame.size.width, 460)];
    [self.view addSubview:self.videoController.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(videoPlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.videoController];
    [self.videoController play];
    [self saveVideo:picker info:info];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)videoPlayBackDidFinish:(NSNotification *)notification {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    // Stop the video player and remove it from view
    [self.videoController stop];
    [self.videoController.view removeFromSuperview];
    self.videoController = nil;
    
    // Display a message
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Video Playback" message:@"Just finished the video playback. The video is now removed." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okayAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)saveVideo:(UIImagePickerController *) picker info:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        NSString *moviePath = (NSString *)[[info objectForKey:
                                            UIImagePickerControllerMediaURL] path];
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (
                                                 moviePath, nil, nil, nil);
        }
    }
}

@end
