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
    public partial class AssocManger_registeration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String name = Name.Text;
            String pass = Password.Text;
            String username = Username.Text;
            SqlCommand register = new SqlCommand("addAss", Conn);
            SqlCommand Checks = new SqlCommand("Checks", Conn);
            register.CommandType = CommandType.StoredProcedure;
            register.Parameters.Add(new SqlParameter("@name", name));
            register.Parameters.Add(new SqlParameter("@username", username));
            register.Parameters.Add(new SqlParameter("@password", pass));
            Checks.Parameters.Add(new SqlParameter("@username", username));
            int check;
            Conn.Open();
            using (SqlCommand command = new SqlCommand("SELECT dbo.Checks(@username)", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@username", username);
                object result = command.ExecuteScalar();
                check = (int)result;
            }
            Conn.Close();

            if (check == 0)
            {
                Conn.Open();
                register.ExecuteNonQuery();
                Response.Redirect("login.aspx");
                Conn.Close() ;  
            }

            else
                Response.Write("username is already taken");



        }
    }
}