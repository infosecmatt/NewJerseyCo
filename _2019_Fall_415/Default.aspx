<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title></title>
    <link href="Stylesheets/style.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Alfa+Slab+One|Roboto&display=swap" rel="stylesheet" />
    <link href="Stylesheets/homestylesheet.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" class="content" runat="server">
        <div id="header">
            <h1>New Jersey Co.</h1>
            <p>Every great player needs a great jersey.</p>
        </div>
        <div id="nav">
            <asp:Button ID="btnJersey" CssClass="button" runat="server" Text="Jersey Options" OnClick="btnJersey_Click" PostBackUrl="~/Jersey_Options.aspx" />
            <asp:Button ID="btnCutomer" CssClass="button" runat="server" Text="Customer Information" PostBackUrl="~/Customer_Info.aspx" />
            <asp:Button ID="btnOrderHistory" CssClass="button" runat="server" Text="Order History" PostBackUrl="~/OrderHistory.aspx" OnClick="Button1_Click" />
            <asp:Button ID="btnTeamMembers" CssClass="button" runat="server" Text="Team Information" PostBackUrl="~/Team_Information.aspx" />
            <asp:Button ID="btnTeams" CssClass="button" runat="server" Text="View/Add Teams" PostBackUrl="~/New_Team.aspx" />
        </div>
    </form>
</body>
</html>
