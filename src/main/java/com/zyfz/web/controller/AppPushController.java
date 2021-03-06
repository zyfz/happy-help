package com.zyfz.web.controller;

import com.zyfz.domain.Push;
import com.zyfz.domain.User;
import com.zyfz.model.ResponseMessage;
import com.zyfz.service.IPushService;
import com.zyfz.service.IUserservice;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by ron on 16-12-6.
 */
@Controller
public class AppPushController extends BaseController {

    @Resource
    IPushService pushService;

    @Resource
    IUserservice userservice;

    @RequestMapping(value = "/api/v1/anon/push",method = RequestMethod.POST)
    public void updatePush(Push push, HttpServletResponse response){
        try {
            Push mPush = new Push();
            String alias = push.getAlias();
            if (alias == null){
                alias = String.valueOf(push.getHhUserId());
            }

            Push push1 = pushService.selectByUserId(Integer.valueOf(alias));

            if (push1 == null){
                mPush.setHhUserId(Integer.valueOf(alias));
                mPush.setAlias(alias);
                if (push.getTopic() != null){
                    mPush.setTopic(push.getTopic());
                }
                pushService.save(mPush);
            } else if (push1 != null){
                if (push.getAlias() != null){
                    push1.setAlias(push.getAlias());
                }
                if (push.getProvince() != null){
                    push1.setProvince(push.getProvince());
                }
                if (push.getCity() != null){
                    push1.setCity(push.getCity());
                }
                if (push.getArea() != null){
                    push1.setArea(push.getArea());
                }
                if (push.getStreet() != null){
                    push1.setStreet(push.getStreet());
                }
                if (push.getTopic() != null){
                    push1.setTopic(push.getTopic());
                }
                pushService.update(push1);
            }
            super.writeJson(new ResponseMessage<String>(0,"success!","null"),response);
        }catch (Exception e){
            Map<String,String> map = new HashMap<String, String>();
            map.put("errMsg",e.toString());
            super.writeJson(new ResponseMessage<Map<String,String>>(50801,"请求失败!",map),response);
        }

    }

    @RequestMapping(value = "/api/v1/anon/topic",method = RequestMethod.GET)
    public void getTopic(@RequestParam("userId")Integer userId, HttpServletResponse response){
        try {
            super.writeJson(new ResponseMessage<Push>(0,"success",pushService.selectByUserId(userId)),response);
        }catch (Exception e){
            Map<String,String> map = new HashMap<String, String>();
            map.put("errMsg",e.toString());
            super.writeJson(new ResponseMessage<Map<String,String>>(50801,"请求失败!",map),response);
        }
    }
}
