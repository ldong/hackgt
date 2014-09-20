//
//  ViewController.m
//  FlySwatter
//
//  Created by Lin Dong on 9/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

#import "CameraController.h"
#import "UIImage+Filters.h"
//#import "ImageFilter.h"

@interface CameraController ()

@end

@implementation CameraController
@synthesize imagePicker, infoData, accept, captureButton, cancelButton;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  accept.hidden = true;
  infoData.hidden = true;
  cancelButton.hidden = true;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (IBAction)pickImage:(id)sender {
  imagePicker = [[UIImagePickerController alloc]init];
  
  //Set the delegate
  imagePicker.delegate = self;
  
  //  if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
  //    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
  //  }else{
  imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  //  }
  
  [self presentModalViewController:imagePicker animated:YES];
}

- (IBAction)cancelImage:(id)sender {
  accept.hidden = true;
  cancelButton.hidden = true;
  infoData.hidden = true;
  captureButton.hidden = false;
}
- (UIImage *)convertImageToGrayScale:(UIImage *)image
{
  // Create image rectangle with current image width/height
  CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
  
  // Grayscale color space
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
  
  // Create bitmap content with current image size and grayscale colorspace
  CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
  
  // Draw image into current context, with specified rectangle
  // using previously defined context (with grayscale colorspace)
  CGContextDrawImage(context, imageRect, [image CGImage]);
  
  // Create bitmap image info from pixel data in current context
  CGImageRef imageRef = CGBitmapContextCreateImage(context);
  
  // Create a new UIImage object
  UIImage *newImage = [UIImage imageWithCGImage:imageRef];
  
  // Release colorspace, context and bitmap information
  CGColorSpaceRelease(colorSpace);
  CGContextRelease(context);
  CFRelease(imageRef);
  
  // Return the new grayscale image
  return newImage;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  //  CIImage *ciImage = image.CIImage;
  //  CIFilter *filter = [CIFilter filterWithName:@"CINoiseReduction"];
  //  [filter setDefaults];
  //  [filter setValue:ciImage forKey:kCIInputImageKey];
  //  CIImage *displayImage = filter.outputImage;
  //  UIImage *finalImage = [UIImage imageWithCIImage:displayImage];
  //  image = finalImage;
  //
  //  filter = [CIFilter filterWithName:@"CIMaximumComponent"];
  //  [filter setDefaults];
  //  [filter setValue:ciImage forKey:kCIInputImageKey];
  //  displayImage = filter.outputImage;
  //  finalImage = [UIImage imageWithCIImage:displayImage];
  //  image = finalImage;
  
  // Load image from library
  UIImage* myImage = [info objectForKey:UIImagePickerControllerOriginalImage];

  CIImage *_inputImage = [CIImage imageWithCGImage:[myImage CGImage]];
  CIFilter *monoEffectFilter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
  [monoEffectFilter setValue:_inputImage forKey:kCIInputImageKey];

  UIImage *resultUIImage = [UIImage imageWithCIImage:monoEffectFilter.outputImage];

  UIImageWriteToSavedPhotosAlbum(resultUIImage, nil, nil, nil);

  
  Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
  //  [tesseract setImage:[[info objectForKey:UIImagePickerControllerOriginalImage] grayScale]];
  [tesseract setImage:resultUIImage ];
  //[tesseract setImage:[resultUIImage blackAndWhite]];
  [tesseract recognize];
  
  NSLog(@"%@", [tesseract recognizedText]);
  
  NSLog(@"Parsed text: %@", [tesseract recognizedText]);
  
  [self dismissModalViewControllerAnimated:YES];
  infoData.text = [tesseract recognizedText];
  captureButton.hidden = true;
  accept.hidden = false;
  infoData.hidden = false;
  cancelButton.hidden = false;
  
  //  UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    UIImageWriteToSavedPhotosAlbum(myImage, nil, nil, nil);
  });
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
  [self dismissModalViewControllerAnimated:YES];
}
@end