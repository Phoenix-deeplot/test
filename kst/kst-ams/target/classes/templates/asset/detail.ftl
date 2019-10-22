<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width"/>
    <title>资产信息管理详情</title>
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="${base}/static/bootstrap/css/bootstrap.css">
    <!-- iCheck for checkboxes and radio inputs -->
    <link rel="stylesheet" href="${base}/static/plugins/iCheck/all.css">
    <!-- Bootstrap Switch -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-switch/css/bootstrap-switch.css">
    <!-- Bootstrap select -->
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-select/css/bootstrap-select.css"/>
    <link rel="stylesheet" href="${base}/static/plugins/bootstrap-table/css/bootstrap-table.css">
    <!-- toastr信息提示框插件 -->
    <link rel="stylesheet" href="${base}/static/plugins/toastr/css/toastr.css">
    <link rel="stylesheet" href="${base}/static/AdminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.css" media="screen">
    <link rel="stylesheet" href="${base }/static/plugins/zTree/css/zTreeStyle/zTreeStyle.css">


</head>
<body>
<ul id="myTab" class="nav nav-tabs" role="tablist">
    <li class="active"><a href="#asset" role="tab" data-toggle="tab">资产</a></li>
    <li><a href="#hardware" role="tab" data-toggle="tab">硬件</a></li>
    <li><a href="#net" role="tab" data-toggle="tab">网络</a></li>
    <li><a href="#software" role="tab" data-toggle="tab">配件</a></li>
</ul>

