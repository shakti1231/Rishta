using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Web.SessionState;
using System.Security.Cryptography;
using DataAccessLayer;
using System.Text.RegularExpressions;


public partial class Login : System.Web.UI.Page
{
    IDBManager db = new DBManager(DataProvider.SqlServer, ConfigurationManager.ConnectionStrings["DataConnString"].ConnectionString);
    UtilityLibrary utl = new UtilityLibrary();
    protected const string passwordMask = "********************";

     // CLEAR CACHE
       
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.AppendHeader("Pragma", "no-cache");
        Response.AppendHeader("Pragma", "no-store");
        Response.AppendHeader("cache-control", "no-cache , no-store, private, must-revalidate");
        Response.AppendHeader("Expires", "0");
        //
        txtUserId.Focus();
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        DataSet dt = new DataSet();
        db.Open();
        try
        {
            if (Page.IsValid)
            {
                if (User_ID_Validate(txtUserId.Text.Trim()) == true)
                {
                    //string strSaltPwd = "";
                    //strSaltPwd = hdn_Password.Value.ToString().Trim();
                    if (txtUserId.Text == "")
                    {
                        throw new ApplicationException("UserId Must not be blank");
                    }
                    if (txtPwd.Text == "")
                    {
                        throw new ApplicationException("Password Must not be blank");
                    }

                    else
                    {
                        string uid = txtUserId.Text.Trim();
                       // dt = db.Returndata("select password,USER_Role,USERID from Users  where USERID='" + uid + "'");
                        dt = db.ExecuteDataSet(CommandType.Text, "select password,USER_Role,USERID from Users  where USERID='" + uid + "'");
                        if (dt.Tables[0].Rows.Count > 0)
                        {
                            string pwd;
                            pwd = hfPasswd.Value.ToString().Trim();
                            string dbPsswd = dt.Tables[0].Rows[0]["password"].ToString();//dsUser.Tables[0].Rows[0]["password"].ToString();
                            if (pwd == dbPsswd)
                            {
                                string USER_Role = dt.Tables[0].Rows[0]["USER_Role"].ToString().Trim(); //dsUser.Tables[0].Rows[0]["USER_TYPE"].ToString().Trim();
                                string user_id = dt.Tables[0].Rows[0]["USERID"].ToString().Trim();
                                System.Web.Security.FormsAuthenticationTicket ticket1 = null;
                                ticket1 = new System.Web.Security.FormsAuthenticationTicket(1, "Test", DateTime.Now, DateTime.Now.AddSeconds(5), false, "");
                                string encryptedText = System.Web.Security.FormsAuthentication.Encrypt(ticket1);
                                HttpCookie MSME = new HttpCookie("MSME", encryptedText);
                                Response.Cookies.Add(MSME);
                                Session["Authcookie"] = encryptedText;
                                //For Session Fixation ends
                               // Session["xyz"] = txtUid.Text.Trim();
                                if (user_id != null)
                                {
                                    Session["userid"] = user_id;
                                }
                                if (USER_Role == "ADM")
                                {
                                    Session["User_type"] = "ADM";
                                    Response.Redirect("~/user/entrepreneurwelcome.aspx", false);
                                }
                            }
                            else
                            {
                                lbl_errmsg.Text = "Either UserId or Password is Wrong!";
                                txtUserId.Text = "";
                                txtPwd.Text = "";
                               // txtCaptcha.Text = "";
                            }
                        }
                        else
                        {
                            lbl_errmsg.Text = "Either UserId or Password is Wrong!";
                            //GenerateRandom();
                            //hdn_Password.Value = "";
                            txtUserId.Text = "";
                            txtPwd.Text = "";
                            //txtCaptcha.Text = "";
                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "asyncPostBack", "alert('Inalid Userid ');", true);
                }
            }
        }
        catch (ApplicationException ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "asyncPostBack", "alert('" + ex.Message + "');", true);
        }
        catch (Exception exception)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "asyncPostBack", "alert('Error Executing the Request. Please Contact Site Administrator for Details!');", true);
           //ExceptionHandler.WriteException(exception.Message);
        }
        finally
        {
            dt.Clear();
            dt.Dispose();
        }
    }

    protected void btnClear_Click(object sender, System.EventArgs e)
    {

        txtUserId.Text = "";
        txtPwd.Text = "";
        hfPasswd.Value = "";
        //txtCaptcha.Text = "";
        //GenerateRandom();
        //SetCaptchaText();
    }

    private bool User_ID_Validate(string User_ID)
    {
        try
        {

            if (User_ID.Length < 8)
            {
                return false;
            }
            if (User_ID.Length < 30)
            {
                return true;
            }

            else
            {
                return false;
            }
        }
        catch (ApplicationException ex)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "asyncPostBack", "alert('" + ex.Message + "');", true);
            return false;
        }
        
    }
}