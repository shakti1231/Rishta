<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>RISHTA</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="cache-control" content="no-cache, no-store" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.js"></script>
    <script type="text/javascript" src="Scripts/popup.js"></script>
    <script type="text/javascript" src="Scripts/InputValidation.js"></script>
    <meta http-equiv="imagetoolbar" content="no" />
    <link rel="stylesheet" href="Scripts/layout.css" type="text/css" />
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            var id = '#dialog';
            //Get the screen height and width
            var maskHeight = $(document).height();
            var maskWidth = $(window).width();
            //Set heigth and width to mask to fill up the whole screen
            $('#mask').css({ 'width': maskWidth, 'height': maskHeight });
            //transition effect		
            $('#mask').fadeIn(1000);
            $('#mask').fadeTo("slow", 0.8);
            //Get the window height and width
            var winH = $(window).height();
            var winW = $(window).width();
            //Set the popup window to center
            $(id).css('top', winH / 2 - $(id).height() / 2);
            $(id).css('left', winW / 2 - $(id).width() / 2);
            //transition effect
            $(id).fadeIn(2000);
            //if close button is clicked
            $('.window .close').click(function (e) {
                //Cancel the link behavior
                e.preventDefault();
                $('#mask').hide();
                $('.window').hide();
            });
        });

        function LoginCheck() {
            var uid = document.getElementById("<%=txtUserId.ClientID%>").value;
            var pwd = document.getElementById("<%=txtPwd.ClientID%>").value;
            var pwdSmall = /[a-z]/; //SMALL LETTER
            var pwdCap = /[A-Z]/; //CAPITAL LETTER
            var pwdSpl = /[\W_]/; //SPECIAL CHARECTER
            var RegExUID = /^([a-zA-Z_@])$/;


            if (uid == null || uid == "") {
                alert('Please Enter User ID!');
                document.getElementById("<%=txtUserId.ClientID%>").focus();
                document.getElementById("<%=txtPwd.ClientID%>").value = "";
                return false;
            }
            if (uid.length < 8) {
                alert('Minimum Eight Characters are Required!');
                document.getElementById("<%=txtUserId.ClientID%>").focus();
                document.getElementById("<%=txtPwd.ClientID%>").value = "";
                return false;
            }
            if (pwd == null || pwd == "") {
                alert("Please Enter Password!");
                document.getElementById("<%=txtPwd.ClientID%>").value = "";
                document.getElementById("<%=txtPwd.ClientID%>").focus();
                return false;
            }
            if (pwd.length < 6) {
                alert('Minimum Six Characters are Required!');
                document.getElementById("<%=txtPwd.ClientID%>").value = "";
                document.getElementById("<%=txtPwd.ClientID%>").focus();
                return false;
            }
            // GET RANDOM NUMBER FROM HIDDEN FIELD WHICH WILL WORK AS SALT
            //var salt = document.getElementById("<%=hfRandNo.ClientID%>").value;
            // APPLY MD5 ENCRYPTION TO PASSWORD (USER INPUT)        
            var psswd = document.getElementById("<%=txtPwd.ClientID%>").value;
            // ADD RANDOM NUMBER WITH MD5 ENCRYPTED PASSWORD
            //var saltPsswd = salt + psswd;
            // APPLY MD5 ENCRYPTION TO ABOVE
           // var saltPwdHash = MD5(saltPsswd);
            // STORE THE VALUE IN HIDDEN FIELD WHICH WILL BE COMPARED WITH PASSWORD
            document.getElementById("<%=hfPasswd.ClientID%>").value = psswd;
            // REMOVE RANDOM NUMBER AND PASSWORD FROM FORM FIELD OR HIDDEN FIELD SO THAT THOSE CAN NOT TRAVERSE FROM CLIENT
            document.getElementById("<%=hfRandNo.ClientID%>").value = "";
            document.getElementById("<%=txtPwd.ClientID%>").value = "##############";
            return true;
        }

        function CrearValues() {
            document.getElementById("<%=txtPwd.ClientID%>").value = "";
        }
    </script>
