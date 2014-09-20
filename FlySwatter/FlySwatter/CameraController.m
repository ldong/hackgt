//
//  ViewController.m
//  FlySwatter
//
//  Created by Lin Dong on 9/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

#import "CameraController.h"
#import "ImageController.h"


@interface CameraController ()

@end

@implementation CameraController
@synthesize imagePicker;

- (void) viewLoad {


}

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
    
//    [self presentModalViewController:imagePicker animated:YES];
  [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

//    ImageController *ic = [[ImageController alloc]init];
//    [ic setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
  
    // logics go here
//    Tesseract* tesseract = [[Tesseract alloc] initWithLanguage:@"eng"];
//    tesseract.delegate = self;
  
//    [tesseract setVariableValue:@"0123456789" forKey:@"tessedit_char_whitelist"]; //limit search
//    [tesseract setImage:[info objectForKey:UIImagePickerControllerOriginalImage]]; //image to check
//    [tesseract setRect:CGRectMake(20, 20, 100, 100)]; //optional: set the rectangle to recognize text in the image
//    [tesseract recognize];
  
    Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
    [tesseract setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    [tesseract recognize];
  
    NSLog(@"%@", [tesseract recognizedText]);
  
    NSLog(@"Parsed text: %@", [tesseract recognizedText]);
//
//    tesseract = nil; //deallocate and free all memory
  
    // end
  
    NSLog(@"test1");
    // dict
//    [self dismissModalViewControllerAnimated:YES];
//  [self dismissViewControllerAnimated:YES completion:nil];

  
//    [self presentModalViewController:ic animated:YES];
//  [self presentViewController:ic animated:YES completion:nil];
//  [self performSegueWithIdentifier:@"ImageControllerSegue" sender:self];
  
  ImageController *newController = [[self storyboard] instantiateViewControllerWithIdentifier:@"ImageControllerID"];
  [newController setImage: [info objectForKey:UIImagePickerControllerOriginalImage]];
  //[self showViewController:newController sender:self];
  [self dismissViewControllerAnimated:YES completion:nil];
  [[self captureButton] setHidden:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [self dismissModalViewControllerAnimated:YES];
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
