package cc.binmt.signature;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.util.Base64;
import gogolook.callgogolook2.MyApplication;
import java.io.ByteArrayInputStream;
import java.io.DataInputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

/* loaded from: classes.dex */
public class PmsHookApplication extends MyApplication implements InvocationHandler {
    private static final int GET_SIGNATURES = 64;
    private String appPkgName = "";
    private Object base;
    private byte[][] sign;

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // gogolook.callgogolook2.MyApplication, android.content.ContextWrapper
    public void attachBaseContext(Context base) {
        hook(base);
        super.attachBaseContext(base);
    }

    @Override // java.lang.reflect.InvocationHandler
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        if ("getPackageInfo".equals(method.getName())) {
            String pkgName = (String) args[0];
            if (this.appPkgName.equals(pkgName)) {
                PackageInfo info = (PackageInfo) method.invoke(this.base, args);
                info.signatures = new Signature[this.sign.length];
                for (int i10 = 0; i10 < info.signatures.length; i10++) {
                    info.signatures[i10] = new Signature(this.sign[i10]);
                }
                return info;
            }
        }
        return method.invoke(this.base, args);
    }

    private void hook(Context context) {
        try {
            DataInputStream is = new DataInputStream(new ByteArrayInputStream(Base64.decode("AQAAAncwggJzMIIB3KADAgECAgRMMeB9MA0GCSqGSIb3DQEBBQUAMH0xCzAJBgNVBAYTAlRXMQ8wDQYDVQQIEwZUYWlwZWkxDzANBgNVBAcTBlRhaXBlaTEYMBYGA1UEChMPZ29nb2xvb2sgbW9iaWxlMRgwFgYDVQQLEw9nb2dvbG9vayBtb2JpbGUxGDAWBgNVBAMTD0poZW5nLUh1YW4gU29uZzAgFw0xMDA3MDUxMzM5MDlaGA8yMjEwMDUxODEzMzkwOVowfTELMAkGA1UEBhMCVFcxDzANBgNVBAgTBlRhaXBlaTEPMA0GA1UEBxMGVGFpcGVpMRgwFgYDVQQKEw9nb2dvbG9vayBtb2JpbGUxGDAWBgNVBAsTD2dvZ29sb29rIG1vYmlsZTEYMBYGA1UEAxMPSmhlbmctSHVhbiBTb25nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCocgjN5Uh7HGudiQ+gFGl849N1chkRY5LyOEwbbIpFUA0hMgVF0GwQa3fMx07EcGM4iOQ/M1HtHUjf6DopCSrqhO7IZb6knipKrBseFulwJUHRN2VqX3aGIKG+w/d6b0y/kkJsdki/xk7g9F/9InV5JitpbRSJx+RuhDcB8w6GnwIDAQABMA0GCSqGSIb3DQEBBQUAA4GBACXfdDpHsOTccAomGaU9nELUWo2BDVeLwJPtLS4FnpiYJc9Ny+e70T9BMNmwHEosDxqVpkGHhWERcVqzmslLNt0NllJVm48J1JiWQuV57CNH2uikn9z/GupCEPiOXiWgGP4IYsyPQcpbgm8+z2v2wDJrJy8urI0AQQLRMxNeMJK8", 0)));
            byte[][] sign = new byte[is.read() & 255];
            for (int i10 = 0; i10 < sign.length; i10++) {
                sign[i10] = new byte[is.readInt()];
                is.readFully(sign[i10]);
            }
            Class<?> activityThreadClass = Class.forName("android.app.ActivityThread");
            Method currentActivityThreadMethod = activityThreadClass.getDeclaredMethod("currentActivityThread", new Class[0]);
            Object currentActivityThread = currentActivityThreadMethod.invoke(null, new Object[0]);
            Field sPackageManagerField = activityThreadClass.getDeclaredField("sPackageManager");
            sPackageManagerField.setAccessible(true);
            Object sPackageManager = sPackageManagerField.get(currentActivityThread);
            Class<?> iPackageManagerInterface = Class.forName("android.content.pm.IPackageManager");
            this.base = sPackageManager;
            this.sign = sign;
            this.appPkgName = context.getPackageName();
            Object proxy = Proxy.newProxyInstance(iPackageManagerInterface.getClassLoader(), new Class[]{iPackageManagerInterface}, this);
            sPackageManagerField.set(currentActivityThread, proxy);
            PackageManager pm2 = context.getPackageManager();
            Field mPmField = pm2.getClass().getDeclaredField("mPM");
            mPmField.setAccessible(true);
            mPmField.set(pm2, proxy);
            System.out.println("PmsHook success.");
        } catch (Exception e10) {
            System.err.println("PmsHook failed.");
            e10.printStackTrace();
        }
    }
}