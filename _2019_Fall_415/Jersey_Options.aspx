<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Jersey_Options.aspx.cs" Inherits="Jersey_Options" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Stylesheets/style.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Alfa+Slab+One|Roboto&display=swap" rel="stylesheet" />
    <script
        src="https://code.jquery.com/jquery-3.4.1.min.js"
        integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous">
    </script>
    <script src="javascript/scripts.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MMABooksConnectionString2 %>" SelectCommand="SELECT * FROM [ColorTable]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MMABooksConnectionString2 %>" SelectCommand="SELECT * FROM [SizeTable]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MMABooksConnectionString2 %>" SelectCommand="SELECT * FROM [TeamTable]"></asp:SqlDataSource>
        <div class="content">
            <h1>New Jersey Co.</h1>
            <asp:Button ID="btnReturn" CssClass="button" runat="server" Text="Return to Home Page" PostBackUrl="~/Default.aspx" CausesValidation="False" />
            <h2>Jersey Options</h2>
            <p>
                This form will allow you to see all the options New Jersey Co. offers for customizable jerseys.
                <br />
                You can see color, size, price, and range of jersey numbers allowed.
                <br />
                If you are selecting this jersey as a team member, please indicate so below.
            </p>
            <br />
            <div id="selectteam">
                <span>Team Name:&nbsp;</span>
                <asp:DropDownList ID="ddlTeamNames" AutoPostBack="true" CssClass="ddl" AppendDataBoundItems="true" runat="server" DataSourceID="SqlDataSource3" DataTextField="TeamName" DataValueField="TeamID" OnSelectedIndexChanged="ddlTeamNames_SelectedIndexChanged">
                    <asp:ListItem Text="None" Value="" />
                </asp:DropDownList>
            </div>
            <br />
            <asp:Image ID="Image1" runat="server" ImageUrl="~/img/jersey.jfif" />
            <h3>Jersey Customization</h3>
            <table>
                <tr>
                    <td>
                        <span>Jersey Color:&nbsp;</span>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlColor" CssClass="ddl" runat="server" DataSourceID="SqlDataSource1" DataTextField="ColorName" DataValueField="ColorID"></asp:DropDownList>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <span>Jersey Size:&nbsp;</span>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="ddl" AppendDataBoundItems="true" ID="ddlSize" runat="server" AutoPostBack="true" DataSourceID="SqlDataSource2" DataTextField="Size" DataValueField="SizeID" OnSelectedIndexChanged="ddlSize_SelectedIndexChanged" OnLoad="ddlSize_SelectedIndexChanged">
                            <asp:ListItem Text="Select Size" Value="SelectSize" />
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="lblPrice" CssClass="label" runat="server" Text=""></asp:Label><br />
                    </td>
                    <td>
                       
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>Jersey Name:</span>
                    </td>
                    <td>
                        <asp:TextBox ID="txtJerseyName" CssClass="textbox" Width="144px" runat="server" MaxLength="20"></asp:TextBox>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td>
                        <span>Jersey Number:</span>
                    </td>
                    <td>
                        <asp:DropDownList CssClass="ddl" ID="ddlNumber" runat="server"></asp:DropDownList>
                    </td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
             
            <asp:Button ID="btnConfirmOrder" CssClass="button" runat="server" Text="Confirm Selection" OnClick="btnConfirmOrder_Click" PostBackUrl="~/Order_Confirmation.aspx" />
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ddlSize"  runat="server" Display="Dynamic" ForeColor="White" ErrorMessage="*You must select a jersey size." InitialValue="SelectSize"></asp:RequiredFieldValidator>
        </div>


    </form>
</body>
</html>
