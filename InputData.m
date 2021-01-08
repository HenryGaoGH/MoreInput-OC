#import "InputData.h"



@implementation InputRow
-(instancetype)initWith:(NSString *)key withV:(NSString *)show {
    self = [super init];
    if (self) {
        self.key = key;
        self.show = show;
    }
    return self;
}

@end