<div class="box box-info" style="margin-bottom:0px;">
    <!-- form start -->
    <form class="form-horizontal" id="assetForm">
        <input hidden="hidden" name="id" value="${asset.id}"/>
        <div class="box-body">

            <!--tab页内容区分-------------------------------------->
            <div id="myTabContent" class="tab-content">
                <!--tab页内容区分-----------------asset资产信息--------------------->
                <div class="tab-pane active" id="asset">
                    <div class="form-group" style="height: 55px;display: none;">
                        <label class="col-sm-2 control-label" for="no">资产编号</label>
                        <div class="col-sm-5">
                            <input type="text" name="preNo" readonly="readonly" id="preNo"> +
                            <input type="text" name="sysTime" readonly="readonly" id="sysTime">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="no">资产编号</label>
                        <div class="col-sm-5">
                            <input type="text" name="assetInputNo" class="form-control" id="assetInputNo"
                                   placeholder="请输入资产编号" value="${asset.assetInputNo}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="name">资产名称</label>
                        <div class="col-sm-5">
                            <input type="text" name="name" class="form-control" id="name" placeholder="请输入资产名称"
                                   value="${asset.name}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="classify">资产分类</label>
                        <div class="col-sm-4" style="height: 30px">
                            <select name="category" id="category" class="selectpicker" title="请选择"
                                    data-width="150px">
                                <#list testType as test>
                                    <#if asset!=null >
                                        <#if asset.classify==test.value>
                                            <option value="${test.value}" selected="selected">${test.label}</option>
                                        <#else>
                                            <option value="${test.value}">${test.label}</option>
                                        </#if>
                                    <#else>
                                        <option value="${test.value}"
                                                <#if test_index==0 >select="selected" </#if> >${test.label}</option>
                                    </#if>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="brand">资产品牌</label>
                        <div class="col-sm-3">
                            <input type="text" name="brand" class="form-control" id="brand" placeholder="请输入品牌"
                                   value="${asset.brand}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="supplierId">供应商</label>
                        <div class="col-sm-3">
                            <input type="text" id="supplierName" value="${supplierName}" class="form-control"
                                   placeholder="请选择供应商" readonly>
                            <input type="text" name="supplierId" hidden id="supplierId"
                                   value="${asset.supplierId}">
                        </div>
                        <a href="javascript:void(0)" id="superiorAssetChoiceBtn" onclick="openSupplierModal()"
                           class="btn btn-primary"><span class="glyphicon glyphicon-search"></span></a>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="registerDate">登记日</label>
                        <div class="col-sm-10">
                            <div id="registerDate" class="input-group date form_date col-md-6" data-date=""
                                 data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
                                 data-link-format="yyyy-mm-dd">
                                <input class="form-control" size="16" type="text" readonly
                                       value="<#if asset.registerDate??>${asset.registerDate?string('yyyy-MM-dd')}<#else>${.now?string('yyyy-MM-dd')}</#if>">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="buyDate">购买日</label>
                        <#if asset.id?? >
                            <div class="col-sm-5">
                                <input type="text" class="form-control"
                                       value="<#if asset.id??>${asset.buyDate?string('yyyy-MM-dd')}</#if>" readonly>
                            </div>
                        </#if>
                        <div class="col-sm-10" <#if asset.id?? >hidden</#if>>
                            <div id="buyDate" name="buyDate" class="input-group date form_date col-md-6" data-date=""
                                 data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
                                 data-link-format="yyyy-mm-dd">
                                <input class="form-control" size="16" type="text"
                                       onchange="produceReserveScrapDate()" readonly
                                       value="<#if asset.buyDate??>${asset.buyDate?string('yyyy-MM-dd')}</#if>">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="price">价格</label>
                        <div class="col-sm-3">
                            <input type="text" name="price" class="form-control" id="price"
                                   placeholder="请输入价格"
                                   value="${asset.price}" <#if asset.id??><#if asset.divideFlag>readonly</#if></#if>
                                   oninput="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')">
                        </div><label class="control-label" >元</label><label class="control-label" style="font: small;color: gray;" >（折旧对象资产请使用财务折旧基础价格，一般资产使用购买价格）</label>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="amount">数量</label>
                        <div class="col-sm-3">
                            <input type="text" name="amount" class="form-control" id="amount"
                                   placeholder="请输入数量"
                                   value="<#if asset.amount??>${asset.amount}<#else>1</#if>"
                                   oninput="value=value.replace(/[^\d]/g,'')">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="residualProportion">净值比例</label>
                        <div class="col-sm-3">
                            <input type="text" name="residualProportion" class="form-control" id="price"
                                   placeholder="请输入净值比例"
                                   value="${asset.residualProportion}" <#if asset.id??><#if asset.divideFlag>readonly</#if></#if>
                                   oninput="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')">
                        </div><label class="control-label" >%</label>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="useLife">使用年限</label>
                        <div class="col-sm-3">
                            <select name="useLife" id="useLife" class="selectpicker"
                                    onchange="produceReserveScrapDate()" title="请选择"
                                    data-width="150px">
                                <option value="">请选择</option>
                                <#list 1..5 as useLife>
                                    <option value="${useLife}"
                                            <#if asset.useLife==useLife >selected </#if>>${useLife}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="useLife">固定资产</label>
                        <div class="col-sm-3">
                            <div class="switch">
                                <#if asset!=null>
                                    <input type="checkbox" name="divideFlag" id="divideFlag"
                                           <#if (asset.divideFlag == true)>checked</#if> />
                                <#else>
                                    <input type="checkbox" name="divideFlag" id="divideFlag"/>
                                </#if>
                                ${asset.d}
                            </div>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="reserveScrapDate">预定报废日</label>
                        <div class="col-sm-10">
                            <div id="reserveScrapDate" class="input-group date form_date col-md-6" data-date=""
                                 data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
                                 data-link-format="yyyy-mm-dd">
                                <input class="form-control" size="16" type="text" readonly
                                       value="<#if asset.reserveScrapDate??>${asset.reserveScrapDate?string('yyyy-MM-dd')}</#if>">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                    </div>
                    <#--<div class="form-group" style="height: 55px">-->
                    <#--<label class="col-sm-2 control-label" for="superiorAssetNo">上级资产</label>-->
                    <#--<div class="col-sm-3">-->
                    <#--<input type="text" id="superiorAssetName" value="${superiorAssetName}" class="form-control"-->
                    <#--placeholder="请选择上级资产" readonly>-->
                    <#--<input type="text" name="superiorAssetNo" hidden id="superiorAssetNo"-->
                    <#--value="${asset.superiorAssetNo}">-->
                    <#--</div>-->
                    <#--<a href="javascript:void(0)" id="superiorAssetChoiceBtn" onclick="openSuperiorAssetTable()"-->
                    <#--class="btn btn-primary"><span class="glyphicon glyphicon-search"></span></a>-->
                    <#--</div>-->
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="keepingDepartmentId">保管部门</label>
                        <div class="col-sm-3">
                            <input type="text" id="keepingDepartmentName" name="keepingDepartmentName"  value="${keepingDepartmentName}"
                                   class="form-control" placeholder="请选择保管部门" readonly>
                            <input type="text" name="keepingDepartmentId"
                                   id="keepingDepartmentId" value="${asset.keepingDepartmentId}" hidden>
                        </div>
                        <a href="javascript:void(0)" id="locationChoiceBtn" onclick="openOrganizationChoiceDig()"
                           class="btn btn-primary"><span class="glyphicon glyphicon-search"></span></a>
                    </div>
                    <#--<div class="form-group" style="height: 55px">-->
                    <#--<label class="col-sm-2 control-label" for="locationId">存放地点</label>-->
                    <#--<div class="col-sm-3">-->
                    <#--<input type="text" id="locationName" value="${locationName}" class="form-control"-->
                    <#--placeholder="请选择存放地点" readonly>-->
                    <#--<input type="text" name="locationId" hidden id="locationId"-->

                    <#--value="${asset.locationId}">-->
                    <#--</div>-->
                    <#--<a href="javascript:void(0)" id="locationChoiceBtn" onclick="openLocationChoiceDig()"-->
                    <#--class="btn btn-primary"><span class="glyphicon glyphicon-search"></span></a>-->
                    <#--</div>-->
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="examineTarget">是否点检</label>
                        <div class="col-sm-3">
                            <div class="switch">
                                <#if (asset.examineTarget??)>
                                    <input type="checkbox" name="examineTarget" id="examineTarget"
                                           <#if (asset.examineTarget == 1)>checked</#if> />
                                <#else>
                                    <input type="checkbox" name="examineTarget" id="examineTarget" checked/>
                                </#if>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="statusProperty">是否报废</label>
                        <div class="col-sm-3">
                            <#if asset!=null>
                                <input type="checkbox"  name="statusProperty" id="statusProperty"
                                        <#if asset.statusProperty==3>
                                checked
                                        </#if>>
                            <#else>
                                <input type="checkbox" name="statusProperty" id="statusProperty">
                            </#if>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="actualScrapDate">实际报废日</label>
                        <div class="col-sm-10">
                            <div id="actualScrapDate" name="actualScrapDate" class="input-group date form_date col-md-6" data-date=""
                                 data-date-format="yyyy-mm-dd" data-link-field="dtp_input2"
                                 data-link-format="yyyy-mm-dd">
                                <input class="form-control" size="16" type="text" readonly
                                       value="<#if asset.actualScrapDate??>${asset.actualScrapDate?string('yyyy-MM-dd')}</#if>">
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="remarks">描述</label>
                        <div class="col-sm-5">
                    <textarea type="text" name="remarks" class="form-control" id="remarks"
                              placeholder="请输入描述">${asset.remarks}</textarea>
                        </div>
                    </div>
                </div>
                <!--tab页内容区分-----------------硬件信息--------------------->
                <div class="tab-pane" id="hardware">
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="pcId">PC类型</label>
                        <div class="col-sm-3">
                            <select name="pcId" id="pcId" class="selectpicker" title="请选择"
                                    data-width="150px">
                                <option value="">请选择</option>
                                <#list pcType as test>
                                    <#if asset!=null >
                                        <#if pcInfo.pcId==test.value>
                                            <option value="${test.value}" selected="selected">${test.label}</option>
                                        <#else>
                                            <option value="${test.value}">${test.label}</option>
                                        </#if>
                                    <#else>
                                        <option value="${test.value}">${test.label}</option>
                                    </#if>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="pc_color">颜色</label>
                        <div class="col-sm-3">
                            <input type="text" name="pc_color" class="form-control" id="pc_color" placeholder="颜色"
                                   value="${pcInfo.color}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="pc_cpuName">CPU</label>
                        <div class="col-sm-3">
                            <input type="text" name="pc_cpuName" class="form-control" id="pc_cpuName" placeholder="处理器"
                                   value="${pcInfo.cpuName}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="pc_size">尺寸</label>
                        <div class="col-sm-3">
                            <input type="text" name="pc_size" class="form-control" id="pc_size" placeholder="请输入电脑尺寸"
                                   value="${pcInfo.size}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="pc_ram">内存容量</label>
                        <div class="col-sm-3">
                            <input type="text" name="pc_ram" class="form-control" id="pc_ram" placeholder="请输入电脑内存容量"
                                   value="${pcInfo.ram}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="pc_ramId">内存类型</label>
                        <div class="col-sm-3">
                            <select name="pc_ramId" id="pc_ramId" class="selectpicker" title="请选择"
                                    data-width="150px">
                                <#list ramType as test>
                                    <#if asset!=null >
                                        <#if pcInfo.ramId==test.value>
                                            <option value="${test.value}" selected="selected">${test.label}</option>
                                        <#else>
                                            <option value="${test.value}">${test.label}</option>
                                        </#if>
                                    <#else>
                                        <option value="${test.value}">${test.label}</option>
                                    </#if>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="hardDiskCapacity1">硬盘容量1</label>
                        <div class="col-sm-3">
                            <input type="text" name="hardDiskCapacity1" class="form-control" id="hardDiskCapacity1"
                                   placeholder="请输入硬盘容量1"
                                   value="${pcInfo.hardDiskCapacity1}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="hardDIskType1">硬盘类型1</label>
                        <div class="col-sm-3">
                            <select name="hardDIskType1" id="hardDIskType1" class="selectpicker" title="请选择"
                                    data-width="150px">
                                <#list hardDiskType as test>
                                    <#if asset!=null >
                                        <#if pcInfo.hardDIskType1==test.value>
                                            <option value="${test.value}" selected="selected">${test.label}</option>
                                        <#else>
                                            <option value="${test.value}">${test.label}</option>
                                        </#if>
                                    <#else>
                                        <option value="${test.value}">${test.label}</option>
                                    </#if>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="hardDiskCapacity2">硬盘容量2</label>
                        <div class="col-sm-3">
                            <input type="text" name="hardDiskCapacity2" class="form-control" id="hardDiskCapacity2"
                                   placeholder="请输入硬盘容量2"
                                   value="${pcInfo.hardDiskCapacity2}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="hardDIskType2">硬盘类型2</label>
                        <div class="col-sm-3">
                            <select name="hardDIskType2" id="hardDIskType2" class="selectpicker" title="请选择"
                                    data-width="150px">
                                <#list hardDiskType as test>
                                    <#if asset!=null >
                                        <#if pcInfo.hardDIskType2==test.value>
                                            <option value="${test.value}" selected="selected">${test.label}</option>
                                        <#else>
                                            <option value="${test.value}">${test.label}</option>
                                        </#if>
                                    <#else>
                                        <option value="${test.value}">${test.label}</option>
                                    </#if>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="VGA">显卡</label>
                        <div class="col-sm-3">
                            <input type="text" name="VGA" class="form-control" id="VGA"
                                   value="${pcInfo.vga}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="MACAddress">MAC地址</label>
                        <div class="col-sm-3">
                            <input type="text" name="MACAddress" class="form-control" id="MACAddress"
                                   value="${pcInfo.macAddress}">
                        </div>
                    </div>
                </div>

                <!--tab页内容区分-----------------net--------------------->
                <div class="tab-pane " id="net">
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="IPV4">IPV4</label>
                        <div class="col-sm-3">
                            <input type="text" name="IPV4" class="form-control" id="IPV4" placeholder="请输入IPV4"
                                   value="${netInfo.ipv4}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="IPV6">IPV6</label>
                        <div class="col-sm-3">
                            <input type="text" name="IPV6" class="form-control" id="IPV6" placeholder="请输入IPV6"
                                   value="${netInfo.ipv6}">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="server_moreInfo">补充说明</label>
                        <div class="col-sm-5">
                                <textarea type="" name="server_moreInfo" class="form-control" id="server_moreInfo"
                                          placeholder="请输入补充说明"
                                >${netInfo.moreInfo}</textarea>
                        </div>
                    </div>
                </div>

                <!--tab页内容区分-----------------software--------------------->
                <div class="tab-pane " id="software">
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="is_asset">是否为资产</label>
                        <div class="col-sm-5">
                            <input type="checkbox" name="is_asset" id="is_asset">
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="soft_name">配件名称</label>
                        <div class="col-sm-5">
                            <input type="text" name="soft_name" class="form-control" id="soft_name"
                                   placeholder="请输入配件名称"
                            >
                            <input type="hidden" id="softAssetNo" name="softAssetNo">
                        </div>
                        <a href="javascript:void(0)" id="softAssetBtn" onclick="openSoftAssetModal()"
                           class="btn btn-primary"><span class="glyphicon glyphicon-search"></span></a>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="softwareId">配件类型</label>
                        <div class="col-sm-3">
                            <select name="softwareId" id="softwareId" class="selectpicker" title="请选择"
                                    data-width="150px">
                                <option value="">请选择</option>
                                <#list softType as test>
                                    <option value="${test.value}">${test.label}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-2 control-label" for="soft_moreInfo">补充说明</label>
                        <div class="col-sm-5">
                                <textarea type="" name="soft_moreInfo" class="form-control" id="soft_moreInfo"
                                          placeholder="请输入补充说明"
                                ></textarea>
                        </div>
                    </div>
                    <div class="form-group" style="height: 55px">
                        <label class="col-sm-1 control-label" for="softTable"></label>
                        <div id="toolbar">
                            <input type="button" onclick="addSoftToTable()" class="btn btn-info" value="添加"/>
                            <input type="button" onclick="removeSoftToTable()" class="btn btn-danger" value="删除"/>
                        </div>
                        <div class="col-sm-8">
                            <table id="softTable" class="table"></table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.box-body -->
        <button type="submit" id="btnConfirm" class="btn btn-primary" style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-floppy-disk"></span>保存
        </button>
        <button type="button" id="btnClose" class="btn btn-default " style="margin-right: 20px;display: none"><span
                    class="glyphicon glyphicon-remove"></span>关闭
        </button>
        <!-- /.box-footer -->
    </form>
