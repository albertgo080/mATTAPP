//
//  ViewController.m
//  mATT
//
//  Created by Albert Go on 10/15/19.
//  Copyright © 2019 Albert Go. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSString *leftHeel;
NSString *innerLeft;
NSString *outerLeft;

NSString *rightHeel;
NSString *innerRight;
NSString *outerRight;

bool connected;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    calibration = [[RBManager defaultManager]
                 addPublisher:@"calibration" messageType:@"std_msgs/String"];
    begin = [[RBManager defaultManager]
                   addPublisher:@"begin" messageType:@"std_msgs/String"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectClick:(id)sender {
    
    if (connected)
    {
        NSLog(@"Disconnecting...");
        [[RBManager defaultManager] disconnect];
        connected = false;
        [_connectButton setTitle:@"Connect" forState:UIControlStateNormal];
        
    }
    
    else{
        NSLog(@"Connecting...");
        [[RBManager defaultManager] connect:@"ws://18.20.136.50:9090"];
        connected = true;
        [_connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];
        
        forcesNew = [[RBManager defaultManager] addSubscriber:@"/forcesNew" responseTarget:self selector:@selector(forceDistribution:) messageClass:[StringMessage class]];
        
        feedback = [[RBManager defaultManager] addSubscriber:@"/feedback" responseTarget:self selector:@selector(giveFeedback:) messageClass:[StringMessage class]];
        
        instructions = [[RBManager defaultManager] addSubscriber:@"/instructions" responseTarget:self selector:@selector(giveInstructions:) messageClass:[StringMessage class]];
        
    }
}

-(void)sendData:(NSString*)msg{
    
    if (connected){
        StringMessage *message = [[StringMessage alloc] init];
        
        message.data = msg;
        
        [calibration publish:message];
    }
    
}

-(void)sendBegin:(NSString*)msg{
    
    if (connected){
        StringMessage *message = [[StringMessage alloc] init];
        
        message.data = msg;
        
        [begin publish:message];
    }
    
}

- (IBAction)calibratePressed:(id)sender {
    NSLog(@"Here");
    NSString *message = [NSString  stringWithFormat:@"yes"];
    [self sendData:message];
}

- (IBAction)beginPressed:(id)sender{
    NSLog(@"Here2");
    NSString *message = [NSString  stringWithFormat:@"yes"];
    [self sendBegin:message];
}


-(void)forceDistribution:(StringMessage*)message {
    // read the message and update the view here
    //NSLog(@"Read some data - %lu",(unsigned long)message.data);
    NSString *string = message.data;
    //NSUInteger length = [string length];
    //NSLog(@"Here, %tu", length);
    NSArray *components = [string componentsSeparatedByString: @","];
//    NSLog(@"List: %@", components);
    
    NSString *leftHeel = [components objectAtIndex:0];
    _leftHeel.text = [NSString stringWithFormat:@"Left Heel: %@", leftHeel];
    
    NSString *innerLeft = [components objectAtIndex:1];
    _innerLeft.text = [NSString stringWithFormat:@"Inner Left: %@", innerLeft];
    
    NSString *outerLeft = [components objectAtIndex:2];
    _outerLeft.text = [NSString stringWithFormat:@"Outer Left: %@", outerLeft];
    
    NSString *rightHeel = [components objectAtIndex:3];
    _rightHeel.text = [NSString stringWithFormat:@"Right Heel: %@", rightHeel];
    
    NSString *innerRight = [components objectAtIndex:4];
    _innerRight.text = [NSString stringWithFormat:@"Inner Right: %@", innerRight];

    NSString *outerRight = [components objectAtIndex:5];
    _outerRight.text = [NSString stringWithFormat:@"Outer Right: %@", outerRight];

}

-(void)giveFeedback:(StringMessage*)message {
    // read the message and update the view here
    //NSLog(@"Read some data - %lu",(unsigned long)message.data);
    NSString *string = message.data;
    //NSUInteger length = [string length];
    //NSLog(@"Here, %tu", length);

    NSString *feedback_connect = string;
    _feedback_connect.text = [NSString stringWithFormat:@"Feedback: %@", feedback_connect];
    
}

-(void)giveInstructions:(StringMessage*)message{
    NSString *string = message.data;
    
    NSString *instructions_connect = string;
    _instructions_connect.text = [NSString stringWithFormat:@"Instructions: %@", instructions_connect];
}

@end
