//
//  MNTableViewController.m
//  33.4-webview在在可选项中选择加载的文件
//
//  Created by Mac on 14-10-27.
//  Copyright (c) 2014年 MN. All rights reserved.
//

#import "MNTableViewController.h"
#import "ViewController.h"

@interface MNTableViewController ()

@property(nonatomic,strong) NSBundle *fileBundle;
@property(nonatomic,strong) NSArray *files;

@end



@implementation MNTableViewController



//加载文件捆

-(NSBundle *)fileBundle{
   
    if (!_fileBundle) {
        NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"docs.bundle"];
        _fileBundle = [NSBundle bundleWithPath:path];
    }
    
    return _fileBundle;
}

//  去除文件捆里面的文件
- (NSArray *)files{

    if(!_files){
        _files = [[NSFileManager defaultManager] subpathsAtPath:self.fileBundle.bundlePath];
    }
    
    return _files;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.files.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static   NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.files[indexPath.row];
    
    return  cell;
    
}


// 点击cell后实现跳转，用的segue 跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"PUSH" sender:indexPath];
    
}

// 为跳转做准备
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(NSIndexPath *)indexPath{

    ViewController *vc = segue.destinationViewController;
    
    NSString *fileName = self.files[indexPath.row];
    
    vc.title = fileName;
    
    vc.fileURL = [self.fileBundle URLForResource:fileName withExtension:nil];
    
 }










@end
