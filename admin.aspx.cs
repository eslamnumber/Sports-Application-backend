using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Net.NetworkInformation;

namespace WebApplication6
{
    public partial class admin : System.Web.UI.Page

    {
        String username = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            username = (string)Session["username"];
            if (username.Equals(""))
                Response.Redirect("login.aspx");

        }

        protected void Page_Loads(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String name = ClubName.Text;
            String location = ClubLocation.Text;

            int x = -1;
            Conn.Open();
            using (SqlCommand command = new SqlCommand("select  dbo.check_club (@clubname)", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@clubname", name);
                object result = command.ExecuteScalar();
                x = (int)result;
            }
            Conn.Close();
            if (x >0)
                Response.Write("this club is already exist");
            else
            {
                Conn.Open();
                using (SqlCommand command = new SqlCommand("Exec addClub @nameoftheclub ,@location ", Conn))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@nameoftheclub", name);
                    command.Parameters.AddWithValue("@location", location);
                    command.ExecuteScalar();

                }
                Conn.Close();
                Response.Write("Club added successfully ");
            }

        }
        protected void Page_Loadss(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String name = ClubNamed.Text;

            int x = -1;
            Conn.Open();
            using (SqlCommand command = new SqlCommand("select dbo.check_club(@clubname)", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@clubname", name);
                object result = command.ExecuteScalar();
                x = (int)result;
            }
            Conn.Close();
            if (x == 0)
                Response.Write("there is no club with this name");
            else
            {
                Conn.Open();
                using (SqlCommand command = new SqlCommand("Exec deleteClub @name", Conn))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@name", name);
                    command.ExecuteScalar();
                    Response.Write("Club deleted Successfully");

                }
                Conn.Close();
            }


        }
        protected void Page_Loadsss(object sender, EventArgs e)  
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String name = StadiumName.Text;
            String location = StadiumLocation.Text;
            int  Capcity = int.Parse(Capacity.Text);

            int x = -1;
            Conn.Open();
            using (SqlCommand command = new SqlCommand("select dbo.check_stadium (@stadiumname)", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@stadiumname", name);
                object result = command.ExecuteScalar();
                x = (int)result;
            }
            Conn.Close();
            if (x == 1)
                Response.Write("this stadium is already exist");
            else
            {
                Conn.Open();
                using (SqlCommand command = new SqlCommand("EXEC dbo.addStadium @name_stadium,@location,@capcity", Conn))/////check this methid 
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@name_stadium", name);
                    command.Parameters.AddWithValue("@location", location);
                    command.Parameters.AddWithValue("@capcity", Capcity);
                    command.ExecuteScalar();
                    Response.Write("Stadium added sucessfully");
                }
                Conn.Close();
            }
        }
        protected void Page_Loadssss(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String name = StadiumNamed.Text;
            int x = -1;
            Conn.Open();
            using (SqlCommand command = new SqlCommand("select dbo.check_stadium (@stadiumname)", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@stadiumname", name);
                object result = command.ExecuteScalar();
                x = (int)result;
            }
            Conn.Close();
            if (x == 0)
                Response.Write("there is no stadium with this name");
            else
            {
                Conn.Open();
                using (SqlCommand command = new SqlCommand("exec deleteStadium @name", Conn))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@name", name);
                    command.ExecuteScalar();
                    Response.Write("Stadium Deleted Successfully");

                }
                Conn.Close();
            }

        }
        protected void Page_Loadsssss(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String National_id = ID.Text;
            int x = -1;
            Conn.Open();
            using (SqlCommand command = new SqlCommand("select dbo.check_fans2 (@nationalid)", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@nationalid", National_id);
                object result = command.ExecuteScalar();
                x = (int)result;
            }
            Conn.Close();
            if (x == 0)
                Response.Write("the given information is incorrect");
            else
            {
                Conn.Open();
                using (SqlCommand command = new SqlCommand("Exec blockFan @National_id", Conn))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@National_id", National_id);
                    command.ExecuteScalar();
                    Response.Write("This fan is blocked");

                }
                Conn.Close();
            }

        }
    }
}