<%@ Page Language="C#" AutoEventWireup="true" CodeFile="clubRepsentative.aspx.cs" Inherits="WebApplication6.clubRepsentative" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <p>
            view Clubinfo :</p>
        <asp:Button ID="Button1" OnClick="BClick1" runat="server" Text="view" />
        <br />
        <asp:Panel ID="Panel1" runat="server">
        </asp:Panel>
        <p>
            Upcomming Matches</p>
        <asp:Button ID="Button2" OnClick="BClick2" runat="server" Text="view" />
        <asp:Panel ID="Panel2" runat="server">
        </asp:Panel>
        <br />
        <br />
        AvailableStadium:<br />
        <br />
        StartTime:<br />
<input id="Date" name="StartTime0" type="datetime" value="2/2/2002 5:0:0" onfocus="if (this.value == '2/2/2002 5:0:0') { this.value = ''; }" onblur="if (this.value == '') { this.value = '2/2/2002 5:0:0'; }">
        <br />
        <br />
        <asp:Button ID="Button3" OnClick="BClick3" runat="server" Text="view" />
        <br />
        <br />
        <asp:Panel ID="Panel3" runat="server">
        </asp:Panel>
        <br />
        SendingRequest:<br />
        <br />
        Clubname:<br />
        <asp:TextBox ID="Clubname" runat="server"></asp:TextBox>
        <br />
        Stadiumname:<br />
        <asp:TextBox ID="Stadiumname" runat="server"></asp:TextBox>
        <br />
        StartTime:<br />
        <br />
<input id="DateTime" name="StartTime" type="datetime" value="2/2/2002 5:0:0" onfocus="if (this.value == '2/2/2002 5:0:0') { this.value = ''; }" onblur="if (this.value == '') { this.value = '2/2/2002 5:0:0'; }">
        <br />
        <br />
        <asp:Button ID="Button4" OnClick="BClick4" runat="server" Text="Send" />
        <configuration>
  <system.web>
    <sessionState mode="InProc" timeout="20"/>
  </system.web>
</configuration>

    </form>
    </body>
</html>
