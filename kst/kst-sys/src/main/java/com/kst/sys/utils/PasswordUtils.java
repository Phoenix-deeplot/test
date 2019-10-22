package com.kst.sys.utils;

import com.kst.common.utils.Constants;
import com.kst.common.utils.Digests;
import com.kst.common.utils.Encodes;
import com.kst.sys.api.entity.User;
import org.apache.commons.lang3.StringUtils;

/**
 * Created by zjf on 2017/9/1.
 * <p>
 * <p>
 * Describe: 系统密码工具
 */
public class PasswordUtils {

    /**
     * 设定安全的密码，生成随机的salt并经过1024次 sha-1 hash
     */
    public static void entryptPassword(User user) {
        byte[] salt = Digests.generateSalt(Constants.SALT_SIZE);
        user.setSalt(Encodes.encodeHex(salt));
        byte[] hashPassword = Digests.sha1(user.getPassword().getBytes(), salt, Constants.HASH_INTERATIONS);
        user.setPassword(Encodes.encodeHex(hashPassword));
    }

    /**
     *
     * @param paramStr 输入需要加密的字符串
     * @return
     */
    public static String entryptPassword(String paramStr,String salt) {
        if(StringUtils.isNotEmpty(paramStr)){
            byte[] saltStr = Encodes.decodeHex(salt);
            byte[] hashPassword = Digests.sha1(paramStr.getBytes(), saltStr, Constants.HASH_INTERATIONS);
            String password = Encodes.encodeHex(hashPassword);
            return password;
        }else{
            return null;
        }

    }


}
