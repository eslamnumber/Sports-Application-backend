<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssociationManger.aspx.cs" Inherits="WebApplication6.AssociationManger" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    
        <div>
            Add a new match:<br />
            <br />
            Host Club Name :</div>
        <asp:TextBox ID="HostClubName" runat="server"></asp:TextBox>
        <br />
        Guest Club Name :<br />
        <asp:TextBox ID="GuestClubName" runat="server"></asp:TextBox>
        <br />
        Start Time :<br />
           <input id="StartTime" name="StartTime" type="datetime" />
        <br />
        End Time :<br />
           <input id="EndTime" name="Date" type="datetime" />
        <br />
        <br />
        <asp:Button ID="Four" runat="server" OnClick="ADD" Height="31px" Text="ADD" />
        <br />
        <br />
        <br />
        Delete Match :<br />
        <br />
        <div>
            Host Club Name :</div>
        <asp:TextBox ID="HostClubNamed" runat="server"></asp:TextBox>
        <br />
        Guest Club Name :<br />
        <asp:TextBox ID="GuestClubNamed" runat="server"></asp:TextBox>
        <br />
        Start Time :<br />
           <input id="StartTimed" name="StartTime" type="datetime" />
        <br />
        End Time :<br />
           <input id="EndTimed" name="Date" type="datetime" />
        <br />
        <br />
        <asp:Button ID="delete" OnClick="DELETE"  runat="server" Text="DELETE" />
        <br />
        <br />
        <br />
        View All upcoming matches :<br />
        <br />
        <asp:Button ID="Button1" Onclick="one" runat="server"  Text="View" />
        <br />
            <asp:Panel ID="Panel1" runat="server">
            </asp:Panel>
        <br />
        <br />
        View already played matches:<br />
        <br />
        <asp:Button ID="Button4" OnClick="Two" runat="server" Text="View"  />
        <br />
         <asp:Panel ID="Panel2" runat="server">
         </asp:Panel>
        <br />
        <br />
        View pair of club names who never scheduled to play with each other:<br />
        <br />
        <asp:Button ID="Button3" OnClick="Three" runat="server"  Text="View"  />
        <br />
        <br />
         <asp:Panel ID="Panel3" runat="server">
         </asp:Panel>
        <br />
        <br />
        <div>
        </div>
           <configuration>
  <system.web>
    <sessionState mode="InProc" timeout="20"/>
  </system.web>
</configuration>
    </form>
</body>
</html>
