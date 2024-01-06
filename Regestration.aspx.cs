using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication6
{
    public partial class Regestration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Assocmanger(object sender, EventArgs e)
        {
            Response.Redirect("AssocManger registeration.aspx");
        }
        protected void Cr(object sender, EventArgs e)
        {
            Response.Redirect("ClubRepresentitive registration.aspx");
        }
        protected void SM (object sender, EventArgs e)
        {
            Response.Redirect("SManger registration.aspx");
        }
        protected void Fans(object sender, EventArgs e)

        {
            Response.Redirect("Fan registration.aspx");
        }


    }
}