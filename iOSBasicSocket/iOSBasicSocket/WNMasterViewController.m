//
//  WNMasterViewController.m
//  iOSBasicSocket
//
//  Created by Wonhyo Yi on 2014. 8. 21..
//  Copyright (c) 2014년 Woonohyo. All rights reserved.
//

#import "WNMasterViewController.h"
#import "WNDetailViewController.h"
#import "NSNumber+Network.h"

#define SERVER_PATH @"127.0.0.1:7000"

@interface WNMasterViewController () <NSStreamDelegate> {
    NSMutableArray *_objects;
    NSInputStream *iStream;
    NSMutableData *_data;
    NSNumber *bytesRead;
}
@end

@implementation WNMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiReceived:) name:nil object:self];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    [self setUpStreamForURL:SERVER_PATH];
    
    //[_objects insertObject:_data atIndex:0];
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)setUpStreamForURL:(NSString *)path {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"127.0.0.1", 7000, &readStream, &writeStream);
    
    // iStream is NSInputStream instance variable
    iStream = (__bridge NSInputStream *)(readStream);
    [iStream setDelegate:self];
    [iStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                       forMode:NSDefaultRunLoopMode];
    [iStream open];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    switch(eventCode) {
        case NSStreamEventHasBytesAvailable:
        {
            if(!_data) {
                _data = [NSMutableData data];
            }
            uint8_t buf[1024];
            unsigned int len = 0;
            len = [(NSInputStream *)iStream read:buf maxLength:1024];
            if(len) {
                [_data appendBytes:(const void *)buf length:len];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"dataReceived" object:self];
                // bytesRead is an instance variable of type NSNumber.
                //[bytesRead setIntValue:[bytesRead intValue]+len];
                //bytesRead = [bytesRead initWithInt:[bytesRead intValue]+len];
                NSTimeInterval time = atol((const char*)buf);
                [_objects insertObject:[NSDate dateWithTimeIntervalSince1970:time] atIndex:0];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            } else {
                NSLog(@"no buffer!");
                
            }
            break;
        }
            
        case NSStreamEventEndEncountered:
        {
            [iStream close];
            [iStream removeFromRunLoop:[NSRunLoop currentRunLoop]
                               forMode:NSDefaultRunLoopMode];
            
            iStream = nil; // stream is ivar, so reinit it
            break;
        }
        
        case NSStreamEventNone:
        {
            
        }
            
        case NSStreamEventErrorOccurred:
        {
            NSError *theError = [iStream streamError];
            NSLog(@"%@", theError);
            
            [iStream close];
            break;
            
        }
            
        case NSStreamEventHasSpaceAvailable:
        {
            
        }
            
        case NSStreamEventOpenCompleted:
        {
            
        }
    }
}

- (void)notiReceived:(NSNotification*)noti {
}

#pragma mark - Table View
    
    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return 1;
    }
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return _objects.count;
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
        NSDate *object = _objects[indexPath.row];
        cell.textLabel.text = [object description];
        return cell;
    }
    
    - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
    {
        // Return NO if you do not want the specified item to be editable.
        return YES;
    }
    
    - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
    {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [_objects removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else if (editingStyle == UITableViewCellEditingStyleInsert) {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    /*
     // Override to support rearranging the table view.
     - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
     {
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
     {
     // Return NO if you do not want the item to be re-orderable.
     return YES;
     }
     */
    
    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
    {
        if ([[segue identifier] isEqualToString:@"showDetail"]) {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NSDate *object = _objects[indexPath.row];
            [[segue destinationViewController] setDetailItem:object];
        }
    }
    
    @end