</head>
<body>
    <div id="container">
    <div id="header">
        <%--<div style="float:left"><asp:Image ID="Image1" runat="server" ImageUrl="~/Images/rishta-logo.jpg" Height="80px" Width="80px" /></div>--%>
        <div  align="center" style="padding-top:10px;">
        <%--<h1 ><a >WELCOME RISHTA FOOD PRODUCTS</a></h1>
        <br class="clear" />--%>
        <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/es-banner-02.jpg" Width="100%" Height="20%" />
    </div>
    <%--<div style="float:right;"><asp:Image ID="Image2" runat="server" ImageUrl="~/Images/Odisha.jpg" Height="80px" Width="80px" /></div>--%>

    <ul id="topnav">
        <div style="padding-top:10px;" align="center"><Marquee>WELCOME</Marquee></div>
    </ul>
    </div>
    <div id="intro">
    <div class="fl_left"><a href="#"><asp:Image ID="Image3" runat="server" ImageUrl="~/Images/gati45.jpg" Height="350px" Width="550px" /></a></div>
    <div class="fl_right"> 
        <form id="Form1" action="#" method="post" runat="server" autocomplete="off">
            <table border="1" cellpadding="0" cellspacing="0" style="width:100%;background-color:White;" rules="none">
                <tr id="row_errmsg" runat="server"><td colspan="2" align="center"><asp:Label ID="lbl_errmsg" runat="server"></asp:Label></td></tr>
               <%-- <tr>
                    <td style="width:35%">&nbsp;Financial Year&nbsp;&nbsp;</td>
                    <td style="width:65%"><asp:DropDownList ID="ddlYear" runat="server"></asp:DropDownList></td>
                </tr>--%>
                <tr>
                    <td>&nbsp;User ID&nbsp;&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtUserId" runat="server" oncopy="return false" onpaste="return false" oncut="return false" CssClass="textbox" Width="150" MaxLength="20" autocomplete="off" onkeypress="return validate_Input_Login(event);"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="uidReq" runat="server" ControlToValidate="txtUserId" ErrorMessage="Please Provide User ID" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;Password&nbsp;&nbsp;</td>
                    <td>
                        <asp:TextBox ID="txtPwd" runat="server" CssClass="textbox" Width="150" TextMode="Password" MaxLength="20" autocomplete="off" onkeypress="return validate_Input_Passwd(event);"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="pwdReq" runat="server" ControlToValidate="txtPwd" ErrorMessage="Please Provide Password"></asp:RequiredFieldValidator>
                        <asp:HiddenField ID="hfRandNo" runat="server" />
                        <asp:HiddenField ID="hfPasswd" runat="server"/>
                    </td>
                </tr> 
               <%-- <tr>
                    <td>Verification Code</td>
                    <td>
                        <asp:Image ID="captcha" runat="server" />
                    </td>
                </tr>
                <tr>
                <td></td>
                    <td>Enter code as shown above</td>
                </tr>
                <tr>
                    <td></td>
                    <td><asp:TextBox ID="txtCaptcha" runat="server" Width="100" MaxLength="6" style="text-transform: uppercase;"></asp:TextBox></td>
                </tr>--%>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="btnLogin" runat="server" Text="Submit" OnClientClick="return LoginCheck();" OnClick="btnLogin_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Reset" OnClientClick="return CrearValues();" OnClick="btnClear_Click" />
                    </td>
                </tr>      
            </table>
        </form>
        <div style="color:Blue; text-align:center; background-color:White;">
        <asp:Image ID="Image4" runat="server" ImageUrl="~/Images/gati334.jpg" Height="210px" Width="320px" /> </div>
    </div>
    <br class="clear" />
    </div>
    <div id="wrapper">
        <!-- START WRAPPER ############################################################## -->

        <!-- END WRAPPER ############################################################## -->
        <br class="clear" />
    </div>

    <div id="copyright">
        <p class="fl_left"><%--<asp:Image ID="Image4" runat="server" ImageUrl="~/Images/Axis.jpg" Height="50px" Width="150px" />--%></p>
        <p style="float:left; vertical-align:middle; padding-top:18px; padding-left:250px; color:Maroon;"><b>DESIGNED BY RISHTA IT</b></p>
        <p class="fl_right"><asp:Image ID="Image5" runat="server" ImageUrl="~/Images/rishta-logo.jpg" Height="50px" Width="150px"  /></p>
        <br class="clear" />
    </div>
    </div>
</body>
</html>
