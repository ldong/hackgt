//
//  ViewController.m
//  FlySwatter
//
//  Created by Lin Dong on 9/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

#import "CameraController.h"

@interface CameraController ()

@end

@implementation CameraController
@synthesize myImage, imagePicker;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (IBAction)pickImage:(id)sender {
    imagePicker = [[UIImagePickerController alloc]init];
    
    //Set the delegate
    imagePicker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentModalViewController:imagePicker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    myImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissModalViewControllerAnimated:YES];
}
@end
