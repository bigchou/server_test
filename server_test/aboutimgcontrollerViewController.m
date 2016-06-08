//
//  aboutimgcontrollerViewController.m
//  server_test
//
//  Created by Timmy on 2016/6/7.
//  Copyright © 2016年 sfdfsddsdf. All rights reserved.
//

#import "aboutimgcontrollerViewController.h"

@interface aboutimgcontrollerViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,NSURLConnectionDelegate>

- (IBAction)cameraandgallery:(id)sender;


@property (strong, nonatomic) IBOutlet UIImageView *myImage;
- (IBAction)sendimage:(UIButton *)sender;

@end

@implementation aboutimgcontrollerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
    }
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



- (IBAction)cameraandgallery:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                        message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    // Create the actions.
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Cancel!");
    }];
    
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:NSLocalizedString(@"拍攝", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"take a shot!");
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    
    UIAlertAction *selectGallery = [UIAlertAction actionWithTitle:NSLocalizedString(@"從相簿", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"select from gallery!");
        
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    
    // Add the actions.
    [alertController addAction:cancel];
    [alertController addAction:takePhoto];
    [alertController addAction:selectGallery];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
    
    
    // method 1 - select photo
    /*
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]
                                                 init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
     */
    
    // method 2 - select photo (best)
    /*
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    */
    
    // method 3 - take phto
    /*
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    */
    
}

// to display photo - bad
/*
- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    self.myImage.image = image;
    [self dismissModalViewControllerAnimated:YES];
}
*/



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"Image Information:\n%@",info[UIImagePickerControllerEditedImage]);
    self.myImage.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //if user cancels taking photo
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


// test
/*
- (void) imagePickerController:(UIImagePickerController *)picker
         didFinishPickingImage:(UIImage *)image
                   editingInfo:(NSDictionary *)editingInfo
{
    self.myImage.image = image;
    jpegData = UIImagePNGRepresentation(image);
    [self dismissModalViewControllerAnimated:YES];
}*/


//send
- (IBAction) sendimage:(UIButton *)sender
{
    // declare something there
    NSData *imageData = UIImageJPEGRepresentation(_myImage.image, 0.1);
    NSLog(@"Size of Image(bytes):%d",[imageData length]);
    NSString *urlString = @"http://www.csie.ntnu.edu.tw/~40347905s/uploads.php";
    NSString *imageName = @"test";
    
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [[NSString alloc]init];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"test.png\"rn" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: application/%@.jpg\r\n\r\n",imageName] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    //Using Synchronous Request. You can also use asynchronous connection and get update in delegates
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"--------%@",returnString);
}





    
    











- (void)dealloc {
    [_myImage release];
    [super dealloc];
}

@end
