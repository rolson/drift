//
//  YLPQuery.m
//  YelpAPI
//
//  Created by Steven Sheldon on 6/26/16.
//
//

#import "YLPQuery.h"
#import "YLPQueryPrivate.h"
#import "YLPCoordinate.h"

@implementation YLPQuery

- (instancetype)initWithLocation:(NSString *)location {
    if (self = [super init]) {
        _mode = YLPSearchModeLocation;
        _location = [location copy];
        _maxDollarSigns = 0;
        _openNow = NO;
    }
    return self;
}

- (instancetype)initWithCoordinate:(YLPCoordinate *)coordinate {
    if (self = [super init]) {
        _mode = YLPSearchModeCoordinate;
        _coordinate = coordinate;
        _maxDollarSigns = 0;
        _openNow = NO;
    }
    return self;
}

- (NSArray<NSString *> *)categoryFilter {
    return _categoryFilter ?: @[];
}

- (NSString *)sortParameter {
    switch (self.sort) {
        case YLPSortTypeBestMatched:
            return @"best_match";
        case YLPSortTypeHighestRated:
            return @"rating";
        case YLPSortTypeDistance:
            return @"distance";
        case YLPSortTypeMostReviewed:
            return @"review_count";
    }
}

- (NSDictionary *)parameters {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    switch (self.mode) {
        case YLPSearchModeLocation:
            params[@"location"] = self.location;
            break;
        case YLPSearchModeCoordinate:
            params[@"latitude"] = @(self.coordinate.latitude);
            params[@"longitude"] = @(self.coordinate.longitude);
            break;
    }

    if (self.term) {
        params[@"term"] = self.term;
    }
    if (self.limit) {
        params[@"limit"] = @(self.limit);
    }
    if (self.offset) {
        params[@"offset"] = @(self.offset);
    }
    if (self.sort != YLPSortTypeBestMatched) {
        params[@"sort_by"] = [self sortParameter];
    }
    if (self.categoryFilter.count > 0) {
        params[@"categories"] = [self.categoryFilter componentsJoinedByString:@","];
    }
    if (self.radiusFilter > 0) {
        params[@"radius"] = @(self.radiusFilter);
    }
    if (self.dealsFilter || self.hotAndNew) {
        NSMutableArray *arr = [NSMutableArray array];
        if (self.dealsFilter){
            [arr addObject:@"deals"];
        }
        if (self.hotAndNew){
            [arr addObject:@"hot_and_new"];
        }
        params[@"attributes"] = [arr componentsJoinedByString:@","];
    }
    if (self.openNow){
        params[@"open_now"] = @"true";
    }
    if (self.maxDollarSigns > 0){
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i=1; i<=self.maxDollarSigns; i++){
            [arr addObject:@(i).description];
        }
        params[@"price"] = [arr componentsJoinedByString:@","];
    }

    return params;
}

@end




