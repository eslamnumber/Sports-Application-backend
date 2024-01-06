<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssocManger registeration.aspx.cs" Inherits="WebApplication6.AssocManger_registeration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
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
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Register" />
    </form>
</body>
</html>
