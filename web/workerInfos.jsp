<%--
  Created by IntelliJ IDEA.
  User: 枫
  Date: 2021/5/30
  Time: 17:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8"  %>
<%@ page pageEncoding="utf-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="syy.util.DbUtils" %>
<!doctype html>
<html lang="zh-CN" data-toggle="table">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap 101 Template</title>
    <link href="bootstrap3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/html5shiv@3.7.3/dist/html5shiv.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/respond.js@1.4.2/dest/respond.min.js"></script>

</head>
<body>
<script src="jquery-3.6.0.min.js" type="text/javascript"></script>
<script src="bootstrap3.3.7/js/bootstrap.min.js" type="text/javascript"></script>
<script>
    function modify(initCode) {
        var inputSiteName = $("#siteName2").val();
        var inputWorkerCode = $("#workerCode2").val();
        var inputWorkerName = $("#workerName2").val();
        var inputWorkerSex = $("#workerSex2").val();
        var inputWorkerBirthday = $("#workerBirthday2").val();
        var inputWorkerAddress = $("#workerAddress2").val();
        var inputWorkerPhone = $("#workerPhone2").val();
        var inputWorkerJob = $("#workerJob2").val();
        var inputWorkerPosition = $("#workerPosition2").val();
        var inputRegisterTime = $("#registerTime2").val();
        var inputworkerPhoto = $("#saveUrl2").val()
        if (inputSiteName == null || inputSiteName == "") {
            alert("工地名称不能为空！");
            return false;
        }
        if (inputworkerPhoto == null || inputworkerPhoto == "") {
            alert("工人照片不能为空！");
            return false;
        }
        if (inputWorkerCode == null || inputWorkerCode == "") {
            alert("工人编码不能为空！");
            return false;
        }
        if (inputWorkerName == null || inputWorkerName == "") {
            alert("工人姓名不能为空！");
            return false;
        }
        if (inputWorkerSex == null || inputWorkerSex == "") {
            alert("工人性别不能为空！");
            return false;
        }
        if (inputWorkerBirthday == null || inputWorkerBirthday == "") {
            alert("工人生日不能为空！");
            return false;
        }
        if (inputWorkerAddress == null || inputWorkerAddress == "") {
            alert("联系地址不能为空！");
            return false;
        }
        if (inputWorkerPhone == null || inputWorkerPhone == "") {
            alert("联系方式不能为空！");
            return false;
        }
        if (inputWorkerJob == null || inputWorkerJob == "") {
            alert("工人工种不能为空！");
            return false;
        }
        if (inputWorkerPosition == null || inputWorkerPosition == "") {
            alert("工人职务不能为空！");
            return false;
        }
        if (inputWorkerPosition == null || inputWorkerPosition == "") {
            alert("工人工种不能为空！");
            return false;
        }
        if (inputRegisterTime == null || inputRegisterTime == "") {
            alert("注册时间不能为空！");
            return false;
        }
        if (isNaN(parseInt(inputWorkerPhone))) {
            alert("联系方式仅允许输入数字！");
            return false;
        }

        if (inputWorkerPhone.length != 11) {
            alert("联系方式不为11位！");
            return false;
        }
        var DATE_FORMAT1 = /^[0-9]{4}-[0-1]?[0-9]{1}-[0-3]?[0-9]{1}$/;
        if (!DATE_FORMAT1.test(inputWorkerBirthday)) {
            alert("抱歉，您输入的生日格式有误，正确格式应为\"2012-01-01\"");
            return false;
        }
        var DATE_FORMAT2 = /^20[012]\d-[01]\d-[0123]\d\s\d\d:\d\d:\d\d$/;
        var DATE_FORMAT3 = /^20[012]\d-[01]\d-[0123]\d\s\d\d:\d\d:\d\d.\d$/;
        if (DATE_FORMAT2.test(inputRegisterTime) == false && DATE_FORMAT3.test(inputRegisterTime) == false) {
            alert("抱歉，您输入的注册时间格式有误，正确格式应为\"2012-01-01 17:20:30\"或\"2012-01-01 17:20:30.0\"");
            return false;
        }
        var modifydate = {
            "siteName": inputSiteName,
            "workerCode": inputWorkerCode,
            "workerName": inputWorkerName,
            "workerSex": inputWorkerSex,
            "workerBirthday": inputWorkerBirthday,
            "workerAddress": inputWorkerAddress,
            "workerPhone": inputWorkerPhone,
            "workerJob": inputWorkerJob,
            "workerPosition": inputWorkerPosition,
            "registerTime": inputRegisterTime,
            "workerPhoto": inputworkerPhoto,
            "initCode": initCode,
        };
        var judgeRepeat = 0;
        $.ajax({
            url: "modifyServlet2",
            type: "POST",
            data: modifydate,
            dateType: "JSON",
            success: function (data) {
                var string = data.replace("/\\","");
                var getDataArray = JSON.parse(string);
                var flag = getDataArray.flag;
                var flag1 = "true";
                if (flag === flag1) {
                    judgeRepeat = 1;
                    alert("该工人编号重复，请修改为其他值");
                }
                if(judgeRepeat === 0) {
                    var workers = JSON.parse(data);
                    var str = "";
                    for (var i = 0; i < workers.length; i++) {

                        str += "<tr>";
                        var worker = workers[i];
                        for (var key in worker) {
                            str += "<td>" + worker[key] + "</td>";
                        }
                        str += "<td><a href=\"#modifyModal\" data-toggle=\"modal\" class=\"modify\" name=\"increase\">修改</a> <a href=\"\"  class=\"delete\" name=\"del\">删除</a></td>";
                        str += "</tr>";
                    }

                    $("#tableText").html(str);
                }
            },
            error:function(e){
                alert("错误！！");
            }
        })
    }

    function upload(){
        var form = new FormData(document.getElementById("frm"));
        $.ajax({
            url:"FileUploadServlet",
            type:"post",
            data:form,
            processData:false,
            contentType:false,
            success:function(data){
                var data1=JSON.parse(data);
                var prevDiv = document.getElementById("preview");
                prevDiv.innerHTML = '<img src="' + data1.url + '" class="img-responsive"  />';
                $("#saveUrl").val(data1.url);
            },
            error:function(e){
                alert("错误！！");
            }
        });
    }
    function upload2() {
        var form2 = new FormData(document.getElementById("frm1"));

        $.ajax({
            url: "FileUploadServlet",
            type: "post",
            data: form2,
            processData: false,
            contentType: false,
            success: function (data) {
                var data1 = JSON.parse(data);
                var prevDiv2 = document.getElementById("preview2");
                prevDiv2.innerHTML = '<img src="' + data1.url + '" class="img-responsive"  />';
                $("#saveUrl2").val(data1.url);
            },
            error: function (e) {
                alert("错误！！");
            }
        });
    }

    function query() {
        var jsondate = {
            "siteName": $("#siteName").val(),
            "workerName": $("#workerName").val()
        };
        $.ajax({
            url: "workinfosServlet",
            type: "POST",
            data: jsondate,
            dateType: "JSON",
            success: function (data) {
                var workers=JSON.parse(data);
                var str ="";
                for(var i=0;i<workers.length;i++)
                {

                    str += "<tr>" ;
                    var worker = workers[i];
                    for(var key in worker){
                        str += "<td>" + worker[key] + "</td>" ;
                    }
                    // str += "<td><a href=\"#myModal\" data-toggle=\"modal\" class=\"add\" name=\"increase\">修改</a> <a href=\"#deleteModal\" data-toggle=\"modal\" class=\"delete\" name=\"del\">删除</a></td>";
                    str += "<td><a href=\"#modifyModal\" data-toggle=\"modal\" class=\"modify\" name=\"increase\">修改</a> <a href=\"\"  class=\"delete\" name=\"del\">删除</a></td>";
                    str += "</tr>" ;
                }

                $("#tableText").html(str);
            },
            error: function () {
                alert("出错了");
            }
        })
    }    //查询
    function FreshandAdd(){
        document.getElementById("frm").reset();
        var prevDiv = document.getElementById("preview");
        prevDiv.innerHTML = '';
        $("#sava").off().click(function (){
            add();
        })
    }    //清空模态框

    function add() {    //新增
        var inputSiteName = $("#siteName1").val();
        var inputWorkerCode = $("#workerCode1").val();
        var inputWorkerName = $("#workerName1").val();
        var inputWorkerSex = $("#workerSex1").val();
        var inputWorkerBirthday = $("#workerBirthday1").val();
        var inputWorkerAddress = $("#workerAddress1").val();
        var inputWorkerPhone = $("#workerPhone1").val();
        var inputWorkerJob = $("#workerJob1").val();
        var inputWorkerPosition = $("#workerPosition1").val();
        var inputRegisterTime = $("#registerTime1").val();
        var inputworkerPhoto = $("#saveUrl").val();
        if (inputSiteName == null || inputSiteName == "") {
            alert("工地名称不能为空！");
            return false;
        }
        if (inputworkerPhoto == null || inputworkerPhoto == "") {
            alert("工人照片不能为空！");
            return false;
        }
        if (inputWorkerCode == null || inputWorkerCode == "") {
            alert("工人编码不能为空！");
            return false;
        }
        if (inputWorkerName == null || inputWorkerName == "") {
            alert("工人姓名不能为空！");
            return false;
        }
        if (inputWorkerSex == null || inputWorkerSex == "") {
            alert("工人性别不能为空！");
            return false;
        }
        if (inputWorkerBirthday == null || inputWorkerBirthday == "") {
            alert("工人生日不能为空！");
            return false;
        }
        if (inputWorkerAddress == null || inputWorkerAddress == "") {
            alert("联系地址不能为空！");
            return false;
        }
        if (inputWorkerPhone == null || inputWorkerPhone == "") {
            alert("联系方式不能为空！");
            return false;
        }
        if (inputWorkerJob == null || inputWorkerJob == "") {
            alert("工人工种不能为空！");
            return false;
        }
        if (inputWorkerPosition == null || inputWorkerPosition == "") {
            alert("工人职务不能为空！");
            return false;
        }
        if (inputWorkerPosition == null || inputWorkerPosition == "") {
            alert("工人工种不能为空！");
            return false;
        }
        if (inputRegisterTime == null || inputRegisterTime == "") {
            alert("注册时间不能为空！");
            return false;
        }
        if (isNaN(parseInt(inputWorkerPhone))) {
            alert("联系方式仅允许输入数字！");
            return false;
        }

        if (inputWorkerPhone.length != 11) {
            alert("联系方式不为11位！");
            return false;
        }
        var DATE_FORMAT1 = /^[0-9]{4}-[0-1]?[0-9]{1}-[0-3]?[0-9]{1}$/;
        if (!DATE_FORMAT1.test(inputWorkerBirthday)) {
            alert("抱歉，您输入的生日格式有误，正确格式应为\"2020-01-01\"");
            return false;
        }
        var DATE_FORMAT2 = /^20[012]\d-[01]\d-[0123]\d\s\d\d:\d\d:\d\d$/;
        var DATE_FORMAT3 = /^20[012]\d-[01]\d-[0123]\d\s\d\d:\d\d:\d\d.\d$/;
        if (DATE_FORMAT2.test(inputRegisterTime) == false && DATE_FORMAT3.test(inputRegisterTime) == false) {
            alert("抱歉，您输入的注册时间格式有误，正确格式应为\"2020-01-01 17:20:30\"或\"2020-01-01 17:20:30.0\"");
            return false;
        }
        var adddate = {
            "siteName": inputSiteName,
            "workerCode": inputWorkerCode,
            "workerName": inputWorkerName,
            "workerSex": inputWorkerSex,
            "workerBirthday": inputWorkerBirthday,
            "workerAddress": inputWorkerAddress,
            "workerPhone": inputWorkerPhone,
            "workerJob": inputWorkerJob,
            "workerPosition": inputWorkerPosition,
            "registerTime": inputRegisterTime,
            "workerPhoto": inputworkerPhoto,
        };
        var judgeRepeat = 0;
        $.ajax({
            url: "addServlet",
            type: "POST",
            data: adddate,
            dateType: "JSON",
            success: function (data) {
                var string = data.replace("/\\", "");
                var getDataArray = JSON.parse(string);
                var flag = getDataArray.flag;
                var flag1 = "true";
                if (flag === flag1) {
                    judgeRepeat = 1;
                    alert("请确认新增工人的编号，数据库中已存在该编号");
                }
                if(judgeRepeat===0){
                    var worker = JSON.parse(data);
                    var str = "";
                    str += "<tr>";
                    for (var key in worker) {
                        str += "<td>" + worker[key] + "</td>";
                    }
                    str += "<td><a href=\"#modifyModal\" data-toggle=\"modal\" class=\"modify\" name=\"modi\">修改</a> <a href=\"\"  class=\"delete\" name=\"del\">删除</a></td>";
                    str += "</tr>";
                    $("#tableText").append(str);
                }
            },
            error: function () {
                alert("出错了");
            }
        })
    }     //新增

    $(function () {                                      //修改
        $("#tableText").on('click','.modify',function(){
            //获得当前行
            var currentRow=$(this).closest("tr");
            var workerCode=currentRow.find("td:eq(1)").text();
            var workerBirthday=currentRow.find("td:eq(3)").text();
            var registerTime=currentRow.find("td:eq(4)").text();
            var modifydate = {
                "workerCode": workerCode
            }
            $.ajax({
                url: "modifyServlet",
                type: "POST",
                data: modifydate,
                dateType: "JSON",
                success: function (data) {
                    var all=JSON.parse(data);
                    $("#siteName2").val(all.siteName);
                    $("#workerCode2").val(all.workerCode);
                    $("#workerName2").val(all.workerName);
                    $("#workerSex2").val(all.workerSex);
                    $("#workerBirthday2").val(workerBirthday);
                    $("#workerAddress2").val(all.workerAddress);
                    $("#workerPhone2").val(all.workerPhone);
                    $("#workerJob2").val(all.workerJob);
                    $("#workerPosition2").val(all.workerPosition);
                    $("#registerTime2").val(registerTime);
                    $("#saveUrl2").val(all.workerPhoto);
                    // $("#workerPhoto1").val(all.workerPhoto);
                    var prevDiv2 = document.getElementById("preview2");
                    prevDiv2.innerHTML = '<img src="' + all.workerPhoto + '" class="img-responsive"/>';
                },
                error: function () {
                    alert("出错了");
                }
            })
            $("#sava2").off().click(function (){
                modify(workerCode);
            })
        })
    })
    $(function () {                                      //删除
        $("#tableText").on('click','.delete',function(){
            //获得当前行
            var currentRow=$(this).closest("tr");
            var workerCode=currentRow.find("td:eq(1)").text();
            var deletedate = {
                "workerCode":workerCode
            };
            //
            if (confirm("您真的确定要删除吗？")==true){            //弹出按钮判断是否删除，点击确认继续执行js
                $.ajax({
                    url: "deleteServlet",
                    type: "POST",
                    data: deletedate,
                    dateType: "JSON",
                    success: function (data) {
                        alert("删除成功");
                    },

                    error: function () {
                        // alert("出错了");
                    }
                })
            }else{
                return false;
            }
            // }

        });
    })            //删除
