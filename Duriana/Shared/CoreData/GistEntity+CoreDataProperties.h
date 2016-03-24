//
//  GistEntity+CoreDataProperties.h
//  Duriana
//
//  Created by Arafat on 23/03/2016.
//  Copyright © 2016 Arafat Khan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GistEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface GistEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *gistID;
@property (nullable, nonatomic, retain) NSNumber *is_Deleted;
@property (nullable, nonatomic, retain) NSNumber *is_Star;
@property (nullable, nonatomic, retain) NSNumber *is_Updated;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
