//
//  ViewController.h
//  FlySwatter
//
//  Created by Lin Dong on 9/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TesseractOCR/TesseractOCR.h>

@interface CameraController : UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate, TesseractDelegate>
@property (weak, nonatomic) IBOutlet UITextView *infoData;
@property (weak, nonatomic) IBOutlet UIButton *accept;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIButton *captureButton;
@property (strong, nonatomic) UIImagePickerController * imagePicker;

- (IBAction)pickImage:(id)sender;
- (IBAction)cancelImage:(id)sender;
- (UIImage *)convertImageToGrayScale:(UIImage *)image;

@end

