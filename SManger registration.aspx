<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SManger registration.aspx.cs" Inherits="WebApplication6.SManger_registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        Name<br />
&nbsp;<asp:TextBox ID="Name" runat="server"></asp:TextBox>
        <br />
        Username
        <br />
        <asp:TextBox ID="Username" runat="server"></asp:TextBox>
        <br />
        Password
        <br />
        <asp:TextBox ID="Password" runat="server" Type="Password"></asp:TextBox>
        <br />
            St.Name<br />
        <asp:TextBox ID="Nameofstadium" runat="server"></asp:TextBox>
        <br />
        <br />
        <br />
            <asp:Button ID="Button1" runat="server" onclick ="Button1_Click" Text="register" />
        </div>
    </form>
</body>
</html>
