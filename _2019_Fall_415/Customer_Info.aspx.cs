using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Order_History : System.Web.UI.Page
{
    /// <summary>
    /// The page load for customer infor only displays the GridView of the Customer info and the attributes to edit the customer info in the form of textboxes are hidden
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        if (!IsPostBack)
        {
            bool blnIsNewCustomer = true;
            Session["InsertNewCustomer"] = blnIsNewCustomer;
            addmodifycustomers.Attributes["class"] = "hidden";
        }
    }
    /// <summary>
    /// when the find customer button is clicked the fields for all the customer informationm textboxes are filled with the data from the selected customer in the GridView
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnFindCustomer_Click(object sender, EventArgs e)
    {
        form1.DefaultButton = "btnSubmit";
        addmodifycustomers.Attributes["class"] = "nothidden";
        ProjectCustomer selectedRecord = GetSelectedRecord();
        if (selectedRecord.CustomerID != 0)
        {
            txtEmail.DataBind();
            GridView1.DataSourceID = sdsSelectedCustomer.ID;
            Session["InsertNewCustomer"] = false;
            Session["LoadedCustomer"] = selectedRecord;

            txtCustomerFirst.Text = selectedRecord.CustomerFname;
            txtCustomerLast.Text = selectedRecord.CustomerLName;
            txtCustomerAddress.Text = selectedRecord.CustomerStreetAddress;
            txtCustomerCity.Text = selectedRecord.CustomerCity;
            ddlState.SelectedIndex = ddlState.Items.IndexOf(ddlState.Items.FindByValue(selectedRecord.CustomerState));
            txtCustomerZip.Text = selectedRecord.CustomerZipCode;
            txtCustomerPhone.Text = selectedRecord.CustomerPhone;

        }
        //if the customer is new the delete button will not work because there is no record yet that exists to delete
        else
        {
            btnDelete.Enabled = false;
            //SHOW HIDDEN CUSTOMER FIELDS SO THEY CAN ADD NEW CUSTOMER
        }


    }
    /// <summary>
    /// when the reset button is clicked the modify customer textboxes are cleared
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnReset_Click(object sender, EventArgs e)
    {
        GridView1.DataSourceID = SqlDataSource1.ID;
        txtEmail.Text = "";
        txtCustomerFirst.Text = "";
        txtCustomerLast.Text = "";
        txtCustomerAddress.Text = "";
        txtCustomerCity.Text = "";
        ddlState.SelectedIndex = 0;
        txtCustomerZip.Text = "";
        txtCustomerPhone.Text = "";
        addmodifycustomers.Attributes["class"] = "hidden";
    }
    /// <summary>
    /// this code gets the customer information from the database and populates the customer data fields 
    /// </summary>
    /// <returns></returns>
    private ProjectCustomer GetSelectedRecord()
    {
        ProjectCustomer p = new ProjectCustomer();

        DataView customersTable = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        customersTable.RowFilter = string.Format("CustomerEmail = '{0}'", txtEmail.Text);

        try
        {
            DataRowView row = customersTable[0];
            p.CustomerID = Convert.ToInt32(row["CustomerID"]);
            p.CustomerFname = row["CustomerFName"].ToString();
            p.CustomerLName = row["CustomerLName"].ToString();
            p.CustomerStreetAddress = row["CustomerStreetAddress"].ToString();
            p.CustomerCity = row["CustomerCity"].ToString();
            p.CustomerState = row["CustomerState"].ToString();
            p.CustomerZipCode = row["CustomerZipCode"].ToString();
            p.CustomerPhone = row["CustomerPhone"].ToString();
        }
        catch (IndexOutOfRangeException)
        {

        }
        return p;
    }

    /// <summary>
    /// the submit button saves the new or modified customer data to the database
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MMABooksConnectionString2"].ConnectionString;
        SqlConnection con = new SqlConnection();
        con.ConnectionString = strConnectionString;
        SqlCommand command;
        if ((bool)Session["InsertNewCustomer"])
        {
            con.Open();
            //ADD customer to CustomerTable
            string strInsertCustomer = "INSERT INTO dbo.CustomerTable (CustomerFname,CustomerLName,CustomerStreetAddress,CustomerCity,CustomerState,CustomerZipCode,CustomerPhone,CustomerEmail) VALUES (@CustomerFirst,@CustomerLast,@Address, @City,@State,@ZipCode,@PhoneNumber,@Email)";
            command = new SqlCommand(strInsertCustomer, con);
            command.Parameters.AddWithValue("@CustomerFirst", txtCustomerFirst.Text);
            command.Parameters.AddWithValue("@CustomerLast", txtCustomerLast.Text);
            command.Parameters.AddWithValue("@Address", txtCustomerAddress.Text);
            command.Parameters.AddWithValue("@City", txtCustomerCity.Text);
            command.Parameters.AddWithValue("@State", ddlState.SelectedItem.Text);
            command.Parameters.AddWithValue("@ZipCode", txtCustomerZip.Text);
            command.Parameters.AddWithValue("@PhoneNumber", txtCustomerPhone.Text);
            command.Parameters.AddWithValue("@Email", txtEmail.Text);
            command.ExecuteNonQuery();
            con.Close();
            GridView1.DataSourceID = SqlDataSource1.ID;
            txtEmail.Text = "";
            txtCustomerFirst.Text = "";
            txtCustomerLast.Text = "";
            txtCustomerAddress.Text = "";
            txtCustomerCity.Text = "";
            ddlState.SelectedIndex = 0;
            txtCustomerZip.Text = "";
            txtCustomerPhone.Text = "";
            addmodifycustomers.Attributes["class"] = "hidden";
            txtEmail.DataBind();
        }
        //if the customer record already exists this will update thier information
        else
        {
            ProjectCustomer existing = (ProjectCustomer)Session["LoadedCustomer"];
            con.Open();
            //UPDATE customer in CustomerTable
            string strUpdateCustomer = "UPDATE dbo.CustomerTable " +
                "SET CustomerFname = @CustomerFirst, " +
                "CustomerLName = @CustomerLast, " +
                "CustomerStreetAddress = @Address, " +
                "CustomerCity = @City, " +
                "CustomerState = @State, " +
                "CustomerZipCode = @ZipCode, " +
                "CustomerPhone = @PhoneNumber, " +
                "CustomerEmail = @Email " +
                "WHERE CustomerID = @ID;"
            ;
            command = new SqlCommand(strUpdateCustomer, con);
            command.Parameters.AddWithValue("@CustomerFirst", txtCustomerFirst.Text);
            command.Parameters.AddWithValue("@CustomerLast", txtCustomerLast.Text);
            command.Parameters.AddWithValue("@Address", txtCustomerAddress.Text);
            command.Parameters.AddWithValue("@City", txtCustomerCity.Text);
            command.Parameters.AddWithValue("@State", ddlState.SelectedItem.Value);
            command.Parameters.AddWithValue("@ZipCode", txtCustomerZip.Text);
            command.Parameters.AddWithValue("@PhoneNumber", txtCustomerPhone.Text);
            command.Parameters.AddWithValue("@Email", txtEmail.Text);
            command.Parameters.AddWithValue("@ID", existing.CustomerID);
            command.ExecuteNonQuery();
            con.Close();
            GridView1.DataBind();
        }
    }
    /// <summary>
    /// this delete button when clicked will first warn the user that the record will be deleted forever and then changes the button text to say "confirm delete"
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!lblDeleteConfirmation.Visible)
        {
            lblDeleteConfirmation.Text = "Deleting a customer is an irreversable process. If you would like to continue, please click &#34;Confirm Delete&#34;";
            lblDeleteConfirmation.Visible = true;
            btnDelete.Text = "Confirm Delete";
        }
        else if (!((bool)Session["InsertNewCustomer"]))
        {
            string strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MMABooksConnectionString2"].ConnectionString;
            SqlConnection con = new SqlConnection();
            con.ConnectionString = strConnectionString;
            SqlCommand command;

            ProjectCustomer existing = (ProjectCustomer)Session["LoadedCustomer"];
            con.Open();
            //DELETE customer from CustomerTable
            string strDeleteCustomer = "DELETE FROM CustomerTable WHERE CustomerID=@ID;"
            ;
            command = new SqlCommand(strDeleteCustomer, con);
            command.Parameters.AddWithValue("@ID", existing.CustomerID);
            command.ExecuteNonQuery();
            con.Close();
            GridView1.DataSourceID = SqlDataSource1.ID;
            txtEmail.Text = "";
            txtCustomerFirst.Text = "";
            txtCustomerLast.Text = "";
            txtCustomerAddress.Text = "";
            txtCustomerCity.Text = "";
            ddlState.SelectedIndex = 0;
            txtCustomerZip.Text = "";
            txtCustomerPhone.Text = "";
            addmodifycustomers.Attributes["class"] = "hidden";
            lblDeleteConfirmation.Visible = false;
            Session["InsertNewCustomer"] = true;
            btnDelete.Text = "Delete Customer";
        }
        //if the customer record does not yet exist it will not delete anything and an error message will display to the user
        else
        {
            lblDeleteConfirmation.Text = "You cannot delete a new customer.";
            lblDeleteConfirmation.Visible = true;
        }
    }
}