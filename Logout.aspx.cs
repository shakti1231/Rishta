using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["User_type"] = "";
        Session["User_type"] = null;
        Session["userid"] = "";
        Session["userid"] = null;
        Session.Abandon();
        Session.Clear();
        Session.RemoveAll();
        Response.Redirect("Default.aspx");

    }
}