//
//  TYDKCitysViewController.m
//  TYDK-iOSAPPTutorial
//
//  Created by 李浩然 on 12/29/15.
//  Copyright © 2015 tydic-lhr. All rights reserved.
//

#import "TYDKCitysViewController.h"

static NSString *const SectionsTableIdentifier = @"SectionsTableIdentifier";

@interface TYDKCitysViewController () <UISearchDisplayDelegate> {
    
    NSMutableArray *filteredCitys;
    UISearchDisplayController *_searchController;
    
}

@property (copy, nonatomic) NSDictionary *citys;
@property (copy, nonatomic) NSArray *keys;

@end

@implementation TYDKCitysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"城市选择";
    [self.tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:SectionsTableIdentifier];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityData"
                                                     ofType:@"plist"];
    
    self.citys = [NSDictionary dictionaryWithContentsOfFile:path];
    self.keys  = [self.citys allKeys];


    filteredCitys = [NSMutableArray array];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    _searchController.delegate = self;
    _searchController.searchResultsDataSource = self;
    _searchController.searchResultsDelegate = self;
    self.tableView.tableHeaderView = searchBar;
    self.tableView.tag = 1;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 1) {
        return [self.keys count];
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        NSString *key = self.keys[section];
        NSArray *nameSection = self.citys[key];
        return [nameSection count];
    } else {
        return [filteredCitys count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        return self.keys[section];
    } else {
        return nil;
    }
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    NSString *key = [self.keys objectAtIndex:index];
    NSLog(@"---选择的section是%@---",key);
    if (key == UITableViewIndexSearch) {
        [tableView setContentOffset:CGPointZero animated:NO];
        return NSNotFound;
    }
    
    return index;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SectionsTableIdentifier
                                                            forIndexPath:indexPath];
    
    if (tableView.tag == 1) {
        NSString *key = self.keys[indexPath.section];
        NSArray *nameSection = self.citys[key];
        
        cell.textLabel.text = nameSection[indexPath.row];
    } else {
        cell.textLabel.text = filteredCitys[indexPath.row];
    }
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    if (tableView.tag == 1) {
        return self.keys;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 1) {
        NSString *key = self.keys[indexPath.section];
        NSArray *nameSection = self.citys[key];
        NSLog(@"---选择的cell是%@---",nameSection[indexPath.row]);

    } else {
        
        NSLog(@"---选择的cell是%@---",filteredCitys[indexPath.row]);

    }
    
    
}

#pragma mark - Search Display Delegate Methods
- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    [tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:SectionsTableIdentifier];
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [filteredCitys removeAllObjects];
    if (searchString.length > 0) {
        NSPredicate *predicate =
        [NSPredicate
         predicateWithBlock:^BOOL(NSString *name, NSDictionary *b) {
             NSRange range = [name rangeOfString:searchString
                                         options:NSCaseInsensitiveSearch];
             return range.location != NSNotFound;
         }];
        for (NSString *key in self.keys) {
            NSArray *matches = [self.citys[key]
                                filteredArrayUsingPredicate: predicate];
            [filteredCitys addObjectsFromArray:matches];
        }
    }
    return YES;
}



@end
