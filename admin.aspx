<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin.aspx.cs" Inherits="WebApplication6.admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        Add a new Club:<br />
        <br />
        name<br />
        &nbsp;
        <div>
            <asp:TextBox ID="ClubName" runat="server"></asp:TextBox>
            <br />
            <br />
            location<br />
        </div>
        <asp:TextBox ID="ClubLocation" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" OnClick ="Page_Loads" Text="ADD" />
        <br />
        <p>
            Delete club:</p>
        <p>
            name</p>
        <p>
            <asp:TextBox ID="ClubNamed" runat="server"></asp:TextBox>
        </p>
        <p>
        <asp:Button ID="Button3" runat="server" OnClick ="Page_Loadss" Text="DELETE " />
        </p>
        <p>
            Add stadium:</p>
        <p>
            name:</p>
        <p>
            <asp:TextBox ID="StadiumName" runat="server"></asp:TextBox>
        </p>
        <p>
            location:</p>
        <p>
            <asp:TextBox ID="StadiumLocation" runat="server"></asp:TextBox>
        </p>
        <p>
            capacity:</p>
        <p>
            <asp:TextBox ID="Capacity" runat="server"></asp:TextBox>
        </p>
        <p>
        <asp:Button ID="Button4" runat="server" OnClick ="Page_Loadsss" Text="ADD" />
        </p>
        <p>
            Delete a Stadium:</p>
        <p>
            name :</p>
        <p>
            <asp:TextBox ID="StadiumNamed" runat="server"></asp:TextBox>
        </p>
        <p>
        <asp:Button ID="Button1" runat="server" Onclick="Page_Loadssss" Text="DELETE" />
        </p>
        <p>
            Block Fan:</p>
        <p>
            National_ID :</p>
        <p>
            <asp:TextBox ID="ID" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button5" runat="server" OnClick="Page_Loadsssss" Text="BLOCK" />
        </p>
    </form>
        <p>
            &nbsp;</p>
    </body>
</html>
