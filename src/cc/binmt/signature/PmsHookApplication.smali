.class public Lcc/binmt/signature/PmsHookApplication;
.super Landroid/app/Application;
.source "PmsHookApplication.java"

# interfaces
.implements Ljava/lang/reflect/InvocationHandler;


# static fields
.field private static final GET_SIGNATURES:I = 0x40


# instance fields
.field private appPkgName:Ljava/lang/String;

.field private base:Ljava/lang/Object;

.field private sign:[[B


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 20
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    .line 25
    const-string v0, ""

    iput-object v0, p0, Lcc/binmt/signature/PmsHookApplication;->appPkgName:Ljava/lang/String;

    return-void
.end method

.method private hook(Landroid/content/Context;)V
    .locals 14
    .param p1, "context"    # Landroid/content/Context;

    .line 61
    :try_start_0
    const-string v0, "### Signatures Data ###"

    .line 62
    .local v0, "data":Ljava/lang/String;
    new-instance v1, Ljava/io/DataInputStream;

    new-instance v2, Ljava/io/ByteArrayInputStream;

    const/4 v3, 0x0

    invoke-static {v0, v3}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v4

    invoke-direct {v2, v4}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    invoke-direct {v1, v2}, Ljava/io/DataInputStream;-><init>(Ljava/io/InputStream;)V

    .line 63
    .local v1, "is":Ljava/io/DataInputStream;
    invoke-virtual {v1}, Ljava/io/DataInputStream;->read()I

    move-result v2

    and-int/lit16 v2, v2, 0xff

    new-array v2, v2, [[B

    .line 64
    .local v2, "sign":[[B
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    array-length v5, v2

    if-ge v4, v5, :cond_0

    .line 65
    invoke-virtual {v1}, Ljava/io/DataInputStream;->readInt()I

    move-result v5

    new-array v5, v5, [B

    aput-object v5, v2, v4

    .line 66
    aget-object v5, v2, v4

    invoke-virtual {v1, v5}, Ljava/io/DataInputStream;->readFully([B)V

    .line 64
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 70
    .end local v4    # "i":I
    :cond_0
    const-string v4, "android.app.ActivityThread"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    .line 71
    .local v4, "activityThreadClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    const-string v5, "currentActivityThread"

    new-array v6, v3, [Ljava/lang/Class;

    .line 72
    invoke-virtual {v4, v5, v6}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v5

    .line 73
    .local v5, "currentActivityThreadMethod":Ljava/lang/reflect/Method;
    const/4 v6, 0x0

    new-array v7, v3, [Ljava/lang/Object;

    invoke-virtual {v5, v6, v7}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 76
    .local v6, "currentActivityThread":Ljava/lang/Object;
    const-string v7, "sPackageManager"

    invoke-virtual {v4, v7}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v7

    .line 77
    .local v7, "sPackageManagerField":Ljava/lang/reflect/Field;
    const/4 v8, 0x1

    invoke-virtual {v7, v8}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 78
    invoke-virtual {v7, v6}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    .line 81
    .local v9, "sPackageManager":Ljava/lang/Object;
    const-string v10, "android.content.pm.IPackageManager"

    invoke-static {v10}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v10

    .line 82
    .local v10, "iPackageManagerInterface":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    iput-object v9, p0, Lcc/binmt/signature/PmsHookApplication;->base:Ljava/lang/Object;

    .line 83
    iput-object v2, p0, Lcc/binmt/signature/PmsHookApplication;->sign:[[B

    .line 84
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v11

    iput-object v11, p0, Lcc/binmt/signature/PmsHookApplication;->appPkgName:Ljava/lang/String;

    .line 86
    nop

    .line 87
    invoke-virtual {v10}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v11

    new-array v12, v8, [Ljava/lang/Class;

    aput-object v10, v12, v3

    .line 86
    invoke-static {v11, v12, p0}, Ljava/lang/reflect/Proxy;->newProxyInstance(Ljava/lang/ClassLoader;[Ljava/lang/Class;Ljava/lang/reflect/InvocationHandler;)Ljava/lang/Object;

    move-result-object v3

    .line 92
    .local v3, "proxy":Ljava/lang/Object;
    invoke-virtual {v7, v6, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 95
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v11

    .line 96
    .local v11, "pm":Landroid/content/pm/PackageManager;
    invoke-virtual {v11}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v12

    const-string v13, "mPM"

    invoke-virtual {v12, v13}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v12

    .line 97
    .local v12, "mPmField":Ljava/lang/reflect/Field;
    invoke-virtual {v12, v8}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 98
    invoke-virtual {v12, v11, v3}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    .line 99
    sget-object v8, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v13, "PmsHook success."

    invoke-virtual {v8, v13}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 103
    .end local v0    # "data":Ljava/lang/String;
    .end local v1    # "is":Ljava/io/DataInputStream;
    .end local v2    # "sign":[[B
    .end local v3    # "proxy":Ljava/lang/Object;
    .end local v4    # "activityThreadClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v5    # "currentActivityThreadMethod":Ljava/lang/reflect/Method;
    .end local v6    # "currentActivityThread":Ljava/lang/Object;
    .end local v7    # "sPackageManagerField":Ljava/lang/reflect/Field;
    .end local v9    # "sPackageManager":Ljava/lang/Object;
    .end local v10    # "iPackageManagerInterface":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    .end local v11    # "pm":Landroid/content/pm/PackageManager;
    .end local v12    # "mPmField":Ljava/lang/reflect/Field;
    goto :goto_1

    .line 100
    :catch_0
    move-exception v0

    .line 101
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Ljava/lang/System;->err:Ljava/io/PrintStream;

    const-string v2, "PmsHook failed."

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 102
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 104
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 0
    .param p1, "base"    # Landroid/content/Context;

    .line 29
    invoke-direct {p0, p1}, Lcc/binmt/signature/PmsHookApplication;->hook(Landroid/content/Context;)V

    .line 30
    invoke-super {p0, p1}, Landroid/app/Application;->attachBaseContext(Landroid/content/Context;)V

    .line 31
    return-void
.end method

.method public invoke(Ljava/lang/Object;Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 6
    .param p1, "proxy"    # Ljava/lang/Object;
    .param p2, "method"    # Ljava/lang/reflect/Method;
    .param p3, "args"    # [Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 35
    invoke-virtual {p2}, Ljava/lang/reflect/Method;->getName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "getPackageInfo"

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 36
    const/4 v0, 0x0

    aget-object v0, p3, v0

    check-cast v0, Ljava/lang/String;

    .line 47
    .local v0, "pkgName":Ljava/lang/String;
    iget-object v1, p0, Lcc/binmt/signature/PmsHookApplication;->appPkgName:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 48
    iget-object v1, p0, Lcc/binmt/signature/PmsHookApplication;->base:Ljava/lang/Object;

    invoke-virtual {p2, v1, p3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/content/pm/PackageInfo;

    .line 49
    .local v1, "info":Landroid/content/pm/PackageInfo;
    iget-object v2, p0, Lcc/binmt/signature/PmsHookApplication;->sign:[[B

    array-length v2, v2

    new-array v2, v2, [Landroid/content/pm/Signature;

    iput-object v2, v1, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    .line 50
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    iget-object v3, v1, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    array-length v3, v3

    if-ge v2, v3, :cond_0

    .line 51
    iget-object v3, v1, Landroid/content/pm/PackageInfo;->signatures:[Landroid/content/pm/Signature;

    new-instance v4, Landroid/content/pm/Signature;

    iget-object v5, p0, Lcc/binmt/signature/PmsHookApplication;->sign:[[B

    aget-object v5, v5, v2

    invoke-direct {v4, v5}, Landroid/content/pm/Signature;-><init>([B)V

    aput-object v4, v3, v2

    .line 50
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 53
    .end local v2    # "i":I
    :cond_0
    return-object v1

    .line 56
    .end local v0    # "pkgName":Ljava/lang/String;
    .end local v1    # "info":Landroid/content/pm/PackageInfo;
    :cond_1
    iget-object v0, p0, Lcc/binmt/signature/PmsHookApplication;->base:Ljava/lang/Object;

    invoke-virtual {p2, v0, p3}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method
