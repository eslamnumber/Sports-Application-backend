using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click1(object sender, EventArgs e)
        {

            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String Username = username.Text;
            String pass = Password.Text;
            int check;
            Conn.Open();
            using (SqlCommand command = new SqlCommand("SELECT dbo.checkadmin(@username,@password)", Conn))
            {
                command.CommandType = CommandType.Text;

                command.Parameters.AddWithValue("@username",Username);
                command.Parameters.AddWithValue("@password", pass );

                object result = command.ExecuteScalar();
                check=(int )result;


            }

            Conn.Close();
            if (check != 0 && check!=-1 )
            {   
                Session["username"] = Username;
            }
            if (check == 1)
                Response.Redirect("admin.aspx");
            else if (check == 2)
                Response.Redirect("AssociationManger.aspx");
            else if (check == 3)
                Response.Redirect("clubRepsentative.aspx");
            else if (check == 4)
                Response.Redirect("StadiumManger.aspx");
            else if (check == 5)
                Response.Redirect("fans.aspx");
            else
                Response.Write("this username or password is incorrect");




        }
        protected void Button2_Click1(object sender, EventArgs e)
        {
            Response.Redirect("Regestration.aspx");
        }
        }
}