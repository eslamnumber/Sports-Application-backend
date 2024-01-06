<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Regestration.aspx.cs" Inherits="WebApplication6.Regestration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <p>
            register as SportsAssociationManager</p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Assocmanger" Text="register" />
        </p>
        <p>
            ClubRepresentative</p>
        <p>
            <asp:Button ID="Button2" runat="server" OnClick="Cr" Text="register" />
        </p>
        <p>
            StadiumManager</p>
        <asp:Button ID="Button3" runat="server" OnClick="SM" Text="register" />
        <br />
        <br />
        Fans<br />
        <asp:Button ID="Button4" runat="server" OnClick="Fans" Text="register" />
        <br />
    </form>
</body>
</html>
