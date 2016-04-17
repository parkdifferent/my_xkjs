package com.ffcs.xkjs.action;

import com.ffcs.xkjs.utils.CodeUtil;
import com.ffcs.xkjs.utils.TUtil;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.Map;
import java.util.Random;

/**
 * Created by tianf on 2016/4/5.
 */

@Controller("verifyAction")
@Scope(value="prototype")
public class VerifyAction extends ActionSupport{

    private static final long serialVersionUID = -712962347758638769L;
    private InputStream imageStream;

    public InputStream getImageStream() {
        return imageStream;
    }

    public void setImageStream(InputStream imageStream) {
        this.imageStream = imageStream;
    }


    public String execute() {


      /* *//* response.setContentType("image/jpeg");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        HttpSession session = request.getSession(false);*//*
        // 在内存中创建图象
        int width = 73;
        int height = 27;
        *//*if(!CommUtil.null2String(w).equals("")){
            width=CommUtil.null2Int(w);
        }
        if(!CommUtil.null2String(h).equals("")){
            height=CommUtil.null2Int(h);
        }*//*
        BufferedImage image = new BufferedImage(width, height,
                BufferedImage.TYPE_INT_RGB);

        // 获取图形上下文
        Graphics g = image.getGraphics();

        // 生成随机类
        Random random = new Random();

        // 设定背景色
        g.setColor(getRandColor(160, 250));
        g.fillRect(0, 0, width, height);

        // 设定字体
        g.setFont(new Font("Times New Roman", Font.PLAIN, 24));

        // 画边框
        g.setColor(new Color(80,80,80));
        g.drawRect(0,0,width-1,height-1);

        // 随机产生155条干扰线，使图象中的认证码不易被其它程序探测到
        g.setColor(getRandColor(160, 200));
        for (int i = 0; i < 255; i++) {
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            int xl = random.nextInt(12);
            int yl = random.nextInt(12);
            g.drawLine(x, y, x + xl, y + yl);
        }

        // 取随机产生的认证码(4位数字)
        String sRand = "";
        for (int i = 0; i < 4; i++) {
            String rand = TUtil.randomInt(1).toUpperCase();
            sRand += rand;
            // 将认证码显示到图象中
            g.setColor(new Color(20 + random.nextInt(110), 20 + random
                    .nextInt(110), 20 + random.nextInt(110)));// 调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成
            g.drawString(rand, 14 * i + 6, 24);
        }

        // 将认证码存入SESSION
       *//* if (TUtil.null2String(name).equals("")) {
            session.setAttribute("verify_code", sRand);
        } else {
            session.setAttribute(name, sRand);
        }*//*

        Map<String,Object> session= ActionContext.getContext().getSession();//ActionContext 工具类
        //session.setAttribute("verify_code", sRand);
        session.put("verify_code",sRand);
        // 图象生效
        g.dispose();
        ServletOutputStream responseOutputStream = response.getOutputStream();
        // 输出图象到页面
        ImageIO.write(image, "JPEG", responseOutputStream);

        // 以下关闭输入流！
        responseOutputStream.flush();
        responseOutputStream.close();
    }

    private Color getRandColor(int fc, int bc) {// 给定范围获得随机颜色
        Random random = new Random();
        if (fc > 255)
            fc = 255;
        if (bc > 255)
            bc = 255;
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }

    }*/


        Map<String, BufferedImage> map = CodeUtil.createImage();
        String code = map.keySet().iterator().next();//获取图片字符
        Map<String, Object> session = ActionContext.getContext().getSession();//ActionContext 工具类
        session.put("code", code);
        System.out.println(code);
        BufferedImage image = map.get(code);//获取图片
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(bos);
        try {
            encoder.encode(image);
            byte[] bits = bos.toByteArray();
            imageStream = new ByteArrayInputStream(bits);
            return this.SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return this.ERROR;
        }
    }
}
