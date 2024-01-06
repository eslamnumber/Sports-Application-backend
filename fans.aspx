<%@ Page Language="C#" AutoEventWireup="true" CodeFile="fans.aspx.cs" Inherits="WebApplication6.fans" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <br />
        View avilable Matches:<br />
        <br />
        Date:<br />
        <br />
        <input id="Date" name="StartTime0" type="datetime" /><br />
        <asp:Panel ID="Panel1" runat="server">
        </asp:Panel>

        <p>
        <asp:Button ID="Button5" runat="server" Text="View" OnClick="BClick1" />

        </p>
        <p>
            Purchase a Ticket:</p>
        <p>
            national_ID:</p>
        <p>
            <asp:TextBox ID="national_ID" runat="server"></asp:TextBox>
        </p>
        <p>
            HostClubName:</p>
        <p>
            <asp:TextBox ID="Hname" runat="server"></asp:TextBox>
        </p>
        <p>
            GuestClubName:</p>
        <p>
            <asp:TextBox ID="Gname" runat="server"></asp:TextBox>
        </p>
        <p>
            <label for="datetime-input">Enter a date and time:</label></p>
        <p>
            <br>
           <input id="Dates" name="StartTime" type="datetime" />
        </p>
        <p>
            <br />
        <asp:Button ID="Button4" OnClick="BClick2" runat="server" Text="Buy" />
        </p>

    </form>
</body>
</html>
