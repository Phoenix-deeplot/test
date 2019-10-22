package com.kst.sys.api.vo;

public class ModuleVO {

    private String moduleName;

    private String moduleNo;

    private Boolean useFlag;

    public ModuleVO(){

    }

    public ModuleVO(String moduleName, String moduleNo, Boolean useFlag) {
        this.moduleName = moduleName;
        this.moduleNo = moduleNo;
        this.useFlag = useFlag;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getModuleNo() {
        return moduleNo;
    }

    public void setModuleNo(String moduleNo) {
        this.moduleNo = moduleNo;
    }

    public Boolean getUseFlag() {
        return useFlag;
    }

    public void setUseFlag(Boolean useFlag) {
        this.useFlag = useFlag;
    }
}
