//
//  GistEntity.m
//  Duriana
//
//  Created by Arafat on 23/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//

#import "GistEntity.h"
#import "CoreDataManager.h"

@implementation GistEntity

#pragma mark - Commiting Data

+ (void)commit {
    // Only persist the context if there were actual changes.
    if ([[CoreDataManager sharedInstance].managedObjectContext hasChanges]){
        // Save the changes
        NSError *error;
        if (![[CoreDataManager sharedInstance].managedObjectContext save:&error]) {
            
        }
    }
}

#pragma mark - Fetching

+ (NSMutableArray *) getGistEntity {
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GistEntity" inManagedObjectContext:[CoreDataManager sharedInstance].managedObjectContext];
    
    // NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sku == %@  ", sku];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    //[request setPredicate:predicate];
    [request setIncludesSubentities:NO];
    
    // Set the sort descriptor
    NSSortDescriptor *creationDateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:creationDateDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSMutableArray *fetchResults =(NSMutableArray*) [[CoreDataManager sharedInstance].managedObjectContext executeFetchRequest:request error:&error];
    
    
    return [fetchResults mutableCopy];
}

+ (NSMutableArray*) getGistEntityWithDeleted:(NSNumber *) deleted{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GistEntity" inManagedObjectContext:[CoreDataManager sharedInstance].managedObjectContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"is_Deleted == %@  ", deleted];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:predicate];
    [request setIncludesSubentities:NO];
    
    // Set the sort descriptor
    NSSortDescriptor *creationDateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:creationDateDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSMutableArray *fetchResults =(NSMutableArray*) [[CoreDataManager sharedInstance].managedObjectContext executeFetchRequest:request error:&error];
    
    
    return [fetchResults mutableCopy];
}

+ (NSMutableArray*) getGistEntityWithID:(NSString *) gistID{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GistEntity" inManagedObjectContext:[CoreDataManager sharedInstance].managedObjectContext];
    
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"gistID == %@  ", gistID];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:predicate];
    [request setIncludesSubentities:NO];
    
    // Set the sort descriptor
    NSSortDescriptor *creationDateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:creationDateDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSMutableArray *fetchResults =(NSMutableArray*) [[CoreDataManager sharedInstance].managedObjectContext executeFetchRequest:request error:&error];
    
    
    return [fetchResults mutableCopy];
}

+ (NSMutableArray*) getGistEntityWithStatus:(NSNumber *) updated{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GistEntity" inManagedObjectContext:[CoreDataManager sharedInstance].managedObjectContext];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"is_Updated == %@  ", updated];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setPredicate:predicate];
    [request setIncludesSubentities:NO];
    
    // Set the sort descriptor
    NSSortDescriptor *creationDateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:creationDateDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSMutableArray *fetchResults =(NSMutableArray*) [[CoreDataManager sharedInstance].managedObjectContext executeFetchRequest:request error:&error];
    
    
    return [fetchResults mutableCopy];
}

#pragma mark - Create, Insert & Update

+ (void) createGistWithArray:(NSMutableArray *) gistEntities{
    
    NSMutableArray * getGistEntities = [self getGistEntity];
    
    if (getGistEntities.count <= 0) {
        
        /* Insert all records */
        for (Gist * gist in gistEntities) {
            
            [self insertGistEntity:gist];
        }
        
    }else{
        /* Insert only updated records */
        
        for (Gist * gist in gistEntities) {
            
            NSMutableArray * gistEntitiesArray = [self getGistEntityWithID:gist.gistID];
            
            /* Directly insert if doesn't exists in db */
            if (gistEntitiesArray.count <= 0) {
                [self insertGistEntity:gist];
            }else{
                
                /* Only updates */
                GistEntity * entity = [gistEntitiesArray objectAtIndex:0];
                [self updateGistEntity:entity gistEntity:gist];
            }
        }
    }
}



+ (void)insertGistEntity:(Gist *) gist{
    
    GistEntity * entity = (GistEntity*) [NSEntityDescription
                                           insertNewObjectForEntityForName:@"GistEntity" inManagedObjectContext:[CoreDataManager sharedInstance].managedObjectContext];
    [self updateGistEntity:entity gistEntity:gist];
}

+ (void)  updateGistEntity:(GistEntity *) gistEntity gistEntity:(Gist *) gist{
    if (gistEntity == nil || gist == nil) return;
    
    gistEntity.gistID = gist.gistID;
    gistEntity.is_Deleted = gist.is_Deleted;
    gistEntity.is_Star = gist.is_Star;
    gistEntity.is_Updated = gist.is_Updated;
    gistEntity.name = gist.name;
    gistEntity.desc = gist.desc;

    
    [self commit];
}

#pragma mark - Delete

+ (void) emptyEntity{
    
    NSArray * stockEntities = [self getGistEntity];
    //error handling goes here
    for (GistEntity * stock in stockEntities) {
        [[CoreDataManager sharedInstance].managedObjectContext deleteObject:stock];
    }
    [self commit];
    
}

+ (void) removeEntityWithObject:(GistEntity *)gistEntity{
    
    
    [[CoreDataManager sharedInstance].managedObjectContext deleteObject:gistEntity];
    [self commit];
    
}

@end
