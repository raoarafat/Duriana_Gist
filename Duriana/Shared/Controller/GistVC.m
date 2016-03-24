//
//  GistVC.m
//  Duriana
//
//  Created by Arafat on 22/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//

#import "GistVC.h"
#import "GistCell.h"
#import "Gist.h"
#import "APIManager.h"
#import "ProgressHUD.h"


NSString *const star_image = @"star";
NSString *const un_star_image = @"un_star";

@interface GistVC ()

@property (nonatomic , strong) NSMutableArray * arrGistList;

@end

@implementation GistVC

#pragma mark - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /* Adding pull to refresh */
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tblView addSubview:refreshControl];
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    /* sync local gists */
    [self sycncing];
    
    self.arrGistList = [[NSMutableArray alloc] init];
    
    /* Get Gist list */
    [self getGist];
}

#pragma mark - helper

- (void) sycncing{
    
    /* Get Gist list which is only updated */
    NSMutableArray * gistTemp = [GistEntity getGistEntityWithStatus:[NSNumber numberWithBool:YES]];
    
    for (GistEntity * gist in gistTemp) {
        
        /* Delete block */
        if ([gist.is_Deleted boolValue]) {
            
            [self deleteGistWithEntity:gist];
        }
        /* Star & Unstar block */
        else{
            
            [self starGistWithEntity:gist];
        }
        break;
    }
}

- (void) deleteGistWithEntity:(GistEntity *) gist{
    
    [APIManager deleteGistWithID:gist.gistID startBlock:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD show:@"Syncing..."];
        });
        
    } failedBlock:^(NSNumber *errorCode, NSString *message) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
        });
        
        /* Failed: Call again to find more updated gist */
        [self sycncing];
        
    } successBlock:^(NSString *message, NSDictionary *data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
        });
        
        /* Remove Gist from the Core data as well */
        [Gist removeEntityWithObject:gist];
        
        /* Call again to find more updated gist */
        [self sycncing];
    }];
}

- (void) starGistWithEntity:(GistEntity *) gist{
    
    [APIManager starGistWithID:gist.gistID isStart:gist.is_Star startBlock:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD show:@"Syncing..."];
        });
        
    } failedBlock:^(NSNumber *errorCode, NSString *message) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
        });
        
        NSLog(@"%@",message);
        /* Call again to find more updated gist */
        [self sycncing];
    } successBlock:^(NSString *message, NSDictionary *data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
        });
        
        NSLog(@"%@",message);
    }];
}


- (void) getGist{
    
    [APIManager getGist:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD show:@"Syncing..."];
        });
        
    } failedBlock:^(NSNumber *errorCode, NSString *message) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /* Show offline gist if any. */
            [self showGist];
            
        });
        
    } successBlock:^(NSString *message, NSDictionary *data) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
        });
        
        for (NSDictionary * object in data) {
            
            Gist * gist = [[Gist alloc] initWithDictionary:object ];
            [self.arrGistList addObject:gist];
        }
        
        if (self.arrGistList.count > 0) {
            [Gist createGistWithArray:self.arrGistList];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
        /* show updated gist */
        [self showGist];
    }];
}

- (void) showGist{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.arrGistList = [Gist getGistEntityWithDeleted:[NSNumber numberWithBool:NO]];
        if (self.arrGistList.count > 0) {
            [self.tblView reloadData];
        }
    });
}


#pragma mark - action

-(void)refresh:(UIRefreshControl *)refreshControl{
    
    [refreshControl endRefreshing];
    
    /* Sync & Update Gist */
    [self getGist];
}


#pragma mark - UITableViewDelegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    /* Return the number of sections. */
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /* Return the number of rows in the section. */
    return self.arrGistList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* Specify Custom ImagesTableViewCell here */
    NSString * CellIdentifier = @"GistCell";
    
    GistCell * cell = (GistCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GistCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        Gist * gist = [self.arrGistList objectAtIndex:indexPath.row];
        
        cell.lblTitle.text = gist.name;
        
        if([gist.is_Star boolValue]){
            cell.imgView.image = [UIImage imageNamed:star_image];
        }else{
            cell.imgView.image = [UIImage imageNamed:un_star_image];
        }
    });
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    
    [self.tblView deselectRowAtIndexPath:indexPath animated:YES];
    
    GistCell *cell = (GistCell *)[self.tblView cellForRowAtIndexPath:indexPath];
    
    Gist * gist = [self.arrGistList objectAtIndex:indexPath.row];
    
    BOOL isStar = [gist.is_Star boolValue];
    
    isStar =! isStar;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        if(isStar){
            cell.imgView.image = [UIImage imageNamed:star_image];
        }else{
            cell.imgView.image = [UIImage imageNamed:un_star_image];
        }
        
    });
    
    
    gist.is_Star = [NSNumber numberWithBool:isStar];
    gist.is_Updated = [NSNumber numberWithBool:YES];
    
    /* Update gist  */
    [Gist createGistWithArray:[NSMutableArray arrayWithObjects:gist, nil]];
    
    /* Sync Gist with github */
    [self sycncing];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Gist * gist = [self.arrGistList objectAtIndex:indexPath.row];
        gist.is_Deleted = [NSNumber numberWithBool:YES];
        gist.is_Updated = [NSNumber numberWithBool:YES];
        
        /* Update gist  */
        [Gist createGistWithArray:[NSMutableArray arrayWithObjects:gist, nil]];
        
        [self.arrGistList removeObjectAtIndex:indexPath.row];
        
        /* remove specific row with animation */
        [self.tblView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        /* Sync Gist with github */
        [self sycncing];
        
        
    }
}


@end