</div>

<div class="modal inmodal fade" id="organizationModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="organizationModal">选择存放部门</h4>
            </div>
            <div class="modal-body">
                <ul id="organizationTree" class="ztree">
                </ul>
            </div>
            <div class="modal-footer">
                <button id="closeBtn1" type="button" class="btn btn-primary">确认</button>
                <button id="resetBtn1" type="button" class="btn btn-default">清除</button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade" id="locationModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="locationModal">选择存放场所</h4>
            </div>
            <div class="modal-body">
                <ul id="locationTree" class="ztree">
                </ul>
            </div>
            <div class="modal-footer">
                <button id="closeBtn2" type="button" class="btn btn-default">确认</button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade" id="softAssetModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" name="softAssetModal" id="softAssetModal">选择配件</h4>
            </div>
            <div class="modal-body">
                <form class="form-inline" id="searchForm">
                    <div class="form-group" style="margin-right:20px">
                        <label for="s_login_Name">资产编号</label>
                        <input type="text" class="form-control _search" id="search_like_asset_input_no"
                               name="search_like_asset_input_no">
                    </div>
                    <div class="form-group" style="margin-right:20px">
                        <label for="s_login_Name">资产名</label>
                        <input type="text" class="form-control _search" id="search_like_name" name="search_like_name">
                    </div>
                    <div class="form-group" style="margin-right:20px">
                        <label for="search_eq_classify_id">资产分类</label>
                        <select name="category" id="search_eq_classify_id" class="selectpicker" title="请选择"
                                data-width="150px">
                            <option value="">请选择</option>
                            <#list testType as test>
                                <option value="${test.value}">${test.label}</option>
                            </#list>
                        </select>
                    </div>
                    <a href="javascript:void(0)" class="btn btn-primary"
                       onclick="$('#softAssetTable').bootstrapTable('refresh')">搜索</a>
                </form>
                <table id="softAssetTable" name="softAssetTable" class="table"></table>
            </div>
            <div class="modal-footer">
                <button id="closeBtn3" type="button" class="btn btn-default">确认</button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade" id="superiorAssetModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" name="softAssetModal" id="superiorAssetModal">选择上级资产</h4>
            </div>
            <div class="modal-body">
                <form class="form-inline" id="searchForm">
                    <div class="form-group" style="margin-right:20px">
                        <label for="s_login_Name">资产编号</label>
                        <input type="text" class="form-control _search" id="search_superior_like_asset_input_no"
                               name="search_superior_like_asset_input_no">
                    </div>
                    <div class="form-group" style="margin-right:20px">
                        <label for="s_login_Name">资产名</label>
                        <input type="text" class="form-control _search" id="search_superior_like_name"
                               name="search_superior_like_name">
                    </div>
                    <div class="form-group" style="margin-right:20px">
                        <label for="search_eq_classify_id">资产分类</label>
                        <select name="category" id="search_superior_eq_classify_id" class="selectpicker" title="请选择"
                                data-width="150px">
                            <option value="">请选择</option>
                            <#list testType as test>
                                <option value="${test.value}">${test.label}</option>
                            </#list>
                        </select>
                    </div>
                    <a href="javascript:void(0)" class="btn btn-primary"
                       onclick="$('#superiorAssetTable').bootstrapTable('refresh')">搜索</a>
                    </form>
                <table id="superiorAssetTable" name="superiorAssetTable" class="table"></table>
            </div>
            <div class="modal-footer">
                <button id="closeBtn4" type="button" class="btn btn-default">确认</button>
            </div>
        </div>
    </div>
