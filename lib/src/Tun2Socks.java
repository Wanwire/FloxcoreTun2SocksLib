package com.wanwire.libtun2socks;

public class Tun2Socks {
    static {
        try {
            System.loadLibrary("tun2socks-android");
        } catch(Exception exception) {
            System.out.println(exception.getMessage());
	    throw exception;
        }
    }
    
    public native int main(String configPath, int tunFd);
    public native int mainFromFile(String configPath, int tunFd);
    public native int mainFromStr(String configStr, int configLen, int tunFd);
    public native void quit();
    public native void stats(long[] stats);
}
