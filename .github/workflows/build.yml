#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <objc/runtime.h>

attribute((constructor))
static void init() {
NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
[d setBool:YES forKey:@"all_purchases_unlocked"];
[d setBool:YES forKey:@"all_parts_unlocked"];
[d setBool:YES forKey:@"all_planets_unlocked"];
[d setBool:YES forKey:@"sandbox_mode"];
[d setBool:YES forKey:@"no_ads"];
[d setBool:YES forKey:@"full_bundle"];
[d setBool:YES forKey:@"dlc_unlocked"];
[d setInteger:999999999 forKey:@"currency"];
[d synchronize];

```
Class SKPaymentQueue = objc_getClass("SKPaymentQueue");
if (SKPaymentQueue) {
    Method m1 = class_getInstanceMethod(SKPaymentQueue, @selector(finishTransaction:));
    if (m1) {
        method_setImplementation(m1, imp_implementationWithBlock(^(id self, SKPaymentTransaction *t) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"sfs_all_unlocked"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }));
    }
}

Class storeController = objc_getClass("StoreController");
if (storeController) {
    Method m = class_getInstanceMethod(storeController, @selector(ProcessPurchase:));
    if (m) {
        method_setImplementation(m, imp_implementationWithBlock(^(id self, id purchase) {}));
    }
}

NSArray *classNames = @[@"IAPManager", @"PurchaseManager", @"SFSIAPManager", @"SFSStoreManager"];
for (NSString *name in classNames) {
    Class c = objc_getClass([name UTF8String]);
    if (c) {
        Method m = class_getInstanceMethod(c, @selector(hasPurchased:));
        if (m) {
            method_setImplementation(m, imp_implementationWithBlock(^BOOL(id self, NSString *pid) {
                return YES;
            }));
        }
        Method m2 = class_getInstanceMethod(c, @selector(isProductPurchased:));
        if (m2) {
            method_setImplementation(m2, imp_implementationWithBlock(^BOOL(id self, NSString *pid) {
                return YES;
            }));
        }
    }
}
```

}
