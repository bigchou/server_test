//
//  getimgViewController.m
//  server_test
//
//  Created by Timmy on 2016/6/8.
//  Copyright © 2016年 sfdfsddsdf. All rights reserved.
//

#import "getimgViewController.h"

@interface getimgViewController ()
- (IBAction)getimgbutton:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UIImageView *urlimgview;

@end

@implementation getimgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getimgbutton:(UIButton *)sender {
    // press the button and get image from url 
    NSString *imageName = @"test.jpg";
    NSString *urlString = [NSString stringWithFormat: @"http://www.csie.ntnu.edu.tw/~40347905s/uploads/%@", imageName];
    
    NSURL *imageURL = [NSURL URLWithString:urlString];
    /*
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    _urlimgview.image = image;
     */
    
    // run on a background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            self.urlimgview.image = [UIImage imageWithData:imageData];
        });
    });
    
}
- (void)dealloc {
    [_urlimgview release];
    [super dealloc];
}
@end
