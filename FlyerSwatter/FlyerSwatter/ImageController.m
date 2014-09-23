//
//  ImageController.m
//  FlySwatter
//
//  Created by Lin Dong on 9/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

#import "ImageController.h"

@interface ImageController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageController
// making getters and setters
@synthesize image, imageView;

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [imageView setImage:image];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//  
//  self.imagePicker = [[UIImagePickerController alloc]init];
//  
//  //Set the delegate
//  self.imagePicker.delegate = self;
//  
//  if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//  }else{
//    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//  }
//  
//  //    [self presentModalViewController:imagePicker animated:YES];
//  [self presentViewController:self.imagePicker animated:YES completion:nil];
//
//}
//
//- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//  self.image = info[UIImagePickerControllerOriginalImage];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
