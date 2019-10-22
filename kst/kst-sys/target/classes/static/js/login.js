/**
 * Created by billJiang on 2017/1/12.
 * 登录异常信息显示
 */

function LoginValidator(config) {
    this.errorCode = config.errorCode;
    this.message = config.message;
    this.username = config.username;
    this.password = config.password;
    this.code = config.code;
    this.initValidator();
}

//0 未授权 1 账号问题 2 密码错误  3 账号密码错误  4 验证码错误
LoginValidator.prototype.initValidator = function () {
    if (!this.errorCode)
        return;
    if(this.errorCode==0){
        this.addPasswordErrorMsg();
    }else if(this.errorCode==1){
        this.addUserNameErrorStyle();
        this.addUserNameErrorMsg();
    }else if(this.errorCode==2){
        this.addPasswordErrorStyle();
        this.addPasswordErrorMsg();
    }else if(this.errorCode==3){
        this.addUserNameErrorStyle();
        this.addPasswordErrorStyle();
        this.addPasswordErrorMsg();
    }else if(this.errorCode==4){
        this.addCodeErrorStyle();
        this.addCodeErrorMsg();
    }
    return;
}

LoginValidator.prototype.addUserNameErrorStyle = function () {
    this.addErrorStyle(this.username);
}

LoginValidator.prototype.addPasswordErrorStyle = function () {
    this.addErrorStyle(this.password);
}

LoginValidator.prototype.addCodeErrorStyle = function () {
    this.addErrorStyle(this.code);
}

LoginValidator.prototype.addUserNameErrorMsg = function () {
    this.addErrorMsg(this.username);
}

LoginValidator.prototype.addPasswordErrorMsg = function () {
    this.addErrorMsg(this.password);
}

LoginValidator.prototype.addCodeErrorMsg = function () {
    this.addErrorMsg(this.code);
}


LoginValidator.prototype.addErrorMsg=function(field){
    $('.help-block[data-bv-validator="test"][data-bv-for="'+field+'"]').remove();
    $("input[name='"+field+"']").parent().parent().append('<small  data-bv-validator="test" data-bv-for="'+field+'" class="help-block">' + this.message + '</small>');
}

LoginValidator.prototype.addErrorStyle=function(field){
    $("input[name='" + field + "']").parent().parent().addClass("has-error");
}
