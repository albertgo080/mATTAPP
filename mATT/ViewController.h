//
//  ViewController.h
//  mATT
//
//  Created by Albert Go on 10/15/19.
//  Copyright © 2019 Albert Go. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "RBManager.h"
#import "RBPublisher.h"
#import "RBSubscriber.h"
#import "IntMessage.h"
#import "StringMessage.h"

@interface ViewController : UIViewController{
    RBPublisher *calibration;
    RBPublisher *begin;
    RBSubscriber *forcesNew;
    RBSubscriber *feedback;
    RBSubscriber *instructions;
    IntMessage * int_msg;
    StringMessage * string_msg;
}

@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *connectClick;
@property (weak, nonatomic) IBOutlet UIButton *calibratePressed;
- (IBAction)connectClick:(id)sender;

- (IBAction)calibratePressed:(id)sender;

-(IBAction)beginPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *leftHeel;
@property (weak, nonatomic) IBOutlet UILabel *innerLeft;
@property (weak, nonatomic) IBOutlet UILabel *outerLeft;

@property (weak, nonatomic) IBOutlet UILabel *rightHeel;
@property (weak, nonatomic) IBOutlet UILabel *innerRight;
@property (weak, nonatomic) IBOutlet UILabel *outerRight;

@property (weak, nonatomic) IBOutlet UILabel *feedback_connect;

@property(weak, nonatomic) IBOutlet UILabel *instructions_connect;

@end

