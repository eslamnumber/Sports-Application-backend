<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan registration.aspx.cs" Inherits="WebApplication6.Fan_registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        Name<br />
<asp:TextBox ID="Name" runat="server" default="Enter name" onfocus="if (this.value == 'Enter name') { this.value = ''; }" onblur="if (this.value == '') { this.value = 'Enter name'; }"></asp:TextBox>        <br />
        Username
        <br />
        <asp:TextBox ID="Username" runat="server"></asp:TextBox>
            <br />
        Password
        <br />
<asp:TextBox ID="Password" runat="server" Type="Password" default="Enter password" onfocus="if (this.value == 'Enter password') { this.value = ''; }" onblur="if (this.value == '') { this.value = 'Enter password'; }"></asp:TextBox>        <br />
            national_ID <br />
<asp:TextBox ID="national_ID" runat="server"  default="National_ID" onfocus="if (this.value == 'Enter National_ID') { this.value = ''; }" onblur="if (this.value == '') { this.value = 'Enter National_ID'; }"></asp:TextBox>            <br />
            Phone<br />
&nbsp;<asp:TextBox ID="Phone" runat="server"></asp:TextBox>
            <br />
            BirthDate&nbsp;
        <br />
<input id="Date" name="StartTime" type="datetime" value="2/2/2002 5:0:0" onfocus="if (this.value == '2/2/2002 5:0:0') { this.value = ''; }" onblur="if (this.value == '') { this.value = '2/2/2002 5:0:0'; }">
            <br />
            address<br />
        <asp:TextBox ID="address" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Register" />
        </div>
    </form>
</body>
</html>
