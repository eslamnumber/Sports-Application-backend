using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.EnterpriseServices.CompensatingResourceManager;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6
{
    public partial class StadiumManger : System.Web.UI.Page
    {
        String username="";
       
        protected void Page_Load(object sender, EventArgs e)
        {
             username = (string)Session["username"];
            if (username.Equals(""))
                Response.Redirect("login.aspx");

        }
        protected void BClick1(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String Stadiuminfo = "select * from  Display1(@username)";
            SqlCommand command = new SqlCommand(Stadiuminfo, Conn);
            // String Username = (String)Session["username"];   
            command.Parameters.AddWithValue("@username", username);
            Conn.Open();
            DataTable table = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            adapter.Fill(table);
            StringBuilder sb = new StringBuilder();
            sb.Append("<center>");
            sb.Append("<table border=1>");
            sb.Append("<thead>");
            sb.Append("<tr>");
            foreach (DataColumn dc in table.Columns)
            {
                sb.Append("<th>");
                sb.Append(dc.ColumnName.ToUpper());
                sb.Append("</th>");
            }
            sb.Append("</tr>");
            sb.Append("</thead>");
            sb.Append("<br>");
            foreach (DataRow dr in table.Rows)
            {
                sb.Append("<tr>");
                foreach (DataColumn dc in table.Columns)
                {
                    sb.Append("<td>");
                    sb.Append(dr[dc.ColumnName].ToString());
                    sb.Append("</td>");
                }
                sb.Append("</tr>");
                sb.Append("<br>");
            }
            sb.Append("</table>");
            sb.Append("</center>");
            Panel1.Controls.Add(new Label { Text = sb.ToString() });

        }
        protected void BClick2(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String requests = "select * from requests (@username) ";
            SqlCommand command = new SqlCommand(requests, Conn);
            command.Parameters.AddWithValue("@username", username);
            Conn.Open();
            DataTable table = new DataTable();
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            adapter.Fill(table);
            StringBuilder sb = new StringBuilder();
            sb.Append("<center>");
            sb.Append("<table border=1>");
            sb.Append("<thead>");
            sb.Append("<tr>");
            foreach (DataColumn dc in table.Columns)
            {
                sb.Append("<th>");
                sb.Append(dc.ColumnName.ToUpper());
                sb.Append("</th>");
            }
            sb.Append("</tr>");
            sb.Append("</thead>");
            sb.Append("<br>");
            foreach (DataRow dr in table.Rows)
            {
                sb.Append("<tr>");
                foreach (DataColumn dc in table.Columns)
                {
                    sb.Append("<td>");
                    sb.Append(dr[dc.ColumnName].ToString());
                    sb.Append("</td>");
                }
                sb.Append("</tr>");
                sb.Append("<br>");
            }
            sb.Append("</table>");
            sb.Append("</center>");
            Panel2.Controls.Add(new Label { Text = sb.ToString() });


        }
        protected void BClick3(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String Hname = HostClubName.Text;
            String Gname = GuestClubName.Text;
            string datetimeString = Request.Form["StartTime"];
            DateTime datetime = DateTime.Parse(datetimeString);
            Conn.Open();
            int rows = 0;
            using (SqlCommand command = new SqlCommand("acceptRequest", Conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@stadium_manger_username", username);
                command.Parameters.AddWithValue("@hosting_club_name", Hname);
                command.Parameters.AddWithValue("@name_guest_club", Gname);
                command.Parameters.AddWithValue("@start_time", datetime);

                rows =command.ExecuteNonQuery();


            }
            Conn.Close();
            if (rows > 0)
                Response.Write("The resquest is Accepted Succcessfully");
            else
                Response.Write("This request cannot be found or already handeled");


        }
        protected void BClick4(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String Hname = HostClubName.Text;
            String Gname = GuestClubName.Text;
            string datetimeString = Request.Form["StartTime0"];
            DateTime datetime = DateTime.Parse(datetimeString);
            Conn.Open();
            int rows = 0;   
            using (SqlCommand command = new SqlCommand("Exec rejectRequest @stadium_manger_username , @hosting_club_name, @name_guest_club ,@start_time", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.AddWithValue("@stadium_manger_username", username);
                command.Parameters.AddWithValue("@hosting_club_name", Hname);
                command.Parameters.AddWithValue("@name_guest_club", Gname);
                command.Parameters.AddWithValue("@start_time", datetime);

               rows = command.ExecuteNonQuery();


            }
            Conn.Close();
            if (rows > 0)
                Response.Write("The resquest is Rejected Succcessfully");
            else
                Response.Write("Cannot be found or already handeled");



        }


    }
}
