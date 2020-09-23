<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta HTTP-EQUIV="Pragma" CONTENT="no-cache" />
    <meta HTTP-EQUIV="Expires" CONTENT="-1" />
    <link rel="shortcut icon" href="images/favicon.png" />
    <link rel="icon" href="images/favicon.png" />
    <title>软件中心 - 花生壳内网版3.0（phddns）</title>
    <link rel="stylesheet" type="text/css" href="index_style.css" />
    <link rel="stylesheet" type="text/css" href="form_style.css" />
    <link rel="stylesheet" type="text/css" href="usp_style.css" />
    <link rel="stylesheet" type="text/css" href="ParentalControl.css">
    <link rel="stylesheet" type="text/css" href="css/element.css">
    <link rel="stylesheet" type="text/css" href="res/softcenter.css">
    <script type="text/javascript" src="/state.js"></script>
    <script type="text/javascript" src="/popup.js"></script>
    <script type="text/javascript" src="/help.js"></script>
    <script type="text/javascript" src="/validator.js"></script>
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" src="/general.js"></script>
    <script type="text/javascript" src="/res/softcenter.js"></script>
    <script type="text/javascript" src="/switcherplugin/jquery.iphone-switch.js"></script>
    
    <script>

        var submitDatas = {};

        function init() {
            show_menu(menu_hook);

            get_dbus_data();

            setTimeout("getDataStatus()", 5000);
        }

        function get_dbus_data() {
            $.ajax({
                type: "GET",
                url: "/_api/phddns",
                dataType: "json",
                async: false,
                success: function (data) {
                    submitDatas = data.result[0];
                    showDataStatus();
                }
            });
        }

        function showDataStatus() {
            $("#phddns_basic_request").val(submitDatas["phddns_basic_request"]);
            $("#phddns_enable").val(submitDatas["phddns_enable"]);

            if (submitDatas["phddns_enable"] == "1") {
                buildIphoneSwitch(submitDatas["phddns_enable"]);
            } else {
                buildIphoneSwitch("0");
            }

            if (submitDatas["phddns_basic_request"] == "00") {
                if (submitDatas['phddns_basic_status'] == "01") {
                    buildIphoneSwitch(1);
                } else if (submitDatas['phddns_basic_status'] == "02") {
                    buildIphoneSwitch(0);
                    $("#status").html("花生壳已关闭");
                } else {
                    buildIphoneSwitch(0);
                    $("#status").html("error");
                }
            }

            if (submitDatas['phddns_basic_status'] == "020") {
                buildIphoneSwitch(0);
                $("#status").html("花生壳已关闭");
            } else if (submitDatas['phddns_basic_status'] == "02") {
                $("#status").html("phddns has already stopped");
            } else if (submitDatas['phddns_basic_status'] == "010") {
                if (submitDatas['phddns_basic_info']) {
                    var sn_code = submitDatas['phddns_basic_info'].split("$")[1].split("=")[1];
                    var status = submitDatas['phddns_basic_info'].split("$")[2].split("=")[1];
                    if (status.length != 0) {
                        if (status = "ONLINE") {
                            $("#status").html("在线");
                        } else if (status = "OFFLINE") {
                            $("#status").html("离线");
                        } else if (status = "RETRY") {
                            $("#status").html("重试");
                        } else {
                            $("#status").html("未知错误");
                        }
                    }

                    if (sn_code.length != 0) {
                        $("#sn").html(sn_code);
                    } else {
                        $("#status").html("获取信息异常");
                        $("#sn").html("（空）");
                    }
                }

            } else if (submitDatas['phddns_basic_status'] == "00") {
                $("#status").html("启动异常");
                $("#sn").html("（空）");
            } else if (submitDatas['phddns_basic_status'] == "") {

            }
        }

        function getDataStatus() {
            $.ajax({
                type: "GET",
                url: "/_api/phddns",
                dataType: "json",
                async: false,
                success: function (data) {
                    submitDatas = data.result[0];
                    showDataStatus();

                    setTimeout("getDataStatus()", 3000);
                }
            });
        }

        function push_data(obj, arg) {
            var id = parseInt(Math.random() * 100000000);
            var postData = { "id": id, "method": "phddns_config.sh", "params": [arg], "fields": obj };
            $.ajax({
                url: "/_api/",
                cache: false,
                type: "POST",
                dataType: "json",
                data: JSON.stringify(postData),
                success: function (response) {
                    if (response.result == id) {
                        refreshpage();
                    }
                }
            });
        }

        function buildIphoneSwitch(x) {
            $('#iphone_phddns_enable').iphoneSwitch(x, function () {

                submitDatas['phddns_enable'] = "1";
                submitDatas['phddns_basic_request'] = "10";

                showLoading(6);
                push_data(submitDatas, 1);

            }, function () {

                submitDatas['phddns_enable'] = "0";
                submitDatas['phddns_basic_request'] = "20";

                showLoading(6);
                push_data(submitDatas, 1);
            });
        }

        function reset_status() {

            submitDatas['phddns_basic_request'] = "30";
            
            showLoading(6);
            push_data(submitDatas, 1);
        }

        function manager() {
            window.open("http://hsk.oray.com/bang/passport/login?sn=" + $("#sn").html())	;
            return false;
        }
