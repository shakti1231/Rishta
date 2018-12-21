<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
   <title>RISHTA</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="cache-control" content="no-cache, no-store" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.js"></script>
    <script type="text/javascript" src="Scripts/popup.js"></script>
    <script type="text/javascript" src="Scripts/InputValidation.js"></script>
    <meta http-equiv="imagetoolbar" content="no" />
    <link rel="stylesheet" href="Scripts/layout.css" type="text/css" />
    <script src="http://s.codepen.io/assets/libs/modernizr.js" type="text/javascript"></script>
    <link href='http://fonts.googleapis.com/css?family=Raleway:300,200' rel='stylesheet' type='text/css'/>
    <link rel="stylesheet" href="Scripts/reset.css"/>
    <link rel="stylesheet" href="Scripts/style.css"/>
    <link href="Styles/bootstrap.min.css" rel="stylesheet" />
    
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
            var psswd = document.getElementById("<%=txtPwd.ClientID%>").value;
            document.getElementById("<%=hfPasswd.ClientID%>").value = psswd;
            document.getElementById("<%=hfRandNo.ClientID%>").value = "";
            document.getElementById("<%=txtPwd.ClientID%>").value = "##############";
            return true;
        }

        function CrearValues() {
            document.getElementById("<%=txtPwd.ClientID%>").value = "";
        }
    </script>
</head>
<body style="background-color:#13a05e">
    <div class="form">
        <div class="forceColor">
        </div>
        <div class="topbar">
            <div class="spanColor">
            </div>
            
            


            <form id="Form1" action="#" method="post" runat="server">

            <table border="1" cellpadding="0" cellspacing="0" style="width:100%;background-color:White;" rules="none">
                <tr id="row_errmsg" runat="server"><td colspan="2" align="center"><asp:Label ID="lbl_errmsg" runat="server"></asp:Label></td></tr>
               
                <tr>
                    
                    <td>
                        <asp:TextBox ID="txtUserId" class="input" runat="server" oncopy="return false" oncut="return false" MaxLength="50" autocomplete="off" placeholder="Email" onkeypress="return validate_Input_Login(event);" Font-Size="Small" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="uidReq" runat="server" ControlToValidate="txtUserId" ErrorMessage="Please Provide User ID" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    
                    <td>
                        <asp:TextBox class="input" ID="txtPwd" runat="server" placeholder="Password" TextMode="Password" MaxLength="20" autocomplete="off" onkeypress="return validate_Input_Passwd(event);" Font-Size="Small"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="pwdReq" runat="server" ControlToValidate="txtPwd" ErrorMessage="Please Provide Password"></asp:RequiredFieldValidator>
                        <asp:HiddenField ID="hfRandNo" runat="server" />
                        <asp:HiddenField ID="hfPasswd" runat="server"/>
                    </td>
                </tr> 
               
                <tr>
                    <td colspan="2" align="center">
                    <%-- OnClientClick="return LoginCheck();"--%>
                        <asp:Button  class="submit" ID="btnLogin" runat="server" Text="Submit" OnClick="btnLogin_Click" Font-Bold="True" /><br />
                        <asp:Button class="submit" ID="btnClear" runat="server" Text="Reset" OnClick="btnClear_Click" Font-Bold="True" />
                    </td>
                </tr>      
            </table>
        </form>
        </div>
        
    </div>

    <script type="text/javascript" src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script type="text/javascript" src="Scripts/index.js"></script>
</body>
</html>
