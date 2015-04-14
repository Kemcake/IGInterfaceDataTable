//
//  ThreeInterfaceController.m
//  Sample
//
//  Created by Remi Santos on 14/04/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "ThreeInterfaceController.h"
#import "WKInterfaceTable+IGInterfaceDataTable.h"

#import "RowController.h"
#import "SectionRowController.h"


@interface ThreeInterfaceController () <IGInterfaceTableDataSource>

@property (weak, nonatomic) IBOutlet WKInterfaceTable *table;
@property (nonatomic, strong) NSArray *data;

@end

@implementation ThreeInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.data = [self.class todoList];
    
    //  [self enableTableSelectCallbacks];
    self.table.ig_dataSource = self;
    [self.table reloadData];
}

+ (NSArray *)todoList {
    return @[
             @{
                 @"title": @"Urgent",
                 @"items": @[@"Take out trash",
                             @"Clean room",
                             @"Finish paper"]
                 },
             @{
                 @"title": @"Todo",
                 @"items": @[@"Ship package",
                             @"Pay bills",
                             @"Call Mom"]
                 },
             @{
                 @"title": @"Upcoming",
                 @"items": @[@"Napa Weekend",
                             @"Valentine's Day"]
                 }
             ];
}

+ (NSDictionary *)singleAdd {
    return @{
             @"title": @"Added",
             @"items": @[@"New Item", @"New Item"]
             };
}


#pragma mark - Row Selection

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushControllerWithName:@"InterfaceController" context:nil];
    NSLog(@"Tapped row %@",indexPath);
}

- (void)table:(WKInterfaceTable *)table didSelectSection:(NSInteger)section {
    NSLog(@"Section %zi tapped",section);
}

- (void)tableDidSelectHeader:(WKInterfaceTable *)table {
    NSLog(@"Header tapped");
}

- (void)tableDidSelectFooter:(WKInterfaceTable *)table {
    NSLog(@"Footer tapped");
}


#pragma mark - RNInterfaceTableDataSource

- (NSInteger)numberOfSectionsInTable:(WKInterfaceTable *)table {
    return self.data.count;
}

- (NSInteger)numberOfRowsInTable:(WKInterfaceTable *)table section:(NSInteger)section {
    return [self.data[section][@"items"] count];
}

- (NSString *)headerIdentifierForTable:(WKInterfaceTable *)table {
    return @"HeaderRow";
}

- (NSString *)footerIdentifierForTable:(WKInterfaceTable *)table {
    return @"Footer";
}

- (NSString *)table:(WKInterfaceTable *)table identifierForSection:(NSInteger)section {
    return @"SectionRow";
}

- (NSString *)table:(WKInterfaceTable *)table rowIdentifierAtIndexPath:(NSIndexPath *)indexPath {
    return @"Row";
}

- (void)table:(WKInterfaceTable *)table configureSectionController:(NSObject *)sectionRowController forSection:(NSInteger)section {
    NSDictionary *sectionItem = self.data[section];
    NSString *title = sectionItem[@"title"];
    SectionRowController *controller = (SectionRowController *)sectionRowController;
    [controller.textLabel setText:title];
    [controller.imageView setImageNamed:[title lowercaseString]];
}

- (void)table:(WKInterfaceTable *)table configureRowController:(NSObject *)rowController forIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *sectionItem = self.data[indexPath.section];
    NSString *item = sectionItem[@"items"][indexPath.row];
    RowController *controller = (RowController *)rowController;
    [controller.textLabel setText:item];
}


@end



