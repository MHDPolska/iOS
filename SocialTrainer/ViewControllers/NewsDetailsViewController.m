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
#import <XCDYouTubeKit/XCDYouTubeVideoPlayerViewController.h>
#import "SocialModel.h"


@interface NewsDetailsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *cellsData;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *socialNews;
@property (nonatomic, strong) NSMutableArray *ytPlayers;
@end

@implementation NewsDetailsViewController
@synthesize cellsData;

- (UIView*)getMainThumbnailView
{
    [self.tableView reloadData];
    return [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]].contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.news.name;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    cellsData = [NSMutableArray arrayWithArray:@[
                @{@"cellIdentifier":[FeedCell cellIdentifier], @"height": @([FeedCell cellHeight])},
                 @{@"cellIdentifier":[NewsHeaderCell cellIdentifier], @"height": @([NewsHeaderCell cellHeight])},
                 @{@"cellIdentifier":[RecordViewCell cellIdentifier], @"height": @([RecordViewCell cellHeight])}
                 ]];

    
    // Do any additional setup after loading the view.
    [self updateSocialNews];

}


- (void)updateSocialNews
{
    NSString *topicId = [self.news.article valueForKey:@"id"];
    [[Server sharedInstance] getSocialNews:^(NSArray *socialNews) {
        self.socialNews = socialNews;
        [self.socialNews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self insertSocialModel:obj];
         }];
        [self.tableView reloadData];
        
    } forTopicId:topicId failureHandler:^(NSError *e) {
        NSLog(@"error %@", e);
    }];
}

- (void)insertSocialModel:(SocialModel *)model
{
    NSDictionary *socialDict = @{@"cellIdentifier":[NewsFeedCell cellIdentifier], @"height":@([NewsFeedCell cellHeight]),
                                 @"object": model};
    [cellsData insertObject:socialDict atIndex:cellsData.count-1];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cellData = self.cellsData[indexPath.row];
    NSString *cellIdentifier = cellData[@"cellIdentifier"];
    
    MHCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                   forIndexPath:indexPath];
    if ([cellIdentifier isEqualToString:[NewsFeedCell cellIdentifier]])
    {
        NewsFeedCell *nfCell = (NewsFeedCell *)cell;
        NSDictionary *object = self.cellsData[indexPath.row];
        [nfCell loadData:object[@"object"]];
    }
    else
    {
        [cell loadData:self.news];
    }
    
    NSLog(@"indexPath: %@, frame: %@",indexPath,NSStringFromCGRect([self.view convertRect:cell.frame fromView:self.view]));
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
    else if (indexPath.row > 1)
    {
        NSDictionary *object = self.cellsData[indexPath.row];
        SocialModel *model = object[@"object"];
        [self showVideo:model.videoId];
    }
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    
//}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showArticle"])
    {
        ArticleViewController *articleViewController = segue.destinationViewController;
        [articleViewController setUrl:self.news.article.url];
    }
}


#pragma mark - Player
- (void)showVideo:(NSString *)ytIdentifier
{
    XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:ytIdentifier];
    [self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
    [videoPlayerViewController.moviePlayer play];
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
    
//    self.videoController = [[MPMoviePlayerController alloc] init];
//    
//    [self.videoController setContentURL:self.videoURL];
//    [self.videoController.view setFrame:CGRectMake (0, 0, self.view.frame.size.width, 460)];
//    [self.view addSubview:self.videoController.view];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(videoPlayBackDidFinish:)
//                                                 name:MPMoviePlayerPlaybackDidFinishNotification
//                                               object:self.videoController];
//    [self.videoController play];
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
        
         NSData *data = [[NSFileManager defaultManager] contentsAtPath:moviePath];
        [[Server sharedInstance] uploadMovieForTopicWithID:@"355e272d90b48ee8eab1de891e14510d" movieData:data name:@"nameeee"
         success:^(SocialModel *model) {
             [self insertSocialModel:model];
             [self.tableView reloadData];
         } failure:^(NSError *e) {
            
        }];
    }
}

@end