</div>

<div class="modal inmodal fade" id="supplierModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-inline" id="searchForm">
                <div class="modal-header">
                    <h4 class="modal-title" name="supplierModal" id="supplierModal">选择供应商</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group" style="margin-right:20px">
                        <label for="s_name">供应商名</label>
                        <input type="text" class="form-control _search" name="search_supplier_like_name">
                    </div>
                    <a href="javascript:void(0)" class="btn btn-primary"
                       onclick="$('#supplierTable').bootstrapTable('refresh')">搜索</a>
                    <table id="supplierTable" name="supplierTable" class="table"></table>
                </div>
                <div class="modal-footer">
                    <button id="closeBtn5" type="button" class="btn btn-default">确认</button>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- jQuery 3.3.1 -->
<script src="${base}/static/plugins/jQuery/jquery-3.3.1.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${base}/static/bootstrap/js/bootstrap.js"></script>
<!-- Bootstrap switch -->
<script src="${base}/static/plugins/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${base}/static/plugins/bootstrap-switch/js/bootstrap-switch.js"></script>
<script src="${base}/static/plugins/bootstrap-select/js/bootstrap-select.js"></script>
<script src="${base}/static/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<!-- iCheck 1.0.1 -->
<script src="${base}/static/plugins/iCheck/icheck.min.js"></script>
<!-- Bootstrap Validator -->
<script src="${base}/static/plugins/bootstrapvalidator-master/bootstrapValidator.min.js"></script>
<!-- toastr 信息提示框插件 -->
<script src="${base}/static/plugins/toastr/js/toastr.js"></script>

<script src="${base}/static/plugins/layer/layer.js"></script>

<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.min.js"></script>

<script src="${base}/static/plugins/timepicker/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="${base}/static/plugins/zTree/js/jquery.ztree.all.js"></script>

