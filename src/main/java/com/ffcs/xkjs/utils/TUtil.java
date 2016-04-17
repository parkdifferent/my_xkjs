package com.ffcs.xkjs.utils;

import javax.servlet.http.HttpServletRequest;

import java.lang.reflect.ParameterizedType;
import java.text.SimpleDateFormat;
import java.util.Random;

/**
 * Created by tianf on 2016/3/27.
 */
public class TUtil {

    private static final SimpleDateFormat dateFormat = new

            SimpleDateFormat("yyyy-MM-dd");

    /**T型转换*/
    public static Class getActualType(Class entity) {
        ParameterizedType parameterizedType = (ParameterizedType) entity.getGenericSuperclass();
        Class entityClass = (Class) parameterizedType.getActualTypeArguments()[0];
        return entityClass;
    }


    public static String null2String(Object s) {
        return s == null ? "" : s.toString().trim();
    }

    public static java.util.Date formatDate(String s) {
        java.util.Date d = null;
        try {
            d = dateFormat.parse(s);
        } catch (Exception e) {
        }
        return d;
    }

    public static java.util.Date formatDate(String s, String format) {
        java.util.Date d = null;
        try {
            SimpleDateFormat dFormat = new SimpleDateFormat(format);
            d = dFormat.parse(s);
        } catch (Exception e) {
        }
        return d;
    }

    /**
     * 使用表单分页，前台需要给数据放到form里，适合多参数查询分页
     *
     * @param currentPage
     * @param pages
     * @return
     */
    public static String showPageFormHtml(int currentPage, int pages) {
        String s = "";
        if (pages > 0) {
            if (currentPage >= 1) {
                s += "<a href='javascript:void(0);' onclick='return gotoPage(1)'>首页</a> ";
                if (currentPage > 1)
                    s += "<a href='javascript:void(0);' onclick='return gotoPage("
                            + (currentPage - 1) + ")'>上一页</a> ";
            }

            int beginPage = currentPage - 3 < 1 ? 1 : currentPage - 3;
            if (beginPage <= pages) {
                s += "第　";
                for (int i = beginPage, j = 0; i <= pages && j < 6; i++, j++)
                    if (i == currentPage)
                        s += "<a class='this' href='javascript:void(0);' onclick='return gotoPage("
                                + i + ")'>" + i + "</a> ";
                    else
                        s += "<a href='javascript:void(0);' onclick='return gotoPage("
                                + i +

                                ")'>" + i + "</a> ";
                s += "页　";
            }
            if (currentPage <= pages) {
                if (currentPage < pages) {
                    s += "<a href='javascript:void(0);' onclick='return gotoPage("
                            + (currentPage + 1) + ")'>下一页</a> ";
                }
                s += "<a href='javascript:void(0);' onclick='return gotoPage("
                        + pages + ")'>末页</a> ";
            }
        }
        // s+=" 转到<input type=text size=2>页";
        return s;
    }

    public static String getURL(HttpServletRequest request) {
        String contextPath = request.getContextPath().equals("/") ? ""
                : request.getContextPath();
        String url = "http://" + request.getServerName();
        if (null2Int(request.getServerPort()) != 80) {
            url = url + ":" + null2Int(request.getServerPort()) + contextPath;
        } else {
            url = url + contextPath;
        }
        return url;
    }

    public static int null2Int(Object s) {
        int v = 0;
        if (s != null)
            try {
                v = Integer.parseInt(s.toString());
            } catch (Exception e) {
            }
        return v;
    }


    public static final String randomInt(int length) {
        if (length < 1) {
            return null;
        }
        Random randGen = new Random();
        char[] numbersAndLetters = ("0123456789").toCharArray();

        char[] randBuffer = new char[length];
        for (int i = 0; i < randBuffer.length; i++) {
            randBuffer[i] = numbersAndLetters[randGen.nextInt(10)];
        }
        return new String(randBuffer);
    }

}

