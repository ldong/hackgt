//
//  ViewController.h
//  FlySwatter
//
//  Created by Lin Dong on 9/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraController : UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *myImage;

@property (strong, nonatomic) UIImagePickerController * imagePicker;

- (IBAction)pickImage:(id)sender;

@end

