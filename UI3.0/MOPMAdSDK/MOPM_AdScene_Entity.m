
#import "MOPM_AdScene_Entity.h"

@implementation MOPM_AdScene_Entity

- (NSString *)description {
    return [NSString stringWithFormat:@"{adId = %@, originData = %@}", self.adId, self.originData];
}

@end
