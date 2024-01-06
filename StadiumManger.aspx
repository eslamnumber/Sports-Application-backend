<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManger.aspx.cs" Inherits="WebApplication6.StadiumManger" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Stadiuminfo;<br />
            <br />
            <asp:Button ID="Button1" OnClick ="BClick1" runat="server" Text="View" />
            <br />
            <asp:Panel ID="Panel1" runat="server">
            </asp:Panel>
            <br />
            <br />
            <br />
            ReceivedRequests:<br />
            <br />
            <asp:Button ID="Button2" OnClick="BClick2" runat="server" Text="View" />
            <br />
            <br />
            <asp:Panel ID="Panel2" runat="server">
            </asp:Panel>
            <br />
            <br />
            AcceptRequest:<br />
            <br />
            HostClubName :<br />
            <br />
        </div>
        <asp:TextBox ID="HostClubName" runat="server"></asp:TextBox>
        <br />
        <br />
        GuestClubName:<br />
        <p>
            <asp:TextBox ID="GuestClubName" runat="server"></asp:TextBox>
        </p>
        <p>
            StartTime :</p>
        <p>
<input id="Date" name="StartTime" type="datetime" value="2/2/2002 5:0:0" onfocus="if (this.value == '2/2/2002 5:0:0') { this.value = ''; }" onblur="if (this.value == '') { this.value = '2/2/2002 5:0:0'; }">
        <p>
            <asp:Button ID="Button3"  OnClick="BClick3" runat="server" Text="Accept" />
        </p>
        <div>
            RejectRequest:<br />
            <br />
            HostClubName :<br />
            <br />
        </div>
        <asp:TextBox ID="HostClubName0" runat="server"></asp:TextBox>
        <br />
        <br />
        GuestClubName:<br />
        <p>
            <asp:TextBox ID="GuestClubName0" runat="server"></asp:TextBox>
        </p>
        <p>
            StartTime :</p>
        <p>
<input id="DateTime" name="StartTime0" type="datetime" value="2/2/2002 5:0:0" onfocus="if (this.value == '2/2/2002 5:0:0') { this.value = ''; }" onblur="if (this.value == '') { this.value = '2/2/2002 5:0:0'; }">
        <p>
            <asp:Button ID="Button4"  OnClick="BClick4" runat="server" Text="Reject" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <configuration>
  <system.web>
    <sessionState mode="InProc" timeout="20"/>
  </system.web>
</configuration>

    </form>
</body>
</html>