</script>
<div class="container">

    <form role="form" class="form-inline" method="post" >
        <fieldset>
            <legend>查询条件</legend>
            <div class="form-group">
                <label for="siteName">工地名称:</label>
                <input type="text" class="form-control" id="siteName" name="siteName">
            </div>
            <div class="form-group col-sm-offset-1">
                <label for="workerName">工人姓名:</label>
                <input type="text" class="form-control" id="workerName" name="workerName">
            </div>
            <div class="form-group col-sm-offset-1">
                <button type="button" class="btn btn-primary" onclick="query()">查询</button>
            </div>
            <button  type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" onclick="FreshandAdd()">新增</button>
        </fieldset>
    </form>
    <br/>
    <h3 class="bg-info">查询结果</h3>
    <table data-toggle="table" class='table table-hover'>
        <thead>
        <tr class='info'>
            <th> 工人姓名 </th>
            <th> 工人编码 </th>
            <th> 工地名称 </th>
            <th> 工人生日 </th>
            <th> 注册时间 </th>
            <th> 操作    </th>
        </tr>
        </thead>
        <tbody id="tableText" >
        <%
            String sql = "select * from WorkerInfo";

            try (Connection conn = DbUtils.getConnection();
                 PreparedStatement st = conn.prepareStatement(sql)) {
                try (ResultSet rs = st.executeQuery()) {
                    while (rs.next()) { %>
        <tr>
            <td><%=rs.getString(4)%></td>
            <td id="codeWorker"><%=rs.getString(3)%></td>
            <td><%=rs.getString(2)%></td>
            <td><%=rs.getDate(6)%></td>
            <td><%=rs.getTimestamp(11)%></td>
            <%--                            <td><a  href="#myModal" data-toggle="modal" class="add" name="increase" >修改</a> <a href='' class="delete" name="del">删除</a></td>--%>
            <%--            <td><a href="#myModal" data-toggle="modal" class="modify" name="modi" >修改</a> <a href='#deleteModal' data-toggle="modal" class="delete" name="del">删除</a></td>--%>
            <td><a href="#modifyModal" data-toggle="modal" class="modify" name="modi" >修改</a> <a href='' class="delete" name="del">删除</a></td>
        </tr>

        <%   }
        } catch (Exception inEx) {
            inEx.printStackTrace();
        }
        } catch (Exception e) {
            e.printStackTrace();
        }
        %>
        </tbody>
    </table>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">请输入</h4>
                </div>
                <div class="modal-body">
                    <form class="form-inline" role="form" id="frm" method="post" action="FileUploadServlet"
                          enctype="multipart/form-data">
                        <fieldset>
                            <div class="row">
                                <div class="col-lg-6">
                                    <label class="control-label">工地名称(*)：</label>
                                    <select id="siteName1" name="siteName1" class="form-control">
                                        <option value="">请选择</option>
                                        <option value="天悦容城工程">天悦容城工程</option>
                                        <option value="碧桂园工程">碧桂园工程</option>
                                        <option value="世茂工程">世茂工程</option>
                                        <option value="寰宇工程">寰宇工程</option>
                                        <option value="绿地工程">绿地工程</option>
                                    </select>
                                </div>
                                <div class="col-lg-4" id="preview">
                                </div>
                                <input type="text" style="display: none" id="saveUrl"/>
                                <label for="workerPhoto1"
                                       class="glyphicon glyphicon-folder-open"><span> 图片上传 </span></label>
                                <input type="file" name="workerPhoto1" id="workerPhoto1" style="display: none"
                                       class="file-uploading" onchange="upload()"/>
                            </div>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">工人编码(*)：</label>
                                <input type="text" class="form-control" id="workerCode1" name="workerCode1"/>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">工人姓名(*)：</label>
                                <input type="text" class="form-control" id="workerName1" name="workerName1"/>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">工人性别(*)：</label>
                                <select id="workerSex1" name="workerSex1" class="form-control">
                                    <option value=""></option>
                                    <option value="男">男</option>
                                    <option value="女">女</option>
                                </select>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">工人生日(*)：</label>
                                <input type="text" class="form-control" id="workerBirthday1" name="workerBirthday1"
                                       placeholder="请填写工人生日..."/>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">联系电话(*)：</label>
                                <input type="text" class="form-control" id="workerPhone1" name="workerPhone1"/>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">联系地址(*)：</label>
                                <input type="text" class="form-control" id="workerAddress1" name="workerAddress1"/>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">工人工种(*)：</label>
                                <select id="workerJob1" name="workerJob1" class="form-control">
                                    <option value="请选择">请选择</option>
                                    <option value="砌筑工">砌筑工</option>
                                    <option value="木工">木工</option>
                                    <option value="钳工">钳工</option>
                                    <option value="电焊工">电焊工</option>
                                    <option value="测量工">测量工</option>
                                </select>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">工人职务(*)：</label>
                                <select id="workerPosition1" name="workerPosition1" class="form-control">
                                    <option value="请选择">请选择</option>
                                    <option value="建筑工人">建筑工人</option>
                                    <option value="监理">监理</option>
                                    <option value="安全员">安全员</option>
                                    <option value="标准员">标准员</option>
                                    <option value="包工头">包工头</option>
                                </select>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">注册时间(*)：</label>
                                <input type="text" class="form-control" id="registerTime1" name="registerTime1"/>
                            </div>
                            <br/>
                            <br/>
                        </fieldset>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><span
                            class="glyphicon glyphicon-remove" aria-hidden="true"></span>取消
                    </button>
                    <button type="button" class="btn btn-primary" id="sava" data-dismiss="modal"><span
                            class="glyphicon glyphicon-ok" aria-hidden="true"></span>保存
                    </button>
                </div>
            </div>
        </div>
    </div>
    <%--    修改模态框--%>
    <div class="modal fade" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="modifyModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="modifyModalLabel">请输入</h4>
                </div>
                <div class="modal-body">
                    <form class="form-inline" role="form" id="frm1" method="post" action="FileUploadServlet"
                          enctype="multipart/form-data">
                        <fieldset>
                            <div class="row">
                                <div class="col-lg-6">
                                    <label class="control-label">工地名称(*)：</label>
                                    <select id="siteName2" name="siteName1" class="form-control">
                                        <option value="">请选择</option>
                                        <option value="天悦容城工程">天悦容城工程</option>
                                        <option value="碧桂园工程">碧桂园工程</option>
                                        <option value="世茂工程">世茂工程</option>
                                        <option value="寰宇工程">寰宇工程</option>
                                        <option value="绿地工程">绿地工程</option>
                                    </select>
                                </div>
                                <div class="col-lg-4" id="preview2">
                                </div>
                                <input type="text" style="display: none" id="saveUrl2"/>
                                <label for="workerPhoto2"
                                       class="glyphicon glyphicon-folder-open"><span> 图片上传 </span></label>
                                <input type="file" name="workerPhoto2" id="workerPhoto2" style="display: none"
                                       class="file-uploading" onchange="upload2()"/>
                            </div>
                            <%--                            <br/>--%>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">工人编码(*)：</label>
                                <input type="text" class="form-control" id="workerCode2" name="workerCode2"/>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">工人姓名(*)：</label>
                                <input type="text" class="form-control" id="workerName2" name="workerName2"/>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">工人性别(*)：</label>
                                <select id="workerSex2" name="workerSex2" class="form-control">
                                    <option value=""></option>
                                    <option value="男">男</option>
                                    <option value="女">女</option>
                                </select>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">工人生日(*)：</label>
                                <input type="text" class="form-control" id="workerBirthday2" name="workerBirthday2"
                                       placeholder="请填写工人生日..."/>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">联系电话(*)：</label>
                                <input type="text" class="form-control" id="workerPhone2" name="workerPhone2"/>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">联系地址(*)：</label>
                                <input type="text" class="form-control" id="workerAddress2" name="workerAddress2"/>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">工人工种(*)：</label>
                                <select id="workerJob2" name="workerJob2" class="form-control">
                                    <option value="请选择">请选择</option>
                                    <option value="砌筑工">砌筑工</option>
                                    <option value="木工">木工</option>
                                    <option value="钳工">钳工</option>
                                    <option value="电焊工">电焊工</option>
                                    <option value="测量工">测量工</option>
                                </select>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">工人职务(*)：</label>
                                <select id="workerPosition2" name="workerPosition2" class="form-control">
                                    <option value="请选择">请选择</option>
                                    <option value="建筑工人">建筑工人</option>
                                    <option value="监理">监理</option>
                                    <option value="安全员">安全员</option>
                                    <option value="标准员">标准员</option>
                                    <option value="包工头">包工头</option>
                                </select>
                            </div>
                            <br/>
                            <br/>
                            <div class="form-group">
                                <label class="control-label">注册时间(*)：</label>
                                <input type="text" class="form-control" id="registerTime2" name="registerTime2"/>
                            </div>
                            <br/>
                            <br/>
                        </fieldset>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal"><span
                            class="glyphicon glyphicon-remove" aria-hidden="true"></span>取消
                    </button>
                    <button type="button" class="btn btn-primary" id="sava2" data-dismiss="modal"><span
                            class="glyphicon glyphicon-ok" aria-hidden="true"></span>保存
                    </button>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
<html>

