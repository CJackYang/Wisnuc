//
//  AssetsServices.m
//  WisnucBox
//
//  Created by JackYang on 2017/11/3.
//  Copyright © 2017年 JackYang. All rights reserved.
//

#import "AssetsServices.h"
#import "PHPhotoLibrary+JYEXT.h"
#import "PHAsset+JYEXT.h"
#import <Photos/Photos.h>
#import "WBLocalAsset+CoreDataClass.h"

@interface AssetsServices ()<PHPhotoLibraryChangeObserver>

@property (readwrite) NSMutableArray<JYAsset *> *allAssets;

@end

@implementation AssetsServices{
    PHFetchResult * _lastResult;
    BOOL _userAuth;
}

- (void)abort{
    
}

- (instancetype)init {
    if (self = [super init]) {
        [self checkAuth];
        if(_userAuth)
           [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    }
    return self;
}

- (void)checkAuth {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if(status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted){
        NSLog(@"用户拒绝");
        _userAuth = NO;
    } else if (status == PHAuthorizationStatusAuthorized) {
        NSLog(@"已取得用户授权");
        _userAuth = YES;
    } else if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
           if(status == PHAuthorizationStatusAuthorized)
                _userAuth = YES;
            else
                _userAuth = NO;
        }];
    }
}

- (NSArray *)allAssets {
    if (!_allAssets && _userAuth) {
        NSMutableArray * all = [NSMutableArray arrayWithCapacity:0];
        [PHPhotoLibrary getAllAsset:^(PHFetchResult<PHAsset *> *result, NSArray<PHAsset *> *assets) {
            [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                JYAssetType type = [obj getJYAssetType];
                NSString *duration = [obj getDurationString];
                [all addObject:[JYAsset modelWithAsset:obj type:type duration:duration]];
            }];
            _lastResult = result;
        }];
        _allAssets = all;
    }
    return _allAssets;
}

- (WBLocalAsset *)getAssetWithLocalId:(NSString *)localId {
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"localId = %@", localId];
    WBLocalAsset * asset = [WBLocalAsset MR_findFirstWithPredicate:predicate];
    return asset;
}

- (void)saveAsset:(WBLocalAsset *)asset {
    WBLocalAsset * oldAsset = [self getAssetWithLocalId:asset.localId];
    if(!oldAsset)
        oldAsset = [WBLocalAsset MR_createEntityInContext:[NSManagedObjectContext MR_context]];
    oldAsset.digest = asset.digest;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)preparePhotos
{
    @autoreleasepool {
        
        [(NSMutableArray *)self.allAssets removeAllObjects];
        
       
    }
}

#pragma mark - photolibrary change delegate

- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    PHFetchResult* currentAssets = _lastResult;
    NSMutableDictionary * tmpDic = [NSMutableDictionary dictionaryWithCapacity:0];
    for (JYAsset * asset in _allAssets) {
        [tmpDic setObject:asset forKey:asset.asset.localIdentifier];
    }
    
    BOOL shouldBeReset = NO;
    
    if (_lastResult){
        PHFetchResultChangeDetails* detail = [changeInstance changeDetailsForFetchResult:currentAssets];
        if (detail && detail.removedIndexes){
            for (NSUInteger index = detail.removedIndexes.firstIndex;
                 index != NSNotFound;
                 index = [detail.removedIndexes indexGreaterThanIndex:index]){
            }
        }
        if (detail && detail.insertedIndexes && !shouldBeReset){
            for (NSUInteger index = detail.insertedIndexes.firstIndex;
                 index != NSNotFound;
                 index = [detail.insertedIndexes indexGreaterThanIndex:index]){
                
            }
        }
    }
}
@end
