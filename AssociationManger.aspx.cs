using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace WebApplication6
{
    public partial class AssociationManger : System.Web.UI.Page
    {
       String username = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            username = (string)Session["username"];
            if (username.Equals(""))
            Response.Redirect("login.aspx");

        }

        protected void ADD(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String Club_host_name = HostClubName.Text;
            String Club_guest_name = GuestClubName.Text;
            string datetimeValue = Request.Form["StartTime"];
            DateTime datetime = DateTime.Parse(datetimeValue);
            string datetimeValue1 = Request.Form["Date"];
            DateTime datetime1 = DateTime.Parse(datetimeValue);
            int x = -1;
            Conn.Open();
            using (SqlCommand command = new SqlCommand("select dbo.check_club (@clubname)", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.Add(new SqlParameter("@clubname", Club_host_name));
                object result = command.ExecuteScalar();
                x = (int)result;
            }
            Conn.Close();
            Conn.Open();
            int y;
            using (SqlCommand command = new SqlCommand("select dbo.check_club (@clubname)", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.Add(new SqlParameter("@clubname", Club_guest_name));
                object result = command.ExecuteScalar();
                y= (int)result;
            }
            Conn.Close();
            if ((x == 1 || x == 2) && (y == 1 || y == 2))
            {
                Conn.Open();
                using (SqlCommand command = new SqlCommand("EXEC addNewMatch @nameofhost ,@nameofguest ,@starttime ,@endtime", Conn))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.Add(new SqlParameter("@nameofhost", Club_host_name));
                    command.Parameters.Add(new SqlParameter("@nameofguest", Club_guest_name));
                    command.Parameters.Add(new SqlParameter("@starttime", datetime));
                    command.Parameters.Add(new SqlParameter("@endtime", datetime1));
                    command.ExecuteScalar();
                    Response.Write("Match added Successfully");
                }
                Conn.Close();
            }
            else
                Response.Write("One of the two Clubs cannot be found");   
            }
        
        protected void DELETE(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String Club_host_name = HostClubNamed.Text;
            String Club_guest_name = GuestClubNamed.Text;
            string datetimeValue = Request.Form["StartTime"];
            DateTime datetime = DateTime.Parse(datetimeValue);
            string datetimeValue1 = Request.Form["Date"];
            DateTime datetime1 = DateTime.Parse(datetimeValue);

            int x = -1;
            Conn.Open();
            using (SqlCommand command = new SqlCommand("select dbo.check_match (@nameofhost ,@nameofguest) ", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.Add(new SqlParameter("@nameofhost", Club_host_name));
                command.Parameters.Add(new SqlParameter("@nameofguest", Club_guest_name));
                object result = command.ExecuteScalar();
                x = (int)result;
            }
            Conn.Close();

            if (x == 0)
                Response.Write("there is no match with this given information");
            else
            {
                Conn.Open();
                using (SqlCommand command = new SqlCommand("EXEC  DeleteMatch @HostName,@GuestName ,@StartTime  , @EndTime", Conn))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.Add(new SqlParameter("@HostName", Club_host_name));
                    command.Parameters.Add(new SqlParameter("@GuestName", Club_guest_name));
                    command.Parameters.Add(new SqlParameter("@StartTime", datetime));
                    command.Parameters.Add(new SqlParameter("@EndTime", datetime1));
                    command.ExecuteNonQuery();
                    Response.Write("Match Deleted Successfully");
                }
                Conn.Close();

            }
        }
    

        protected void Two(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String AlreadyPlayed = "SELECT * FROM Already()";
            SqlCommand command = new SqlCommand(AlreadyPlayed, Conn);
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
            Conn.Close();   



        }
        protected void Three(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String ClubsneverPlayed = "select * from clubsNeverMatched";
            SqlCommand command = new SqlCommand(ClubsneverPlayed, Conn);
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
            Panel3.Controls.Add(new Label { Text = sb.ToString() });
            Conn.Close();  


        }

        protected void one(object sender, EventArgs e)
        {
            // Create a DataTable with some sample data
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String Matches = "select * from  Upcoming() ";
            SqlCommand command = new SqlCommand(Matches, Conn);
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
            Conn.Close();   
        }

    }
}
