//
//  Gist.m
//  Duriana
//
//  Created by Arafat on 23/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//

#import "Gist.h"
#import "GistEntity.h"

@implementation Gist

#pragma mark - Init

- (id)initWithDictionary:(NSDictionary*)_object
{
    self = [super init];
    if (self) {
        
        
        self.name= [_object valueForKey:@"description"];
        self.desc = [_object valueForKey:@"description"];
        self.gistID = [_object valueForKey:@"id"];
        self.is_Deleted= [NSNumber numberWithBool:NO];
        self.is_Star = [NSNumber numberWithBool:NO];
        self.is_Updated = [NSNumber numberWithBool:NO];
        
    }
    return self;
    
}


#pragma mark - Fetch
+ (NSMutableArray*) getGistEntity{
    return [GistEntity getGistEntity];
}
+ (NSMutableArray*) getGistEntityWithDeleted:(NSNumber *) deleted{
    
    return [GistEntity getGistEntityWithDeleted:deleted];
}
+ (NSMutableArray*) getGistEntityWithStatus:(NSNumber *) updated{
    return [GistEntity getGistEntityWithStatus:updated];
}
+ (NSMutableArray*) getGistEntityWithID:(NSString *) gistID{
    return [GistEntity getGistEntityWithID:gistID];
}

#pragma mark - Insert
+ (void) createGistWithArray:(NSMutableArray *) gistEntities{
    
    return [GistEntity createGistWithArray:gistEntities];
}

#pragma mark - Remove
+ (void) emptyEntity{
    
    return [GistEntity emptyEntity];
}
+ (void) removeEntityWithObject:(GistEntity *) gistEntity{
    
    return [GistEntity removeEntityWithObject:gistEntity];
}



@end
