<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OrderHistory.aspx.cs" Inherits="OrderHistory" %>

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
    <form id="form1" runat="server">
        <div class="content">

            <asp:Button ID="btnReturn" CssClass="button" runat="server" Text="Return to Home Page" PostBackUrl="~/Default.aspx" />

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MMABooksConnectionString2 %>"
                SelectCommand="SELECT [OrderTable].* , [CustomerTable].CustomerFname, [CustomerTable].CustomerLName, [ColorTable].ColorName , [SizeTable].Size, [TeamTable].TeamName
                                FROM OrderTable JOIN ColorTable ON OrderTable.ColorID = ColorTable.ColorID
                                JOIN SizeTable ON OrderTable.SizeID = SizeTable.SizeID
                                JOIN CustomerTable ON OrderTable.CustomerID = CustomerTable.CustomerID
                                LEFT OUTER JOIN TeamTable ON TeamTable.TeamID = OrderTable.TeamID;"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsCustomerOrders" runat="server" ConnectionString="<%$ ConnectionStrings:MMABooksConnectionString2 %>"
                SelectCommand="
                SELECT [OrderTable].* , [CustomerTable].CustomerFname, [CustomerTable].CustomerLName, [ColorTable].ColorName , [SizeTable].Size, [TeamTable].TeamName 
                  FROM OrderTable JOIN ColorTable ON OrderTable.ColorID = ColorTable.ColorID 
                                JOIN SizeTable ON OrderTable.SizeID = SizeTable.SizeID 
                                JOIN CustomerTable ON OrderTable.CustomerID = CustomerTable.CustomerID 
                                LEFT OUTER JOIN TeamTable ON TeamTable.TeamID = OrderTable.TeamID  
                                WHERE (CustomerTable.CustomerEmail LIKE '%' + @CustomerEmail + '%')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtEmail" Name="CustomerEmail" PropertyName="Text" Type="String"/>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server"></asp:SqlDataSource>

            <h1>Order History:</h1>
            <br />
            <br />
            <table>
                <tr>
                    <td>
                        <p>Customer Email:</p>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmail" CssClass="textbox" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="btnFindOrder" CssClass="auto-style1" runat="server" Text="Find Orders" Width="142px" OnClick="btnFindOrder_Click" />
                    </td>
                </tr>

            </table>
            <asp:GridView ID="GridView1" CssClass="gridview" PagerStyle-CssClass="gridviewpager" HeaderStyle-CssClass="gridviewheader" RowStyle-CssClass="gridviewrows" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="OrderID" DataSourceID="SqlDataSource1" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="OrderID" HeaderText="OrderID" ReadOnly="True" SortExpression="OrderID" InsertVisible="False" />
                    <asp:BoundField DataField="CustomerFname" HeaderText="Customer First" SortExpression="CustomerFname" />
                    <asp:BoundField DataField="CustomerLName" HeaderText="Customer Last" SortExpression="CustomerLName" />
                    <asp:BoundField DataField="JerseyName" HeaderText="Jersey Name" SortExpression="JerseyName" />
                    <asp:BoundField DataField="JerseyNumber" HeaderText="Jersey Number" SortExpression="JerseyNumber" />
                    <asp:BoundField DataField="ColorName" HeaderText="Color" SortExpression="ColorName" />
                    <asp:BoundField DataField="Size" HeaderText="Size" SortExpression="Size" />
                    <asp:BoundField DataField="TeamName" HeaderText="Team" SortExpression="TeamName" />
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
