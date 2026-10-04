Class SKPaymentQueue = objc_getClass("SKPaymentQueue");
if (SKPaymentQueue) {
    Method m1 = class_getInstanceMethod(SKPaymentQueue, @selector(finishTransaction:));
    if (m1) {
        orig_finishTransaction = (void *)method_getImplementation(m1);
        method_setImplementation(m1, (IMP)hook_finishTransaction);
    }
    Method m2 = class_getInstanceMethod(SKPaymentQueue, @selector(addPayment:));
    if (m2) {
        orig_addPayment = (void *)method_getImplementation(m2);
        method_setImplementation(m2, (IMP)hook_addPayment);
    }
}

Class storeController = objc_getClass("StoreController");
if (storeController) {
    Method m = class_getInstanceMethod(storeController, @selector(ProcessPurchase:));
    if (m) {
        orig_ProcessPurchase = (void *)method_getImplementation(m);
        method_setImplementation(m, (IMP)hook_ProcessPurchase);
    }
}

NSArray *classNames = @[@"IAPManager", @"PurchaseManager", @"SFSIAPManager", @"SFSStoreManager"];
for (NSString *name in classNames) {
    Class c = objc_getClass([name UTF8String]);
    if (c) {
        Method m = class_getInstanceMethod(c, @selector(hasPurchased:));
        if (m) {
            orig_hasPurchased = (BOOL (*)(id, SEL, NSString *))method_getImplementation(m);
            method_setImplementation(m, (IMP)hook_hasPurchased);
        }
        Method m2 = class_getInstanceMethod(c, @selector(isProductPurchased:));
        if (m2) {
            orig_isProductPurchased = (BOOL (*)(id, SEL, NSString *))method_getImplementation(m2);
            method_setImplementation(m2, (IMP)hook_isProductPurchased);
        }
    }
}
