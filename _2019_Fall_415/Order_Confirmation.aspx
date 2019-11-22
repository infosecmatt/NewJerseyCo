<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Order_Confirmation.aspx.cs" Inherits="Order_Here" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Stylesheets/style.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Alfa+Slab+One|Roboto&display=swap" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MMABooksConnectionString2 %>" SelectCommand="SELECT * FROM [CustomerTable]"></asp:SqlDataSource>

        <div class="content">
            <asp:Button ID="btnReturn" CssClass="button" CausesValidation="false" runat="server" Text="Return to Home Page" PostBackUrl="~/Default.aspx" />
            <h1>Order Confirmation</h1>
            <h3>Order Information</h3>
            <table>
                <tr>
                    <td><span>Team Name:</span></td>
                    <td>
                        <asp:Label ID="lblTeamName" CssClass="label" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td><span>Jersey Color:</span></td>
                    <td>
                        <asp:Label ID="lblJerseyColor" CssClass="label" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td><span>Jersey Size:</span></td>
                    <td>
                        <asp:Label ID="lblJerseySize" CssClass="label" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td><span>Jersey Name:</span></td>
                    <td>
                        <asp:Label ID="lblJerseyName" CssClass="label" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td><span>Jersey Number:</span></td>
                    <td>
                        <asp:Label ID="lblJerseyNumber" CssClass="label" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td><span>Price:</span></td>
                    <td>
                        <asp:Label ID="lblPrice" CssClass="label" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <asp:Label ID="lblExistingCustomer" CssClass="label" runat="server" Text="Customer Email: "></asp:Label>
            <asp:TextBox ID="txtEmail" CssClass="textbox" runat="server" MaxLength="50"></asp:TextBox>
            <asp:Button ID="btnExistingCustomer" CssClass="button" CausesValidation="false" runat="server" Text="Existing Customer" OnClick="btnExistingCustomer_Click" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" runat="server" ControlToValidate="txtEmail" ForeColor="White" ErrorMessage="Required"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" Display="Dynamic" ControlToValidate="txtEmail" ForeColor="White" runat="server" ErrorMessage="Must be an email address." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            <br />
            <p style="font-size: 14px;">Note: Existing customers should type their email, then click 'Existing Customer' in order to populate their information.</p>
            <br />
            <h3>Customer Information</h3>
            <table>
                <tr>
                    <td><span>First Name:</span></td>
                    <td>
                        <asp:TextBox ID="txtFirstName" CssClass="textbox" runat="server" MaxLength="50"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" runat="server" ControlToValidate="txtFirstName" ForeColor="White" ErrorMessage="Required"></asp:RequiredFieldValidator>
                       
                    </td>
                </tr>
                <tr>
                    <td><span>Last Name:</span></td>
                    <td>
                        <asp:TextBox ID="txtLastName" CssClass="textbox" runat="server" MaxLength="50"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Display="Dynamic" runat="server" ControlToValidate="txtLastName" ForeColor="White" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td><span>Address:</span>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAddress" CssClass="textbox" runat="server" MaxLength="50"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Display="Dynamic" runat="server" ControlToValidate="txtAddress" ForeColor="White" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td><span>City:</span>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCity" CssClass="textbox" runat="server" MaxLength="50"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" Display="Dynamic" runat="server" ControlToValidate="txtCity" ForeColor="White" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td><span>State:</span>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlState" CssClass="ddl" runat="server">
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
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" Display="Dynamic" ControlToValidate="ddlState" InitialValue="SelectState" ForeColor="White" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td><span>Zip Code:</span>
                    </td>
                    <td>
                        <asp:TextBox ID="txtZip" CssClass="textbox" runat="server" MaxLength="10"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" Display="Dynamic" ControlToValidate="txtZip" ForeColor="White" ErrorMessage="Required"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" Display="Dynamic" ControlToValidate="txtZip" ForeColor="White" runat="server" ErrorMessage="Format: 99999" ValidationExpression="^\d{5}$"></asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td><span>Phone Number:</span>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPhoneNumber" CssClass="textbox" runat="server" MaxLength="12"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Display="Dynamic" ControlToValidate="txtPhoneNumber" ForeColor="White" ErrorMessage="Required"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" Display="Dynamic" ControlToValidate="txtPhoneNumber" ForeColor="White" runat="server" ErrorMessage="Format: 999-999-9999" ValidationExpression="^[2-9]\d{2}-\d{3}-\d{4}$"></asp:RegularExpressionValidator>
                    </td>
                </tr>
            </table>
            <asp:Button ID="btnConfirmation" runat="server" CssClass="button" Text="Confirm Order" OnClick="btnConfirmation_Click" />
            <br />
            <asp:Label ID="lblConfirmationMessage" runat="server" Text=""></asp:Label>
        </div>



    </form>
</body>
</html>
