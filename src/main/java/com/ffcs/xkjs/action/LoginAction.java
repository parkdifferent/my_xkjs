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

    /*private String vcode;

    public String getVcode() {
        return vcode;
    }

    public void setVcode(String vcode) {
        this.vcode = vcode;
    }*/


    public String login() throws Exception {
        Map session=ActionContext.getContext().getSession();
        //获取验证码
        String code=(String)session.get("code");

        String subCode=request.getParameter("code");
        String sno=request.getParameter("username");
        String password=request.getParameter("password");
        User user1;
        //判断验证码输入是否正确

        if(!code.equals(TUtil.null2String(subCode))) {
            //this.addActionError("验证码输入不正确！");
            request.setAttribute("codeMessage","验证码输入不正确!");
            return "logonError";
        }
            user1=userService.findUserBySno(sno);
            if(TUtil.null2String(user1).equals("")) {
               // this.addActionError("用户不存在！");
                request.setAttribute("userMessage","用户不存在!");
                return "logonError";

            } else {
                String password1=user1.getPassword();
                System.out.println(password1);
                if(!MD5Util.getMD5String(password).toUpperCase().equals(user1.getPassword())) {
                    //this.addActionError("密码输入不正确！");
                    request.setAttribute("passwordMessage","密码输入不正确!");
                    return "logonError";
                }
            }
                //session.put("userName",username);
        //request.setAttribute("userName",user1.getUserName());
        session.put("userId",user1.getUserId());
        session.put("userName",user1.getUserName());
        session.put("role",user1.getRole());
        return this.SUCCESS;
    }


    public String logout() {

        Map session=ActionContext.getContext().getSession();
        session.clear();

        return  "logout";
    }

    public String pwd() {

        return "pwd";
    }



    public String pwdSave() {

        String old_password= request.getParameter("old_password");
        String password= request.getParameter("password");
        Map session=ActionContext.getContext().getSession();
        String userId=(String)session.get("userId");
        User user1=new User();
        user1.setUserId(userId);
        User user2=userService.findUserByID(user1);

        if(MD5Util.getMD5String(old_password).toUpperCase().equals(user2.getPassword())) {
            user2.setPassword(MD5Util.getMD5String(password).toUpperCase());
            request.setAttribute("op_title","修改密码成功");
            //request.seta("op_title", "修改密码成功");


        }
        else {
            request.setAttribute("op_title","原密码错误");
            request.setAttribute("list_url",TUtil.getURL(request)+ "/system/user_list.do");
            return "error";

        }

        request.setAttribute("list_url",TUtil.getURL(request)+ "/system/user_list.do");
        return "perfect";

    }
}
