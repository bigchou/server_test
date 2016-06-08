//
//  ViewController.m
//  server_test
//
//  Created by Timmy on 2016/5/26.
//  Copyright © 2016年 sfdfsddsdf. All rights reserved.
//

#import "ViewController.h"
#import "MongoLabSDK.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *ID_Number;
@property (strong, nonatomic) IBOutlet UILabel *City;
@property (strong, nonatomic) IBOutlet UILabel *State;
@property (strong, nonatomic) IBOutlet UILabel *Population;
@property (strong, nonatomic) IBOutlet UILabel *Location;
@property (retain, nonatomic) IBOutlet UITextField *inputTextField;
@property (retain, nonatomic) IBOutlet UITextField *inputidfield;
@property (retain, nonatomic) IBOutlet UITextField *inputcityfield;
@property (retain, nonatomic) IBOutlet UITextField *inputstatefield;
@property (retain, nonatomic) IBOutlet UITextField *inputpopulationfield;

- (IBAction)GetData:(UIButton *)sender;
- (IBAction)SendData:(UIButton *)sender;

@end

@implementation ViewController


// Setup your API Key from the mongolab.com portal

//TODO - Enter your Mongolab API Key
#define MY_APIKEY @"v0KbZnCTNV1mUIziflTd2i932GHY2uAd"

//TODO - Enter database name - you can have multiple databases being used
#define MY_DATABASE @"tpiti_wallet"

//TODO - Enter collection name for tests
#define MY_COLLECTION @"zips"
#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[MongoLabSDK sharedInstance] setupSDKWithKey:MY_APIKEY];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)GetData:(UIButton *)sender {
    
    NSString *q = self.inputTextField.text;
    q = [NSString stringWithFormat:@"{\"_id\":\"%@\"}", q];
    NSLog(@"%@",q);
    
    
    
    //NSString *q = @"{\"_id\":\"67423\"}";
    
    NSArray *resultList = [[MongoLabSDK sharedInstance] getCollectionItemList:MY_DATABASE collectionName:MY_COLLECTION query:q];
    
    NSLog(@"%@",resultList);
    if (resultList == nil || [resultList count] == 0) {
        NSLog(@"empty!");
        NSString *errormsg = @"id not exists";
        self.City.text = errormsg;
        self.State.text = errormsg;
        self.Population.text = errormsg;
        self.ID_Number.text = errormsg;
        self.Location.text = errormsg;
        
        return;
    }
    //NSLog(@"%@",q);
    
    
    
    
    
    
    
    
    /*for (NSObject *item in resultList) {
        NSLog(@"%@", item);
    }*/
    //NSLog(@"%d",resultList.count);
    
    
    
    /*NSEnumerator *f=[resultList objectEnumerator];//将字典中所有的值到一个NSEnumerator对象中
    id i;
    while (i=[f nextObject]) {
        NSLog(@"%@",i);
    }*/
    
    
    
    /*
    for (int i=0 ; i<[resultList count] ; i++) {
        NSString *city = [[resultList objectAtIndex:i]objectForKey:@"city"];
        NSLog(@"%@",city);
    }*/
    
    /*
    int random_number = arc4random() % resultList.count;
    NSString *city = [[resultList objectAtIndex: random_number ]objectForKey:@"city"];
    NSString *state = [[resultList objectAtIndex: random_number ]objectForKey:@"state"];
    
    NSNumber *pop =[[resultList objectAtIndex: random_number ]objectForKey:@"pop"];
    NSString *idnum =[[resultList objectAtIndex: random_number ]objectForKey:@"_id"];
    
    NSArray * location = [[resultList objectAtIndex: random_number ]objectForKey:@"loc"];
    NSNumber *lat =[location objectAtIndex: 0 ];
    NSNumber *lng =[location objectAtIndex: 1 ];
    NSString *loc = [NSString stringWithFormat:@"lat:%@lng:%@", lat, lng];
    NSLog(@"%@",loc);*/
    //NSLog(@"%@",lat);
    //NSLog(@"%@",lng);
    //NSLog(@"%@",idnum);
    //NSLog(@"%@",pop);
    //NSLog(@"%@",state);
    //NSLog(@"%@",city);
    
    /*
    self.City.text = city;
    self.State.text = state;
    self.Population.text = [pop stringValue];
    self.ID_Number.text = idnum;
    self.Location.text = loc;*/
    
    
    
    
    // =============================
    
    NSString *city = [[resultList objectAtIndex: 0 ]objectForKey:@"city"];
    NSString *state = [[resultList objectAtIndex: 0 ]objectForKey:@"state"];
    
    NSNumber *pop =[[resultList objectAtIndex: 0 ]objectForKey:@"pop"];
    NSString *idnum =[[resultList objectAtIndex: 0 ]objectForKey:@"_id"];
    NSArray * location = [[resultList objectAtIndex: 0 ]objectForKey:@"loc"];
    NSNumber *lat =[location objectAtIndex: 0 ];
    NSNumber *lng =[location objectAtIndex: 1 ];
    NSString *loc = [NSString stringWithFormat:@"lat:%@lng:%@", lat, lng];
    
    NSLog(@"%@",loc);
    NSLog(@"%@",lat);
    NSLog(@"%@",lng);
    NSLog(@"%@",idnum);
    NSLog(@"%@",pop);
    NSLog(@"%@",state);
    NSLog(@"%@",city);
    
    self.City.text = city;
    self.State.text = state;
    self.Population.text = [pop stringValue];
    self.ID_Number.text = idnum;
    self.Location.text = loc;
    
    
    
    
}

- (IBAction)SendData:(UIButton *)sender {
    NSMutableDictionary *item = [NSMutableDictionary dictionary];
    NSMutableArray *loc = [NSMutableArray array];
    [loc addObject:[NSNumber numberWithFloat: arc4random() ]];
    [loc addObject:[NSNumber numberWithFloat: arc4random() ]];
    /*
    [item setValue:[NSNumber numberWithFloat:2300] forKey:@"pop"];
    [item setValue:loc forKey:@"loc"];
    [item setValue:@"TW" forKey:@"state"];
    [item setValue:@"886" forKey:@"_id"];
    [item setValue:@"Taiwan" forKey:@"city"];
    */
    NSString *id = self.inputidfield.text;
    NSString *city = self.inputcityfield.text;
    NSString *state = self.inputstatefield.text;
    int population = [self.inputpopulationfield.text intValue];
    
    [item setValue:[NSNumber numberWithFloat:population] forKey:@"pop"];
    [item setValue:loc forKey:@"loc"];
    [item setValue:state forKey:@"state"];
    [item setValue:id forKey:@"_id"];
    [item setValue:city forKey:@"city"];
    
    
    
    
    NSLog(@"%@",item);
    NSDictionary *resultList = [[MongoLabSDK sharedInstance] insertCollectionItem:MY_DATABASE collectionName:MY_COLLECTION item:item];
    
    /*NSDictionary *itemIdDictionary = [resultList valueForKey:@"_id"];
    NSString *itemId = [itemIdDictionary valueForKey:@"$oid"];
    
    NSLog(@"insert itemId=%@", itemId);*/
}
- (void)dealloc {
    [_inputTextField release];
    [_inputidfield release];
    [_inputcityfield release];
    [_inputstatefield release];
    [_inputpopulationfield release];
    [super dealloc];
}


@end