function menu_hook(title, tab) {
	tabtitle[tabtitle.length -1] = new Array("", "软件中心", "离线安装", "花生壳内网穿透");
	tablink[tablink.length -1] = new Array("", "Main_Soft_center.asp", "Main_Soft_setting.asp", "Module_phddns.asp");
}
    </script>
</head>

<body onload="init();">
    <div id="TopBanner"></div>
    <div id="Loading" class="popup_bg"></div>
    <iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"> </iframe>
    <form method="POST" name="form" action="/applydb.cgi?p=phddns_" target="hidden_frame">
    <input type="hidden" name="current_page" value="Module_phddns.asp" />
    <input type="hidden" name="next_page" value="Module_phddns.asp" />
    <input type="hidden" name="group_id" value="" />
    <input type="hidden" name="modified" value="0" />
    <input type="hidden" name="action_mode" value=" Refresh " />
    <input type="hidden" name="action_script" value="" />
    <input type="hidden" name="action_wait" value="5" />
    <input type="hidden" name="first_time" value="" />
    <input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>" />
    <input type="hidden" name="SystemCmd" value="phddns_config.sh" />
    <input type="hidden" name="firmver" value="<% nvram_get("firmver"); %>" />
    <input type="hidden" id="phddns_basic_request" name="phddns_basic_request" value="" />
    <input type="hidden" id="phddns_enable" name="phddns_enable" value="" />
    <table class="content" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td width="17">&nbsp;</td>
            <td valign="top" width="202">
                <div id="mainMenu"></div>
                <div id="subMenu"></div>
            </td>
            <td valign="top">
                <div id="tabMenu" class="submenuBlock"></div>
                <table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="left" valign="top">
                            <table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3"
                                class="FormTitle" id="FormTitle">
                                <tr>
                                    <td bgcolor="#4D595D" colspan="3" valign="top">
                                        <div class="formfonttitle">
                                            花生壳内网穿透</div>
                                        <div style="float: right; width: 15px; height: 25px; margin-top: 10px">
                                            <img id="return_btn" onclick="reload_Soft_Center();" align="right" style="cursor: pointer;
                                                position: absolute; margin-left: -30px; margin-top: -25px;" title="返回软件中心" src="/images/backprev.png"
                                                onmouseover="this.src='/images/backprevclick.png'" onmouseout="this.src='/images/backprev.png'">
                                            </img>
                                        </div>
                                        <div style="margin-left: 5px; margin-top: 10px; margin-bottom: 10px">
                                            <!--<img src="/images/New_ui/export/line_export.png">--></div>
                                        <div class="formfontdesc" id="cmdDesc">
                                        </div>
                                        <table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3"
                                            class="FormTable">
                                            <tr>
                                                <th width="20%">
                                                    启用花生壳
                                                </th>
                                                <td>
                                                    <div class="left" style="width: 94px; float: left; cursor: pointer;" id="iphone_phddns_enable">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th width="20%">
                                                    状态：
                                                </th>
                                                <td>
                                                    <span id="status">-</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th width="20%">
                                                    SN码：
                                                </th>
                                                <td>
                                                    <span id="sn">-</span>
                                                </td>
                                            </tr>
                                        </table>
                                        <div class="apply_gen">
                                            <button class="button_gen" onclick="return manager();">管理页面</button>
                                            <button class="button_gen" onclick="return reset_status();">
                                                重置</button>
                                        </div>
                                        <div class="apply_gen">
                                            <img id="loadingIcon" style="display: none;" src="/images/InternetScan.gif"></span>
                                        </div>
                                        <div style="margin-left: 5px; margin-top: 10px; margin-bottom: 10px">
                                            <!--<img src="/images/New_ui/export/line_export.png">--></div>
                                        <div class="KoolshareBottom">
                                            花生壳官网： <a href="https://hsk.oray.com" target="_blank"><i><u>hsk.oray.com</i>
                                             <br />
                                            开放平台： <a href="https://open.oray.com/" target="_blank"><i><u>open.oray.com</i>
                                            <br />
                                            Shell & Web by： <a href="https://www.oray.com" target="_blank"><i>Oray</i></a> & <a href="https://koolshare.cn/space-uid-2380.html" target="_blank"><i>XiaoBao</i></a><br />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td width="10" align="center" valign="top"></td>
        </tr>
    </table>
    <div id="footer"></div>
</body>

</html>
