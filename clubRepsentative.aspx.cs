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

    public partial class clubRepsentative : System.Web.UI.Page
    {

        private String Username = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            Username = (string)Session["username"];
            if (Username.Equals(""))
                Response.Redirect("login.aspx");

        }
        protected void BClick1(object sender, EventArgs e)
        {
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String AlreadyPlayed = "select * from  Display(@username)";
            SqlCommand command = new SqlCommand(AlreadyPlayed, Conn);
            //String username =(String ) Session["username"];
            command.Parameters.AddWithValue("@username", Username);
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
            String Clubname = "SELECT c.name FROM  Club c INNER JOIN ClubRepresentative cr  WHERE cr.club_ID=c.id AND username =@username ";
            String Upcomming = "select * from upcomingMatchesOfClub(@name) "; // it is wrong 
            SqlCommand command = new SqlCommand(Upcomming, Conn);
            command.Parameters.AddWithValue("@name", Clubname);
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
            //DateTime datetime;
            //DateTime.TryParse(datetimeValue, out datetime);
            String Upcomming = "select * from viewAvailableStadiumsOn (@date)";
            string datetimeString = Request.Form["StartTime0"];
            DateTime datetime = DateTime.Parse(datetimeString);
            SqlCommand command = new SqlCommand(Upcomming, Conn);
            command.Parameters.AddWithValue("@date", datetime);
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

        }
        protected void BClick4(object sender, EventArgs e)
        {
            
            String connstr = WebConfigurationManager.ConnectionStrings["Mydatabase"].ToString();
            SqlConnection Conn = new SqlConnection(connstr);
            String Cname = Clubname.Text;
            String Sname = Stadiumname.Text;
            string datetimeValue = Request.Form["StartTime"];
            DateTime datetime = DateTime.Parse(datetimeValue);

            int x = -1;
            Conn.Open();
            using (SqlCommand command = new SqlCommand("select dbo.check_club (@clubname)", Conn))
            {
                command.CommandType = CommandType.Text;
                command.Parameters.Add(new SqlParameter("@clubname", Cname));
                object result = command.ExecuteScalar();
                x = (int)result;
            }
            Conn.Close();
            if (x == 0)
                Response.Write("the name of club may be incorrect");
            else
            {
                x = -1;
                Conn.Open();
                using (SqlCommand command = new SqlCommand("select dbo.check_stadium (@stadiumname)", Conn))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.Add(new SqlParameter("@stadiumname", Sname));
                    object result = command.ExecuteScalar();
                    x = (int)result;
                }
                Conn.Close();
                if (x == 0)
                    Response.Write("the name of stadium may be incorrect");
                else
                {
                    x = -1;
                    Conn.Open();
                    using (SqlCommand command = new SqlCommand("select dbo.check_match2 (@clubname , @starttime)", Conn))
                    {
                        command.CommandType = CommandType.Text;
                        command.Parameters.Add(new SqlParameter("@clubname", Cname));
                        command.Parameters.Add(new SqlParameter("@starttime", datetime));
                        object result = command.ExecuteScalar();
                        x = (int)result;
                    }
                    Conn.Close();
                    if (x == 0)
                        Response.Write("there is no match for this club at this given time");
                 
                    else
                        {

                        if (datetime >= DateTime.Now)
                        {
                            Conn.Open();
                            using (SqlCommand command = new SqlCommand("EXEC addHostRequest @club_name , @stadium_name ,@start_time", Conn))
                            {
                                command.CommandType = CommandType.Text;
                                command.Parameters.Add(new SqlParameter("@club_name", Cname));
                                command.Parameters.Add(new SqlParameter("@stadium_name", Sname));
                                command.Parameters.Add(new SqlParameter("@start_time", datetime));
                                command.ExecuteScalar();

                            }
                            Conn.Close();
                            Response.Write("request Sent SuccessFully");
                        }
                        else
                            Response.Write("Cannot sent request on a passed Time ");
                    }


                    }
                }
            }
        }
    }

                

            

 
