#import "InputData.h"



@implementation InputRow
-(instancetype)initWithK:(NSString *)key withShow:(NSString *)show {
    self = [super init];
    if (self) {
        self.key = key;
        self.show = show;
    }
    return self;
}

@end
