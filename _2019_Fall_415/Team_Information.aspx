<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Team_Information.aspx.cs" Inherits="Team_Information" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Stylesheets/style.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Alfa+Slab+One|Roboto&display=swap" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            background: none;
            border: 3px solid white;
            color: white;
            font-size: 20px;
            font-family: 'Roboto', sans-serif;
            padding: 5px;
            margin: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnFindTeam">
        <div class="content">

            <asp:Button ID="btnReturn" CssClass="button" runat="server" Text="Return to Home Page" PostBackUrl="~/Default.aspx" CausesValidation="False" />

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MMABooksConnectionString2 %>"
                SelectCommand="SELECT CustomerTable.CustomerFname, CustomerTable.CustomerLName, TeamTable.TeamName
                                FROM [TeamMembersTable] JOIN CustomerTable
                                ON TeamMembersTable.CustomerID = CustomerTable.CustomerID
                                JOIN TeamTable ON TeamMembersTable.TeamID = TeamTable.TeamID;"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsTeamMembers" runat="server" ConnectionString="<%$ ConnectionStrings:MMABooksConnectionString2 %>" 
                SelectCommand="SELECT CustomerTable.CustomerFname, CustomerTable.CustomerLName, TeamTable.TeamName
                                FROM [TeamMembersTable] JOIN CustomerTable
                                ON TeamMembersTable.CustomerID = CustomerTable.CustomerID
                                JOIN TeamTable ON TeamMembersTable.TeamID = TeamTable.TeamID
                                AND ([TeamName] LIKE '%' + @TeamName + '%')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtTeamName" Name="TeamName" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <h1>Team Information</h1>
            <br />
            <br />
            <table>
                <tr>
                    <td><p>Team Name:&nbsp;</p></td>
                    <td>
                        <asp:TextBox ID="txtTeamName" CssClass="textbox" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="btnFindTeam" CssClass="auto-style1" runat="server" Text="Find Players" Width="150px" OnClick="btnFindTeam_Click" />
                    </td>
                </tr>

            </table>
            <asp:GridView ID="GridView1" CssClass="gridview" PagerStyle-CssClass="gridviewpager" HeaderStyle-CssClass="gridviewheader" RowStyle-CssClass="gridviewrows" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSource1" GridLines="None">
                <Columns>

                    <asp:BoundField DataField="TeamName" HeaderText="Team Name" SortExpression="TeamName" />
                    <asp:BoundField DataField="CustomerFname" HeaderText="First Name" SortExpression="CustomerFname" />
                    <asp:BoundField DataField="CustomerLName" HeaderText="Last Name" SortExpression="CustomerLName" />
                </Columns>

<HeaderStyle CssClass="gridviewheader"></HeaderStyle>

<PagerStyle CssClass="gridviewpager"></PagerStyle>

<RowStyle CssClass="gridviewrows"></RowStyle>
            </asp:GridView>
            <asp:Button ID="btnReset" CssClass="button" runat="server" Text="Reset" OnClick="btnReset_Click" />
        </div>

    </form>
</body>
</html>
