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
using System.Configuration;

namespace WebApplication6
{
    public partial class fans : System.Web.UI.Page
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
            String viewMatches = "select * from ViewMatches(@Date)";
            string datetimeString = Request.Form["StartTime0"];
            DateTime datetime = DateTime.Parse(datetimeString);
            SqlCommand command = new SqlCommand(viewMatches, Conn);
            command.Parameters.AddWithValue("@Date", datetime);
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
            String National_ID = national_ID.Text;
            String HostName = Hname.Text;
            String Guestname = Gname.Text;
            string datetimeString = Request.Form["StartTime"];
            DateTime datetime = DateTime.Parse(datetimeString);
            Conn.Open();
                using (SqlCommand command = new SqlCommand("EXEC purchaseTicket @nationalid ,@hname,@gname ,@Sdate ", Conn))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@nationalid", National_ID);
                    command.Parameters.AddWithValue("@hname", HostName);
                    command.Parameters.AddWithValue("@gname", Guestname);
                    command.Parameters.AddWithValue("@Sdate", datetime);
                try
                {
                    command.ExecuteScalar();
                    Response.Write(" Purchase Done Succcessfully");
                }
                catch (Exception)
                { Response.Write("you have buy a Ticket Before Or you are blocked"); }


                }
                Conn.Close();
            }
        }
    }

 