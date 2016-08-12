package com.ffcs.xkjs.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

/**
 * Created by tianf on 2016/5/31.
 */

@Controller("statAction")
@Scope(value="prototype")
public class StatAction {

    public String list() {

        return "list";

    }


    public String categoryList() {

        return "categoryList";
    }

    public String canSai() {
        return "canSai";
    }

    public String huoJiang() {
        return "huoJiang";
    }









}
