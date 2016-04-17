package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.User;
import com.ffcs.xkjs.service.IUserService;
import com.ffcs.xkjs.utils.MD5Util;
import com.ffcs.xkjs.utils.TUtil;
import com.opensymphony.xwork2.ActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.util.Map;



/**
 * Created by tianf on 2016/4/6.
 */

@Controller("loginAction")
@Scope(value="prototype")
public class LoginAction extends BaseAction<User> {

    User user=this.getModel();

    @Resource(name= IUserService.SERVICE_NAME)
    IUserService userService;

    private String vcode;

    public String getVcode() {
        return vcode;
    }

    public void setVcode(String vcode) {
        this.vcode = vcode;
    }


    public String login() throws Exception {
        Map session=ActionContext.getContext().getSession();
        //获取验证码
        String code=(String)session.get("code");
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        //判断验证码输入是否正确
        if(code.equals(TUtil.null2String(vcode))) {
            this.addActionError("验证码输入不正确！");
            return this.INPUT;
        } else {
            User user1=userService.findUserByUserName(username);
            if(TUtil.null2String(user1).equals("")) {
                this.addActionError("用户不存在！");
                return this.INPUT;

            } else {
                String password1=user1.getPassword();
                System.out.println(password1);
                if(!MD5Util.getMD5String(password).toUpperCase().equals(user1.getPassword())) {
                    this.addActionError("密码输入不正确！");
                    return this.INPUT;
                }
            }
        }

        return "login";
    }
}
