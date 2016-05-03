package com.ffcs.xkjs.action;

import com.ffcs.xkjs.domain.Admin;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

/**
 * Created by tianf on 2016/4/27.
 */

@Controller("adminAction")
@Scope(value="prototype")
public class AdminAction extends BaseAction<Admin> {
}
