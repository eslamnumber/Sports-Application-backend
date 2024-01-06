<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebApplication6.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <p>
            Please Login
        </p>
        <p>
            Username</p>
        <p>
<asp:TextBox ID="username" runat="server" default="username" onfocus="if (this.value == 'username') { this.value = ''; }" onblur="if (this.value == '') { this.value = 'username'; }"></asp:TextBox>        </p>
        <p>
            Password</p>
        <p>
<asp:TextBox ID="Password" runat="server" Type="Password" default="Enter password" onfocus="if (this.value == 'Enter password') { this.value = ''; }" onblur="if (this.value == '') { this.value = 'Enter password'; }"></asp:TextBox>        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="login" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click1" Text="register" />
        </p>
        <configuration>
  <system.web>
    <sessionState mode="InProc" timeout="20"/>
  </system.web>
</configuration>

    </form>
</body>
</html>
