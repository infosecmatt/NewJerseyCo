<%@ Page Language="C#" AutoEventWireup="true" CodeFile="New_Team.aspx.cs" Inherits="New_Team" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Stylesheets/style.css" rel="stylesheet" />
    <link href="Stylesheets/newteam.css" rel="stylesheet" />
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
        <div class="content">
            <asp:Button ID="btnReturn" CssClass="button" runat="server" Text="Return to Home Page" PostBackUrl="~/Default.aspx" CausesValidation="False" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MMABooksConnectionString2 %>"
                SelectCommand="SELECT * FROM [TeamTable] JOIN [ColorTable] ON [TeamTable].TeamColorID = [ColorTable].ColorID"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MMABooksConnectionString2 %>"
                SelectCommand="SELECT * FROM [ColorTable]"></asp:SqlDataSource>
            <h1>Teams</h1>
            <br />
            <button id="btnCreateATeam" class="button" type="button">Create a Team</button>
            <div id="addteam" class="hidden">
                <table>
                    <tr>
                        <td><span>Team Name:&nbsp;</span></td>
                        <td>
                            <asp:TextBox ID="txtNewTeamName" CssClass="textbox" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" Display="Dynamic" ControlToValidate="txtNewTeamName" ForeColor="White"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><span>Team Color:&nbsp;</span></td>
                        <td>
                            <asp:DropDownList ID="ddlTeamColor" CssClass="ddl" runat="server" DataSourceID="SqlDataSource2" DataTextField="ColorName" DataValueField="ColorID"></asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <br />
                <asp:Button ID="btnAddTeam" CssClass="button" runat="server" Text="Add Team" OnClick="btnAddTeam_Click" />
            </div>
            <asp:GridView ID="GridView1" CssClass="gridview" PagerStyle-CssClass="gridviewpager" HeaderStyle-CssClass="gridviewheader" RowStyle-CssClass="gridviewrows" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="TeamID,ColorID" DataSourceID="SqlDataSource1" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="TeamID" HeaderText="Team ID" InsertVisible="False" ReadOnly="True" SortExpression="TeamID" />
                    <asp:BoundField DataField="TeamName" HeaderText="Team Name" SortExpression="TeamName" />
                    <asp:BoundField DataField="ColorName" HeaderText="Team Color" SortExpression="ColorName" />
                </Columns>

                <HeaderStyle CssClass="gridviewheader"></HeaderStyle>

                <PagerStyle CssClass="gridviewpager"></PagerStyle>

                <RowStyle CssClass="gridviewrows"></RowStyle>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
