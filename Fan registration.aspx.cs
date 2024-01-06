using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.EnterpriseServices.CompensatingResourceManager;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace WebApplication6
{
    public partial class Fan_registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [Obsolete]
        protected void Button1_Click(object sender, EventArgs e)
        {   
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String name = Name.Text;
            String username = Username.Text;
            String password = Password.Text;   
            String national = national_ID.Text;
            String Phoneno = Phone.Text;
            string datetimeValue = Request.Form["StartTime"];
            DateTime datetime = DateTime.Parse(datetimeValue);
            String Address = address.Text;
            int check = -1;
            int checks = -1;
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
            using (SqlCommand command = new SqlCommand("SELECT dbo.xx(@nn)", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@nn", national);
                object result = command.ExecuteScalar();
                checks = (int)result;
            }
            Conn.Close();
            if (check == 0)
            {       if (checks == 0)
                {
                    Conn.Open();
                    using (SqlCommand command = new SqlCommand("EXEC addFan @name, @national_id, @birth_date  , @address , @phone_number , @username , @password ", Conn))
                    {
                        command.CommandType = CommandType.Text;
                        command.Parameters.Add(new SqlParameter("@name", name));
                        command.Parameters.Add(new SqlParameter("@username", username));
                        command.Parameters.Add(new SqlParameter("@password", password));
                        command.Parameters.Add(new SqlParameter("@national_id", national));
                        command.Parameters.Add(new SqlParameter("@phone", Phoneno));
                        command.Parameters.Add(new SqlParameter("@birth_date", datetime));
                        command.Parameters.Add(new SqlParameter("@address", Address));
                        command.Parameters.Add(new SqlParameter("@phone_number", Phoneno));

                        command.ExecuteScalar();
                    }
                    Conn.Close();
                    Response.Redirect("login.aspx");
                }
                else
                    Response.Write("Please ENTER your correct national_ID");

            }
            else
                Response.Write("Username is already Taken");

        }
    }
}