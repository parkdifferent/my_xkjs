package com.ffcs.xkjs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.ffcs.xkjs.utils.TUtil;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

/**
 * Created by tianf on 2016/3/27.
 */
public class BaseAction<T> extends ActionSupport implements ModelDriven<T>,ServletRequestAware,ServletResponseAware {

    T entity;

    protected HttpServletRequest request;
    protected HttpServletResponse response;

    //T型实例化
    public BaseAction(){
        /**T型转换*/
        Class entityClass = TUtil.getActualType(this.getClass());
        try {
            entity = (T) entityClass.newInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public T getModel() {
        return entity;
    }

    public void setServletResponse(HttpServletResponse res) {
        this.response = res;
    }

    public void setServletRequest(HttpServletRequest req) {
        this.request = req;
    }
}
