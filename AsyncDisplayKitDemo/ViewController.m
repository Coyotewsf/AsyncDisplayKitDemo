//
//  ViewController.m
//  AsyncDisplayKitDemo
//
//  Created by 海玩 on 16/5/11.
//  Copyright © 2016年 haiwan. All rights reserved.
//

#import "ViewController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface ViewController ()<ASTableDataSource,ASTableDelegate>

@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, copy) NSArray *imageCategories;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imageCategories = @[@"abstract", @"animals", @"business", @"cats", @"city", @"food", @"nightlife", @"fashion", @"people", @"nature", @"sports", @"technics", @"transport"];
    
    _tableNode = [[ASTableNode alloc] initWithStyle:0];
    _tableNode.frame = self.view.bounds;
    _tableNode.delegate = self;
    _tableNode.dataSource = self;
    [self.view addSubview:_tableNode.view];
    
}

- (void)test {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        ASTextNode *node = [[ASTextNode alloc] init];
        node.attributedString = [[NSAttributedString alloc] initWithString:@"hello!"
                                                                attributes:nil];
        [node measure:CGSizeMake([UIScreen mainScreen].bounds.size.width, FLT_MAX)];
        node.frame = (CGRect){ CGPointZero, node.calculatedSize };
        NSLog(@"--------%@",[NSThread currentThread]);
        // self.view isn't a node, so we can only use it on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:node.view];
            NSLog(@"%@--------",[NSThread currentThread]);
        });
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageCategories.count;
}

- (ASCellNodeBlock)tableView:(ASTableView *)tableView nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageCategory = self.imageCategories[indexPath.row];
    return ^{
        ASTextCellNode *textCellNode = [ASTextCellNode new];
        textCellNode.text = [imageCategory capitalizedString];
        return textCellNode;
    };
}


//- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *imageCategory = self.imageCategories[indexPath.row];
//    ASTextCellNode *textCellNode = [ASTextCellNode new];
//    textCellNode.text = [imageCategory capitalizedString];
//    return textCellNode;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