<script>

    var delIds = [];
    $(document).ready(function () {
        loadSoftTable();

        initSupplierTable();
        locationTree();
        organizationZtree();
        initSuperiorBootstrapTable();

        //switch
        initBootstrapSwitch();

        //初始化 toastr 弹窗位置
        toastr.options.positionClass = 'toast-center-center';
        //初期化
        var id = $('[name="id"]').val();
        if (undefined !== id && null != id && '' != id) {
            //修改
            $('#preNo').val("${asset.classify}");
            $("#sysTime").val("${asset.no}".substring(1, 14));
        } else {
            $('#preNo').val(1);
            if($("#category").val()==""){
                //新增
                var timestamp = Date.parse(new Date());
                $("#sysTime").val(timestamp);
            }else{
                //复制
                $('#preNo').val("${asset.classify}");
                var timestamp = Date.parse(new Date());
                $("#sysTime").val(timestamp);
            }
        }
        <#list softwareInfo as soft >
        var c = $("#softTable").bootstrapTable('getData').length;
        $('#softTable').bootstrapTable('insertRow', {
            index: c, row: {
                'id': "${soft.id}",
                'name': "${soft.name}",
                'softAssetNo':"${soft.softAssetNo}",
                'softwareId': "${soft.softwareId}",
                'assetFlag': "${soft.assetFlag}"?true:false,
                'moreInfo': "${soft.moreInfo}"
            }
        });
        </#list>

        //初期化
        $('#registerDate,#reserveScrapDate,#examineDate,#actualScrapDate').datetimepicker({
            //format: 'yyyy-mm-dd hh:ii:ss',
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        });

        $("#buyDate").datetimepicker({
            //format: 'yyyy-mm-dd hh:ii:ss',
            language: 'zh-CN',
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0,
            endDate: new Date()
        }).on("changeDate", function (rev) {
            $("#buyDate").datetimepicker('hide');
            //$("#assetForm").bootstrapTable("revalidateField", "buyDate");
        });

        initBootstrapTable();
        formValidator();
        //根据是否为分摊对象来设置输入框约束
        if (!"${asset.divideFlag}") {
            $('#assetForm').data("bootstrapValidator").enableFieldValidators("useLife", false, "notEmpty").enableFieldValidators("price", false, "notEmpty").enableFieldValidators("residualProportion", false, "notEmpty");
        }
        //根据资产状态设置输入框约束
        if ("${asset.statusProperty}"!=3) {
            $('#assetForm').data("bootstrapValidator").enableFieldValidators("actualScrapDate", false, "callback")
        }

        $("#category").selectpicker('refresh');
        $("#category").selectpicker('render');
        $("#pcId").selectpicker('refresh');
        $("#pcId").selectpicker('render');
    });

    $("#btnClose").click(function () {
        //清空验证
        $("#assetForm").data('bootstrapValidator').destroy();
        $('#assetForm').data('bootstrapValidator', null);
        var index = parent.layer.getFrameIndex(window.name);
        parent.$("#handle").attr("value", "");
        parent.layer.close(index);
    });

    //类型选择事件
    $('#category').on('change', function () {
        var _val = $(this).val();
        if (_val && _val != '') {
            $('#preNo').val(_val);
            var timestamp = Date.parse(new Date());
            $("#sysTime").val(timestamp);
        }
    })

    //表单验证
    function formValidator() {
        ;
        var id = $('[name="id"]').val();
        var mode = 1;
        if (undefined !== id && null != id && '' != id) {
            mode = 2;
        }
        $('#assetForm').bootstrapValidator({
            message: '输入值不合法',
            /*feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },*/
            excluded: [":disabled"],
            fields: {
                name: {
                    message: '资产名称不合法',
                    validators: {
                        notEmpty: {
                            message: '资产名称不能为空'
                        },
                        stringLength: {/*长度提示*/
                            min: 3,
                            max: 100,
                            message: '资产名称长度必须在3到100之间'
                        },
                    }
                },
                assetInputNo: {
                    validators: {
                        notEmpty: {
                            message: '资产编号不能为空'
                        },
                        stringLength: {/*长度提示*/
                            max: 50,
                            message: '资产编号长度必须小于50'
                        },
                        threshold: 1,
                        remote: {//ajax验证。server result:{"valid",true or false} 向服务发送当前input name值，获得一个json数据。例表示正确：{"valid",true}
                            url: '${base}/ams/asset/checkAssetInputNo/' + mode,//验证地址
                            message: '资产编号已存在',//提示消息
                            delay: 500,//每输入一个字符，就发ajax请求，服务器压力还是太大，设置2秒发送一次ajax（默认输入一个字符，提交一次，服务器压力太大）
                            type: 'POST',//请求方式
                            data: {
                                assetInputNo: $('[name="assetInputNo"]').val(),
                                id: $('[name="id"]').val()
                            }
                        },
                        regexp: {/* 只需加此键值对，包含正则表达式，和提示 */
                            regexp: /^[a-zA-Z0-9-_*=+?'"—;:]+$/,
                            message: '资产编号只能包含字母、数字和部分符号'
                        }
                    }
                },
                price: {
                    validators: {
                        lessThan: {
                            value: 10000000000000,
                            message: '超出范围'
                        },
                        regexp: {
                            regexp: /^(?!0+(?:\.0+)?$)(?:[1-9]\d*|0)(?:\.\d{1,2})?$/,
                            message: '请输入合法的价格'
                        },
                        notEmpty: {
                            message: '价格不能为空'
                        },
                    }
                },
                amount: {
                    validators: {
                        greaterThan: {
                            value: 1,
                            message: '最小输入1'
                        },
                        digits: {
                            message: '请输入数字'
                        },
                    }
                },
                residualProportion: {
                    validators: {
                        lessThan: {
                            value: 100,
                            message: '超出范围'
                        },
                        notEmpty: {
                            message: '净值比例不能为空'
                        }
                    },
                },
                useLife: {
                    validators: {
                        notEmpty: {
                            message: '年限不能为空'
                        },
                        callback: {
                            message: '年份不能小于已使用年份',
                            callback: function (value, validator) {
                                if (value != "") {
                                    if ($('[name="id"]').val() != null && value != null) {
                                        var buyDate = $("#buyDate").data("datetimepicker").getDate();
                                        var nowDate = new Date();
                                        var month = (nowDate.getFullYear() - buyDate.getFullYear()) * 12 + nowDate.getMonth() - buyDate.getMonth();
                                        if (month >= value * 12) {
                                            return false
                                        } else {
                                            return true
                                        }
                                    } else {
                                        return true;
                                    }
                                } else {
                                    return true;
                                }
                            }
                        }
                    }
                },
                buyDate: {
                    trigger: 'change',
                    validators: {
                        callback: {
                            message: '购买日期不能为空',
                            callback: function (value, validator) {
                                if ($("#buyDate").find("input").val() == "") {
                                    return false;
                                } else {
                                    return true;
                                }
                            }
                        }
                    }
                },
                actualScrapDate: {
                    trigger: 'change',
                    validators: {
                        callback: {
                            message: '购买日期不能为空',
                            callback: function (value, validator) {
                                if ($("#actualScrapDate").find("input").val() == "") {
                                    return false;
                                } else {
                                    return true;
                                }
                            }
                        }
                    }
                },
                remarks: {
                    validators: {
                        stringLength: {/*长度提示*/
                            max: 255,
                            message: '长度要在255个字符以内'
                        },
                    }
                },
                keepingDepartmentName: {
                    trigger:"change",
                    validators: {
                        notEmpty: {
                            message: '存放部门不能为空'
                        }
                    }
                },
                locationName: {
                    validators: {
                        stringLength: {/*长度提示*/
                            max: 10,
                            message: '长度要在10个字符以内'
                        },
                    }
                },
                pc_color: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: '长度要在20个字符以内'
                        }
                    }
                },
                pc_size: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: '长度要在20个字符以内'
                        }
                    }
                },
                pc_ram: {
                    validators: {
                        stringLength: {
                            max: 10,
                            message: '长度要在10个字符以内'
                        }
                    }
                },
                pc_cpuName: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: '长度要在20个字符以内'
                        }
                    }
                },
                hardDiskCapacity1: {
                    validators: {
                        stringLength: {
                            max: 10,
                            message: '长度要在10个字符以内'
                        }
                    }
                },
                hardDiskCapacity1: {
                    validators: {
                        stringLength: {
                            max: 10,
                            message: '长度要在10个字符以内'
                        }
                    }
                },
                VGA: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: '长度要在20个字符以内'
                        }
                    }
                },
                MACAddress: {
                    validators: {
                        stringLength: {
                            max: 30,
                            message: '长度要在30个字符以内'
                        }
                    }
                },
                IPV4: {
                    validators: {
                        stringLength: {
                            max: 15,
                            message: '长度要在15个字符以内'
                        }
                    }
                },
                IPV6: {
                    validators: {
                        stringLength: {
                            max: 15,
                            message: '长度要在15个字符以内'
                        }
                    }
                },
                supplierId: {
                    validators: {
                        stringLength: {
                            max: 36,
                            message: '长度要在36个字符以内'
                        }
                    }
                },
                brand: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: '长度要在50个字符以内'
                        }
                    }
                },
                superiorAssetNo: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: '长度要在50个字符以内'
                        }
                    }
                }
            }
        }).on('success.form.bv', function (e) {
            // 设定默认提交方式，防止重复提交
            //alert("验证")
            e.preventDefault();
            var $form = $(e.target);
            //进行表单验证
            var bv = $form.data('bootstrapValidator');
            if (bv.isValid()) {
                if (mode == 1) {
                    layer.confirm("确认后部分数据不能修改，是否继续?", {icon: 3, title: '提示'}, function (index) {
                        layer.close(index);
                        submit(mode);
                    });
                } else {
                    submit(mode);
                }
            }
            $("#btnConfirm").removeAttr("disabled");
        });
    };

    //提交方法
    function submit(mode) {
        //var tab = e.target.toString();
        var upData = {};//asset主体信息

        var formdata = {
            "id": $('[name="id"]').val(),
            "no": $("#preNo").val() + $("#sysTime").val(),
            "assetInputNo": $("#assetInputNo").val().toUpperCase(),
            "name": $("#name").val(),
            "classify": $("#preNo").val(),
            "brand": $("#brand").val(),
            "supplierId": $("#supplierId").val(),
            "price": $("#price").val(),
            "amount": $("#amount").val() == "" ? 1 : $("#amount").val(),
            "useLife": $("#useLife").val(),
            "superiorAssetNo": $("#superiorAssetNo").val(),
            "keepingDepartmentId": $("#keepingDepartmentId").val(),
            "locationId": $("#locationId").val(),
            "registerDate": $("#registerDate").find("input").val() != "" ? timeStampExchange($("#registerDate").data("datetimepicker").getDate()) : null,
            "buyDate": $("#buyDate").find("input").val() != "" ? timeStampExchange($("#buyDate").data("datetimepicker").getDate()) : null,
            "actualScrapDate": $("#actualScrapDate").find("input").val() != "" ? timeStampExchange($("#actualScrapDate").data("datetimepicker").getDate()) : null,
            "reserveScrapDate": $("#reserveScrapDate").find("input").val() != "" ? timeStampExchange($("#reserveScrapDate").data("datetimepicker").getDate()) : null,
            "residualProportion": $('[name="residualProportion"]').val(),
            "qrCodeImg": $("#qrcodeImg").val(),
            "remarks": $("#remarks").val(),
            "examineTarget": $("#examineTarget")[0].checked ? 1 : 2,
            "divideFlag": $("#divideFlag")[0].checked
        }

        var examineFlg = $("#examineTarget")[0].checked;
        var statusFlg = $("#statusProperty")[0].checked;

        if (statusFlg) {
            formdata.statusProperty = 3;
            formdata.discardUserid = "${currentUser.loginName}";
        } else {
            formdata.statusProperty = 1;
        }

        //assetInfo主标信息
        upData.assetData = JSON.stringify(formdata);
        var url = "";
        if (1 == mode) {
            url = "${base}/ams/asset/add";
        } else {
            url = "${base}/ams/asset/edit";
        }

        //pc信息
        if ($("#pcId").val() != null && $("#pcId").val() != "") {

            var pcData = {
                'id': "${pcInfo.id}",
                'assetNo': formdata.assetInputNo,
                'pcId': $("#pcId").val(),
                'color': $("#pc_color").val(),
                'cpuName': $("#pc_cpuName").val(),
                'size': $("#pc_size").val(),
                'ram': $("#pc_ram").val(),
                'ramId': $("#pc_ramId").val(),
                'hardDiskCapacity1': $("#hardDiskCapacity1").val(),
                'hardDIskType1': $("#hardDIskType1").val(),
                'hardDiskCapacity2': $("#hardDiskCapacity2").val(),
                'hardDIskType2': $("#hardDIskType2").val(),
                'vga': $("#VGA").val(),
                'macAddress': $("#MACAddress").val(),
            }
            upData.pcData = JSON.stringify(pcData);
        }

        //net信息
        if ($("#IPV4").val() != null && $("#IPV4").val() != "" || $("#IPV6").val() != null && $("#IPV6").val() != "") {
            var netData = {
                'id': "${netInfo.id}",
                'assetNo': formdata.assetInputNo,
                'ipv4': $("#IPV4").val(),
                'ipv6': $("#IPV6").val(),
                'moreInfo': $("#server_moreInfo").val()
            };
            upData.netData = JSON.stringify(netData);
        }

        if ($("#softTable").bootstrapTable("getData").length > 0) {
            upData.softData = JSON.stringify($("#softTable").bootstrapTable("getData"));
        }
        if (delIds.length > 0) {
            upData.delIds = delIds.join(",");
        }

        $.ajax({
            url: url,
            type: 'post',
            data: upData,
            complete: function (msg) {
                console.log('完成了');
            },
            success: function (result) {
                if (result.success) {
                    //刷新父页面
                    $('button[name="refresh"]', window.parent.document).click();
                    var index = parent.layer.getFrameIndex(window.name);
                    parent.$("#handle").attr("value", mode);
                    parent.layer.close(index);
                } else {
                    toastr.error(result.message);
                }
            }, error: function () {
                toastr.error("错误");
            }
        });
    }


    //日期格式转换
    function timeStampExchange(time) {
        var datetime = new Date();
        datetime.setTime(time);
        var year = datetime.getFullYear();
        var month = datetime.getMonth() + 1 < 10 ? "0"
            + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
        var date = datetime.getDate() < 10 ? "0" + datetime.getDate()
            : datetime.getDate();
        var hour = datetime.getHours() < 10 ? "0" + datetime.getHours()
            : datetime.getHours();
        var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes()
            : datetime.getMinutes();
        var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds()
            : datetime.getSeconds();
        return year + "-" + month + "-" + date + " " + hour + ":" + minute
            + ":" + second;
    }


    //打开选择部门框
    function openOrganizationChoiceDig() {
        $("#organizationModal").modal('show');
    }

    //organization按钮点击
    $("#closeBtn1").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("organizationTree");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            $("#keepingDepartmentId").val(nodes[0].id);
            $("#keepingDepartmentName").val(nodes[0].name).change();
        } else {
            $("#keepingDepartmentId").val(null);
            $("#keepingDepartmentName").val(null).change();
        }
        $('#organizationModal').modal('hide');
    });

    $("#resetBtn1").click(function () {
        $("#keepingDepartmentId").val(null);
        $("#keepingDepartmentName").val(null).change();
        $('#organizationModal').modal('hide');
    })

    //打开locationModal框
    function openLocationChoiceDig() {
        $("#locationModal").modal('show');
    }

    //location按钮点击
    $("#closeBtn2").click(function () {
        var treeObj = $.fn.zTree.getZTreeObj("locationTree");
        var nodes = treeObj.getSelectedNodes();
        if (nodes.length > 0) {
            $("#locationId").val(nodes[0].id);
            $("#locationName").val(nodes[0].name);
        } else {
            $("#locationId").val(null);
            $("#locationName").val(null);
        }

        $('#locationModal').modal('hide');
    });

    //打开选择上级资产
    function openSuperiorAssetTable() {
        $("#superiorAssetModal").modal("show");
    }

    $("#closeBtn4").click(function () {
        var row = $("#superiorAssetTable").bootstrapTable("getSelections");

        if (row.length > 0) {
            $("#superiorAssetNo").val(row[0].assetInputNo);
            $("#superiorAssetName").val(row[0].name);
        } else {
            $("#superiorAssetNo").val(null);
            $("#superiorAssetName").val(null)
        }
        $("#superiorAssetModal").modal("hide");
    });

    //打开选择配件框
    function openSoftAssetModal() {
        $("#softAssetModal").modal("show");
    }

    $("#closeBtn3").click(function () {
        var row = $("#softAssetTable").bootstrapTable("getSelections");
        if (row.length > 0) {
            $("#soft_name").val(row[0].name);
            if ($("#is_asset")[0].checked) {
                $("#softAssetNo").val(row[0].assetInputNo);
            } else {
                $("#softAssetNo").val(null);
            }

        } else {
            $("#soft_name").val(null);
            $("#softAssetNo").val(null);
        }

        $("#softAssetModal").modal("hide");
    });

    //打开供应商modal框
    function openSupplierModal() {
        $("#supplierModal").modal("show")
    }

    $("#closeBtn5").click(function () {
        var row = $("#supplierTable").bootstrapTable("getSelections");
        if (row.length > 0) {
            $("#supplierId").val(row[0].id);
            $("#supplierName").val(row[0].name)
        } else {
            $("#supplierId").val(null);
            $("#supplierName").val(null)
        }
        $("#supplierModal").modal("hide")
    })

    //加载组织树形菜单
    function organizationZtree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false,
            },
            edit: {
                enable: false,
            },
            callback: {
                beforeDrag: function () {
                    return false;
                }
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: 'id',
                    pIdKey: 'pId',
                    rootPid: null
                }
            }
        };
        $.ajax({
            url: '${base}/sys/organization/list',
            type: 'post',
            success: function (data) {
                $.fn.zTree.init($("#organizationTree"), setting, data);
            }
        });
    }

    //加载供应商表
    function initSupplierTable() {
        $('#supplierTable').bootstrapTable({
            url: '${base}/ams/supplier/list',         //请求后台的URL（*）
            method: 'post',                      //请求方式（*）
            striped: true,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            queryParams: function (params) {
                var searchParams = {};
                searchParams["search_like_name"] = $("[name='search_supplier_like_name']").val();
                var sorts = {};
                sorts.createDate = "desc";
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams,
                    "sorts": sorts
                };
                return temp;
            },//传递参数（*）
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            detailView: false,                   //是否显示父子表
            singleSelect:true,
            columns: [{
                checkbox: true
            }, {
                title: '序号',
                align: 'center',
                formatter: function (value, row, index) {
                    var pageSize = $('#supplierTable').bootstrapTable('getOptions').pageSize;     //通过table的#id 得到每页多少条
                    var pageNumber = $('#supplierTable').bootstrapTable('getOptions').pageNumber; //通过table的#id 得到当前第几页
                    return pageSize * (pageNumber - 1) + index + 1;    // 返回每条的序号： 每页条数 *（当前页 - 1 ）+ 序号
                }
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'name',
                title: '供应商名'
            }, {
                field: 'address',
                title: '地址'
            }
            ]
        });
    };

    //加载场所树形菜单
    function locationTree() {
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,//是否显示节点之间的连线
                selectedMulti: false,
            },
            edit: {
                enable: false,
            },
            callback: {
                beforeDrag: function () {
                    return false;
                }
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: 'id',
                    pIdKey: 'pId',
                    rootPid: null
                }
            }
        };
        $.ajax({
            url: '${base}/ams/location/list',
            type: 'post',
            success: function (data) {
                $.fn.zTree.init($("#locationTree"), setting, data);
            }
        });
    }

    //加载上级资产table
    function initSuperiorBootstrapTable() {
        $('#superiorAssetTable').bootstrapTable({
            url: '${base}/ams/asset/list',         //请求后台的URL（*）
            method: 'post',                      //请求方式（*）
            striped: true,                      //是否显示行间隔色
            dataType: "json",                   // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            queryParams: function (params) {
                var searchParams = {};
                searchParams["search_like_asset_input_no"] = $("#search_superior_like_asset_input_no").val()
                searchParams["search_like_name"] = $("#search_superior_like_name").val()
                searchParams["search_eq_classify_id"] = $("#search_superior_eq_classify_id").val()
                var sorts = {};
                sorts.createDate = "desc";
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams,
                    "sorts": sorts
                };
                return temp;
            },//传递参数（*）
            //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            singleSelect: true,                  //单选
            //showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            //height: 600,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [{
                checkbox: true
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'assetInputNo',
                title: '资产编号'
            }, {
                field: 'name',
                title: '资产名称'
            }, {
                field: 'classify',
                title: '资产分类',
                formatter: function (value, row, index) {
                    var re = "";
                    <#list testType as types>
                    if ("${types.value}" == value) {
                        re = "${types.label}";
                    }
                    </#list>
                    return re;
                }
            }]
        });
    };

    //加载配件table（选择配件）
    function initBootstrapTable() {
        $('#softAssetTable').bootstrapTable({
            url: '${base}/ams/asset/list',         //请求后台的URL（*）
            method: 'post',                      //请求方式（*）
            striped: true,                      //是否显示行间隔色
            dataType: "json",                   // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            //contentType:'application/x-www-form-urlencoded; charset=UTF-8',
            queryParams: function (params) {
                var searchParams = {};
                searchParams["search_like_asset_input_no"] = $("#search_like_asset_input_no").val()
                searchParams["search_like_name"] = $("#search_like_name").val()
                searchParams["search_eq_classify_id"] = $("#search_eq_classify_id").val()
                var sorts = {};
                sorts.createDate = "desc";
                var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                    "pageSize": params.pageSize,
                    "pageNumber": params.pageNumber,
                    "searchParams": searchParams,
                    "sorts": sorts
                };
                return temp;
            },//传递参数（*）
            //queryParamsType: "limit", //参数格式,发送标准的RESTFul类型的参数请求
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            singleSelect: true,                  //单选
            //showRefresh: true,                  //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            //height: 600,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
            //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            columns: [{
                checkbox: true
            }, {
                field: 'id',
                title: 'id',
                visible: false
            }, {
                field: 'assetInputNo',
                title: '资产编号'
            }, {
                field: 'name',
                title: '资产名称'
            }, {
                field: 'classify',
                title: '资产分类',
                formatter: function (value, row, index) {
                    var re = "";
                    <#list testType as types>
                    if ("${types.value}" == value) {
                        re = "${types.label}";
                    }
                    </#list>
                    return re;
                }
            }],
            onDblClickRow: function (row) {
                $("#soft_name").val(row.name);
                if($("#is_asset")[0].checked){
                    $("#softAssetNo").val(row.assetInputNo);
                }else{
                    $("#softAssetNo").val(null);
                }
                $("#softAssetModal").modal("hide");
            }
        });
    };

    //加载配件列表（无数据）
    function loadSoftTable() {
        $("#softTable").bootstrapTable({
            //url: '${base}/isms/question/loadQuestionItem',         //请求后台的URL（*）
            //method: 'post',
            striped: true,                      //是否显示行间隔色
            dataType: "json", // 服务器返回的数据类型
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortName: 'sort',
            silent: true,
            sortOrder: "asc",                   //排序方式
            queryParamsType: "",               //查询参数类型，默认是'limit'，注意：如果想获取页面偏移量offset和页面大小pageSize，参数queryParamsType可不配
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            search: false,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: true,                  //是否显示所有的列
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            //height: 600,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
            uniqueId: "id",                     //每一行的唯一标识，一般为主键列
            //showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            toolbar: '#toolbar',
            formatNoMatches: function () {
                return '请添加选项';
            },
            columns: [{
                checkbox: true,
            }, {
                title: '序列',
                field: 'rowNo',
                formatter: function (value, row, index) {
                    row.rowNo = index + 1;
                    return index + 1;
                }
            }, {
                title: 'ID',
                field: 'id',
                visible: false
            }, {
                title: '配件名称',
                field: 'name'
            }, {
                title: '配件编号',
                field: 'softAssetNo',
                visible: false
            }, {
                title: '配件类型',
                field: 'softwareId',
                formatter: function (value, row, index) {
                    var re = "";
                    <#list softType as type >
                    if ("${type.value}" == value) {
                        re = "${type.label}";
                    }
                    </#list>
                    return re;
                }
            }, {
                title: '补充说明',
                field: 'moreInfo',
            }, {
                title: '是否为资产',
                field: 'assetFlag',
                formatter: function (value, row, index) {
                    if(value){
                        return "是";
                    }else{
                        return "否";
                    }
                }
            }]
        });
    }

    //往配件列表中添加数据
    function addSoftToTable() {

        var rows1 = $('#softTable').bootstrapTable('getData');
        var check = true;
        rows1.forEach(function (r, index) {
            if (r.name == $("#soft_name").val()) {
                check = false;
                toastr.warning("该配件已存在");
            }
        });

        var row={
            'name': $("#soft_name").val(),
            'softAssetNo': $("#softAssetNo").val(),
            'softwareId': $("#softwareId").val(),
            'moreInfo': $("#soft_moreInfo").val(),
            'assetFlag': $("#is_asset")[0].checked
        }

        if (check) {
            if ($("#soft_name").val() != "") {
                if ($("#is_asset")[0].checked && $("#softAssetNo").val() != "") {
                    theAjax = $.ajax({
                        url: '${base}/ams/asset/checkSoftAmount',
                        data: {'assetNo': $("#softAssetNo").val()},
                        type: 'post',
                        success: function (ret) {
                            if (ret) {
                                toastr.warning("已超出该配件数量");
                                check = false;
                            }
                        }
                    });
                    $.when(theAjax).done(function () {
                        doInsertRow(check,rows1,row);
                    })
                } else {
                    doInsertRow(check,rows1,row);
                }
            } else {
                toastr.warning("请输入配件名称")
            }

        }

        $("#soft_name").val(null);
        $("#soft_moreInfo").val(null);
    }
    //往softtable添加数据
    function doInsertRow(check,rows1,row) {
        if (check) {
            $("#softTable").bootstrapTable('insertRow', {
                index: rows1.length, row: row
            });
        }
    }


    //从配件table中删除数据
    function removeSoftToTable() {
        var rows = $('#softTable').bootstrapTable('getSelections');
        if (rows.length == 0) {
            toastr.warning("请选择要删除的数据!");
            return;
        }
        rows.forEach(function (r, index) {
            if (r.id != undefined && r.id != null && r.id != "") {
                delIds.push(r.id);
            }
            $('#softTable').bootstrapTable('remove', {
                field: 'name',
                values: rows[index].name
            });
        });
    }

    //根据年限和购买日生成预定报废时间
    function produceReserveScrapDate() {
        if ($("#buyDate").find("input").val() != "" && $("#useLife").val() != "") {
            var buyDate = $("#buyDate").data("datetimepicker").getDate();
            var year = $("#useLife").val();
            var reserveScrapDate = buyDate.setFullYear(buyDate.getFullYear() + Number(year))
            //alert(new Date(reserveScrapDate))
            $("#reserveScrapDate").datetimepicker("setDate", new Date(reserveScrapDate));
        }
    }

    //开关设置
    function initBootstrapSwitch() {
        //有则销毁（Destroy）
        $('input[name="examineTarget"]').bootstrapSwitch('destroy');//定义按钮刷新时可添加，否则可以不加

        //!* bootstrap开关控件，初始化 *!/
        $('input[name="examineTarget"]').bootstrapSwitch({
            onText: "是",      // 设置ON文本
            offText: "否",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor: "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size: "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth: "35"//设置控件宽度
        });

        $('input[name="examineTarget"]').bootstrapSwitch("onSwitchChange", function (event, state) {
            //var ProductId = event.target.defaultValue;
            if (state == true) {
                console.log('是');
                $(this).val(false);
            } else {
                console.log('否');
                $(this).val(true);
            }
        });

        //有则销毁（Destroy）
        $('input[name="statusProperty"]').bootstrapSwitch('destroy');//定义按钮刷新时可添加，否则可以不加

        //!* bootstrap开关控件，初始化 *!/
        $('input[name="statusProperty"]').bootstrapSwitch({
            onText: "是",      // 设置ON文本
            offText: "否",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor: "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size: "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth: "35"//设置控件宽度
        });

        $('input[name="statusProperty"]').bootstrapSwitch("onSwitchChange", function (event, state) {
            //var ProductId = event.target.defaultValue;
            if (state == true) {
                $("#actualScrapDate").datetimepicker("setDate", new Date());
                $('#assetForm').data("bootstrapValidator").enableFieldValidators("actualScrapDate", true, "callback")
                $(this).val(false);
                $("#examineTarget").bootstrapSwitch("state",false)
            } else {
                $("#actualScrapDate").find("input").val(null);
                $('#assetForm').data("bootstrapValidator").enableFieldValidators("actualScrapDate", false, "callback")
                $(this).val(true);
            }
        });

        $("#actualScrapDate").on("change",function () {
            //$("#statusProperty").val(true);
            if($("#actualScrapDate").find("input").val()!=""){
                $("#statusProperty").bootstrapSwitch("state",true)
            }else{
                $("#statusProperty").bootstrapSwitch("state",false)
            }
        })

        //有则销毁（Destroy）
        $('input[name="divideFlag"]').bootstrapSwitch('destroy');//定义按钮刷新时可添加，否则可以不加

        //!* bootstrap开关控件，初始化 *!/
        $('input[name="divideFlag"]').bootstrapSwitch({
            onText: "是",      // 设置ON文本
            offText: "否",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor: "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size: "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth: "35"//设置控件宽度
        });

        $('input[name="divideFlag"]').bootstrapSwitch("onSwitchChange", function (event, state) {
            //var ProductId = event.target.defaultValue;
            if (state == true) {
                $(this).val(false);
                $('#assetForm').data("bootstrapValidator").enableFieldValidators("useLife", true, "notEmpty").enableFieldValidators("price", true, "notEmpty").enableFieldValidators("residualProportion", true, "notEmpty");
            } else {
                $(this).val(true);
                $('#assetForm').data("bootstrapValidator").enableFieldValidators("useLife", false, "notEmpty").enableFieldValidators("price", false, "notEmpty").enableFieldValidators("residualProportion", false, "notEmpty");
            }
        });

        //有则销毁（Destroy）
        $('input[name="is_asset"]').bootstrapSwitch('destroy');//定义按钮刷新时可添加，否则可以不加

        //!* bootstrap开关控件，初始化 *!/
        $('input[name="is_asset"]').bootstrapSwitch({
            onText: "是",      // 设置ON文本
            offText: "否",    // 设置OFF文本
            onColor: "success",// 设置ON文本颜色     (info/success/warning/danger/primary)
            offColor: "default",  // 设置OFF文本颜色        (info/success/warning/danger/primary)
            size: "small",    // 设置控件大小,从小到大  (mini/small/normal/large)
            handleWidth: "35"//设置控件宽度
        });

        $('input[name="is_asset"]').bootstrapSwitch("onSwitchChange", function (event, state) {
            //var ProductId = event.target.defaultValue;
            if (state == true) {
                $(this).val(false);
                $("#soft_name").attr("readonly", true);
                $("#soft_name").val(null);
                $("#softAssetNo").val()
            } else {
                $(this).val(true);
                $("#soft_name").attr("readonly", false);
            }
            $("#softAssetNo").val(null)
        });
    }

</script>
</body>
</html>