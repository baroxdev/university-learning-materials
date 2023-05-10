package utils;

public class StringUtils {
    public static Boolean isNotEmpty(String s) {
        return s != null && !s.trim().equals("");
    }
}
