<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Customer_Info.aspx.cs" Inherits="Order_History" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Stylesheets/style.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Alfa+Slab+One|Roboto&display=swap" rel="stylesheet" />
    <script src="javascript/scripts.js"></script>
    <link href="Stylesheets/customerinfo.css" rel="stylesheet" />
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
    <form id="form1" runat="server" defaultbutton="btnFindCustomer">
        <div class="content">
            <asp:Button ID="btnReturn" CssClass="button" runat="server" CausesValidation="false" Text="Return to Home Page" PostBackUrl="~/Default.aspx" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MMABooksConnectionString2 %>"
                SelectCommand="SELECT * FROM [CustomerTable]" DeleteCommand="DELETE FROM [CustomerTable] WHERE [CustomerID] = @CustomerID" InsertCommand="INSERT INTO [CustomerTable] ([CustomerFname], [CustomerLName], [CustomerStreetAddress], [CustomerCity], [CustomerState], [CustomerZipCode], [CustomerPhone], [CustomerEmail]) VALUES (@CustomerFname, @CustomerLName, @CustomerStreetAddress, @CustomerCity, @CustomerState, @CustomerZipCode, @CustomerPhone, @CustomerEmail)" UpdateCommand="UPDATE [CustomerTable] SET [CustomerFname] = @CustomerFname, [CustomerLName] = @CustomerLName, [CustomerStreetAddress] = @CustomerStreetAddress, [CustomerCity] = @CustomerCity, [CustomerState] = @CustomerState, [CustomerZipCode] = @CustomerZipCode, [CustomerPhone] = @CustomerPhone, [CustomerEmail] = @CustomerEmail WHERE [CustomerID] = @CustomerID">
                <DeleteParameters>
                    <asp:Parameter Name="CustomerID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="CustomerFname" Type="String" />
                    <asp:Parameter Name="CustomerLName" Type="String" />
                    <asp:Parameter Name="CustomerStreetAddress" Type="String" />
                    <asp:Parameter Name="CustomerCity" Type="String" />
                    <asp:Parameter Name="CustomerState" Type="String" />
                    <asp:Parameter Name="CustomerZipCode" Type="String" />
                    <asp:Parameter Name="CustomerPhone" Type="String" />
                    <asp:Parameter Name="CustomerEmail" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="CustomerFname" Type="String" />
                    <asp:Parameter Name="CustomerLName" Type="String" />
                    <asp:Parameter Name="CustomerStreetAddress" Type="String" />
                    <asp:Parameter Name="CustomerCity" Type="String" />
                    <asp:Parameter Name="CustomerState" Type="String" />
                    <asp:Parameter Name="CustomerZipCode" Type="String" />
                    <asp:Parameter Name="CustomerPhone" Type="String" />
                    <asp:Parameter Name="CustomerEmail" Type="String" />
                    <asp:Parameter Name="CustomerID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsSelectedCustomer" runat="server" ConnectionString="<%$ ConnectionStrings:MMABooksConnectionString2 %>" SelectCommand="SELECT * FROM [CustomerTable] WHERE ([CustomerEmail] = @CustomerEmail)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtEmail" Name="CustomerEmail" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <h1>Customer History</h1>
            <br />
            <br />
            <table>
                <tr>
                    <td><p>Customer Email&nbsp;:</p></td>
                    <td>
                        <asp:TextBox ID="txtEmail" CssClass="textbox" runat="server" MaxLength="50"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" Display="Dynamic" runat="server" ControlToValidate="txtEmail" ForeColor="White" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" ControlToValidate="txtEmail" ForeColor="White" runat="server" ErrorMessage="Must be an email address." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    </td>
                    <td>
                        <asp:Button ID="btnFindCustomer" CausesValidation="false" CssClass="auto-style1" runat="server" Text="Add/Modify Customer" OnClick="btnFindCustomer_Click" Width="215px" />
                    </td>
                </tr>
            </table>
            <div id="addmodifycustomers" runat="server" class="hidden">
                <table>
                    <tr>
                        <td>
                            <span>First Name:&nbsp;</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCustomerFirst" CssClass="textbox" runat="server" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" runat="server" ControlToValidate="txtCustomerFirst" ForeColor="White" ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <span>Last Name:&nbsp;</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCustomerLast" CssClass="textbox" runat="server" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" runat="server" ControlToValidate="txtCustomerLast" ForeColor="White" ErrorMessage="*"></asp:RequiredFieldValidator>

                        </td>
                        <td>
                            <span>Phone:&nbsp;</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCustomerPhone" CssClass="textbox" runat="server" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="Dynamic" runat="server" ControlToValidate="txtCustomerPhone" ForeColor="White" ErrorMessage="*"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="Dynamic" ControlToValidate="txtCustomerPhone" ForeColor="White" runat="server" ErrorMessage="Format: 999-999-9999" ValidationExpression="^[2-9]\d{2}-\d{3}-\d{4}$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Address:&nbsp;</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCustomerAddress" CssClass="textbox" runat="server" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" runat="server" ControlToValidate="txtCustomerAddress" ForeColor="White" ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <span>City:&nbsp;</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCustomerCity" CssClass="textbox" runat="server" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" Display="Dynamic" runat="server" ControlToValidate="txtCustomerCity" ForeColor="White" ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <span>State:&nbsp;</span>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlState" CssClass="ddl" Width="205px" runat="server">
                            <asp:ListItem Value="SelectState">Select State</asp:ListItem>
                            <asp:ListItem>AL</asp:ListItem>
                            <asp:ListItem>AK</asp:ListItem>
                            <asp:ListItem>AZ</asp:ListItem>
                            <asp:ListItem>AR</asp:ListItem>
                            <asp:ListItem>CA</asp:ListItem>
                            <asp:ListItem>CO</asp:ListItem>
                            <asp:ListItem>CT</asp:ListItem>
                            <asp:ListItem>DE</asp:ListItem>
                            <asp:ListItem>FL</asp:ListItem>
                            <asp:ListItem>GA</asp:ListItem>
                            <asp:ListItem>HI</asp:ListItem>
                            <asp:ListItem>ID</asp:ListItem>
                            <asp:ListItem>IL</asp:ListItem>
                            <asp:ListItem>IN</asp:ListItem>
                            <asp:ListItem>IA</asp:ListItem>
                            <asp:ListItem>KS</asp:ListItem>
                            <asp:ListItem>KY</asp:ListItem>
                            <asp:ListItem>LA</asp:ListItem>
                            <asp:ListItem>ME</asp:ListItem>
                            <asp:ListItem>MD</asp:ListItem>
                            <asp:ListItem>MA</asp:ListItem>
                            <asp:ListItem>MI</asp:ListItem>
                            <asp:ListItem>MN</asp:ListItem>
                            <asp:ListItem>MS</asp:ListItem>
                            <asp:ListItem>MO</asp:ListItem>
                            <asp:ListItem>MT</asp:ListItem>
                            <asp:ListItem>NE</asp:ListItem>
                            <asp:ListItem>NV</asp:ListItem>
                            <asp:ListItem>NH</asp:ListItem>
                            <asp:ListItem>NJ</asp:ListItem>
                            <asp:ListItem>NM</asp:ListItem>
                            <asp:ListItem>NY</asp:ListItem>
                            <asp:ListItem>NC</asp:ListItem>
                            <asp:ListItem>ND</asp:ListItem>
                            <asp:ListItem>OH</asp:ListItem>
                            <asp:ListItem>OK</asp:ListItem>
                            <asp:ListItem>OR</asp:ListItem>
                            <asp:ListItem>PA</asp:ListItem>
                            <asp:ListItem>RI</asp:ListItem>
                            <asp:ListItem>SC</asp:ListItem>
                            <asp:ListItem>SD</asp:ListItem>
                            <asp:ListItem>TN</asp:ListItem>
                            <asp:ListItem>TX</asp:ListItem>
                            <asp:ListItem>UT</asp:ListItem>
                            <asp:ListItem>VT</asp:ListItem>
                            <asp:ListItem>VA</asp:ListItem>
                            <asp:ListItem>WA</asp:ListItem>
                            <asp:ListItem>WV</asp:ListItem>
                            <asp:ListItem>WI</asp:ListItem>
                            <asp:ListItem>WY</asp:ListItem>
                        </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" Display="Dynamic" runat="server" InitialValue="SelectState" ControlToValidate="ddlState" ForeColor="White" ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <span>Zip:&nbsp;</span>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCustomerZip" CssClass="textbox" Width="100px" runat="server" MaxLength="50"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" Display="Dynamic" runat="server" ControlToValidate="txtCustomerZip" ForeColor="White" ErrorMessage="*"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator3" Display="Dynamic" ControlToValidate="txtCustomerZip" ForeColor="White" runat="server" ErrorMessage="Format: 99999" ValidationExpression="^\d{5}$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                </table>
                <asp:Button ID="btnSubmit" CssClass="auto-style1" runat="server" Text="Submit Information" Width="215px" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnDelete" CssClass="auto-style1" runat="server" Text="Delete Customer" Width="215px" OnClick="btnDelete_Click" />
                <br />
                <asp:Label ID="lblDeleteConfirmation" runat="server"  Text="Deleting a customer is an irreversable process. If you would like to continue, please click &#34;Confirm Delete&#34;" Visible="False"></asp:Label>
            </div>
            <asp:GridView ID="GridView1" CssClass="gridview" PagerStyle-CssClass="gridviewpager" HeaderStyle-CssClass="gridviewheader" RowStyle-CssClass="gridviewrows" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="CustomerID" DataSourceID="SqlDataSource1" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="CustomerFname" HeaderText="First Name" SortExpression="CustomerFname" />
                    <asp:BoundField DataField="CustomerLName" HeaderText="Last Name" SortExpression="CustomerLName" />
                    <asp:BoundField DataField="CustomerStreetAddress" HeaderText="Address" SortExpression="CustomerStreetAddress" />
                    <asp:BoundField DataField="CustomerCity" HeaderText="City" SortExpression="CustomerCity" />
                    <asp:BoundField DataField="CustomerState" HeaderText="State" SortExpression="CustomerState" />
                    <asp:BoundField DataField="CustomerZipCode" HeaderText="Zip Code" SortExpression="CustomerZipCode" />
                    <asp:BoundField DataField="CustomerPhone" HeaderText="Phone" SortExpression="CustomerPhone" />
                    <asp:BoundField DataField="CustomerEmail" HeaderText="Email" SortExpression="CustomerEmail" />
                </Columns>
            </asp:GridView>
            <asp:Button ID="btnReset" CssClass="button" runat="server" Text="Reset" OnClick="btnReset_Click" />
        </div>


    </form>
</body>
</html>
