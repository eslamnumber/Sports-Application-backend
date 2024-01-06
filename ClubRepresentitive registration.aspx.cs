using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6
{
    public partial class ClubRepresentitive_registration : System.Web.UI.Page
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
            String ClubName = Nameofclub.Text;
            int check = -1;
            int x = -1;
            Conn.Open();
            using (SqlCommand command = new SqlCommand("SELECT dbo.Checks(@username)", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@username", username);
                object result = command.ExecuteScalar();
                check = (int)result;
            }
            Conn.Close();
            Conn.Open();
            using (SqlCommand command = new SqlCommand("SELECT dbo.findClub(@nameoftheclub)", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@nameoftheclub", ClubName);
                object result = command.ExecuteScalar();
                x = (int)result;
            }

            Conn.Close();
            if (check == 0)
            {
                if (x != 1)
                    Response.Write("The Club cannot be found or already assigned to another representitve");
                else
                {
                    Conn.Open();
                    using (SqlCommand command = new SqlCommand("EXEC  addcr @name , @username ,@password,@nameoftheclub", Conn))
                    {
                        command.CommandType = CommandType.Text;
                        command.Parameters.Add(new SqlParameter("@name", name));
                        command.Parameters.Add(new SqlParameter("@username", username));
                        command.Parameters.Add(new SqlParameter("@password", pass));
                        command.Parameters.Add(new SqlParameter("@nameoftheclub", ClubName));
                        command.ExecuteScalar();

                    }
                    Conn.Close();
                    Response.Redirect("login.aspx");
                }
            }

            else
                Response.Write("Username is already Taken ");



        }
    }
}