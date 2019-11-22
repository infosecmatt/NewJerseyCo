using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Populates the confirm order form with information from jersey customization form 
/// </summary>
public partial class Order_Here : System.Web.UI.Page
{
    //creates a variable selectedRecord that will be used to get an existing customer, used across multiple methods, so it is declared outside of a method for easier access
    private ProjectCustomer selectedRecord;


    /// <summary>
    /// When the page is loaded, unobtrusive validation is turned off.
    /// If the page is being loaded for the first time, it imports the information from the jersey options page and stores it in a session variable.
    /// In addition, it displays the jersey configuration to the user.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        if (!IsPostBack)
        {
            //breates a variable indicating that the customer is new.
            Session["IsExistingCustomer"] = false;
            DropDownList ddlTeamName = (DropDownList)PreviousPage.FindControl("ddlTeamNames");
            Session["SelectedTeamID"] = ddlTeamName.SelectedItem.Value;
            DropDownList ddlJerseyColor = (DropDownList)PreviousPage.FindControl("ddlColor");
            Session["SelectedColorID"] = ddlJerseyColor.SelectedItem.Value;
            DropDownList ddlJerseySize = (DropDownList)PreviousPage.FindControl("ddlSize");
            Session["SelectedSizeID"] = ddlJerseySize.SelectedItem.Value;
            Label lblJerseyPrice = (Label)PreviousPage.FindControl("lblPrice");
            DropDownList ddlJerseyNumber = (DropDownList)PreviousPage.FindControl("ddlNumber");
            Session["SelectedJerseyNumber"] = ddlJerseyNumber.SelectedItem.Value;
            TextBox txtJerseyName = (TextBox)PreviousPage.FindControl("txtJerseyName");
            lblTeamName.Text = ddlTeamName.SelectedItem.Text;
            lblJerseyNumber.Text = ddlJerseyNumber.Text;
            lblJerseyName.Text = txtJerseyName.Text;
            lblJerseySize.Text = ddlJerseySize.SelectedItem.Text;
            lblPrice.Text = lblJerseyPrice.Text;
            lblJerseyColor.Text = ddlJerseyColor.SelectedItem.Text;
        }


    }
    /// <summary>
    /// polulate existing customer information
    /// </summary>
    /// <returns></returns>
    private ProjectCustomer GetSelectedRecord()
    {

        DataView customersTable = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        //selects customer based on their email address
        customersTable.RowFilter = string.Format("CustomerEmail = '{0}'", txtEmail.Text);

        DataRowView row = customersTable[0];

        //creates and populates ProjectCustomer variable
        ProjectCustomer p = new ProjectCustomer();
        p.CustomerID = Convert.ToInt32(row["CustomerID"]);
        p.CustomerFname = row["CustomerFName"].ToString();
        p.CustomerLName = row["CustomerLName"].ToString();
        p.CustomerStreetAddress = row["CustomerStreetAddress"].ToString();
        p.CustomerCity = row["CustomerCity"].ToString();
        p.CustomerState = row["CustomerState"].ToString();
        p.CustomerZipCode = row["CustomerZipCode"].ToString();
        p.CustomerPhone = row["CustomerPhone"].ToString();

        return p;
    }
    /// <summary>
    /// If user indicates they are an existing customer, then it will populate their information based on their email address.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnExistingCustomer_Click(object sender, EventArgs e)
    {
        //imports record of customer
        selectedRecord = this.GetSelectedRecord();
        //customerID can't be 0, so if the customer ID isn't 0 they must exist in the DB
        if (selectedRecord.CustomerID != 0)
        {
            //customer isn't new
            Session["IsExistingCustomer"] = true;
            Session["ExistingCustomer"] = selectedRecord;
            txtEmail.DataBind();

            //populate fields with customer info
            txtFirstName.Text = selectedRecord.CustomerFname;
            txtLastName.Text = selectedRecord.CustomerLName;
            txtAddress.Text = selectedRecord.CustomerStreetAddress;
            txtCity.Text = selectedRecord.CustomerCity;
            ddlState.SelectedIndex = ddlState.Items.IndexOf(ddlState.Items.FindByValue(selectedRecord.CustomerState));
            txtZip.Text = selectedRecord.CustomerZipCode;
            txtPhoneNumber.Text = selectedRecord.CustomerPhone;
        }
    }

    /// <summary>
    /// Confirms order. Adds new customers to DB. Adds order to DB. Prevents accidental duplicate orders.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnConfirmation_Click(object sender, EventArgs e)
    {
        string strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MMABooksConnectionString2"].ConnectionString;
        SqlConnection con = new SqlConnection();
        con.ConnectionString = strConnectionString;
        SqlCommand command;

        //for new customers
        if ((bool)Session["IsExistingCustomer"] == false)
        {
            con.Open();
            //ADD customer to CustomerTable
            string strInsertCustomer = "INSERT INTO dbo.CustomerTable (CustomerFname,CustomerLName,CustomerStreetAddress,CustomerCity,CustomerState,CustomerZipCode,CustomerPhone,CustomerEmail) VALUES (@CustomerFirst,@CustomerLast,@Address, @City,@State,@ZipCode,@PhoneNumber,@Email)";
            command = new SqlCommand(strInsertCustomer, con);
            command.Parameters.AddWithValue("@CustomerFirst", txtFirstName.Text);
            command.Parameters.AddWithValue("@CustomerLast", txtLastName.Text);
            command.Parameters.AddWithValue("@Address", txtAddress.Text);
            command.Parameters.AddWithValue("@City", txtCity.Text);
            command.Parameters.AddWithValue("@State", ddlState.SelectedItem.Text);
            command.Parameters.AddWithValue("@ZipCode", txtZip.Text);
            command.Parameters.AddWithValue("@PhoneNumber", txtPhoneNumber.Text);
            command.Parameters.AddWithValue("@Email", txtEmail.Text);
            command.ExecuteNonQuery();
            con.Close();

            Session["ExistingCustomer"] = GetSelectedRecord();

        }
        //import selected ColorId and SizeID
        int intColorID = Convert.ToInt32(Session["SelectedColorID"]);
        int intSizeID = Convert.ToInt32(Session["SelectedSizeID"]);

        ProjectCustomer orderer = (ProjectCustomer)Session["ExistingCustomer"];
        con.Open();
        string strInsertOrder = "";
        //insert user to TeamMembersTable if they are on a team
        if (lblTeamName.Text != "None")
        {
            int intTeamID = Convert.ToInt32(Session["SelectedTeamID"]);
            strInsertOrder = "INSERT INTO dbo.OrderTable (CustomerID,ColorID,SizeID,JerseyName,JerseyNumber,TeamID) " +
            "VALUES (@CustomerID,@ColorID,@SizeID,@JerseyName,@JerseyNumber,@TeamID);" +
            "INSERT INTO dbo.TeamMembersTable (TeamID,CustomerID) " +
            "VALUES (@TeamID,@CustomerID);";
            command = new SqlCommand(strInsertOrder, con);
            command.Parameters.AddWithValue("@TeamID", intTeamID);
        }
        //just insert into order table
        else
        {
            strInsertOrder = "INSERT INTO dbo.OrderTable (CustomerID,ColorID,SizeID,JerseyName,JerseyNumber) " +
            "VALUES (@CustomerID,@ColorID,@SizeID,@JerseyName,@JerseyNumber)";
            command = new SqlCommand(strInsertOrder, con);
        }
        command.Parameters.AddWithValue("@CustomerID", orderer.CustomerID);
        command.Parameters.AddWithValue("@ColorID", intColorID);
        command.Parameters.AddWithValue("@SizeID", intSizeID);
        command.Parameters.AddWithValue("@JerseyName", lblJerseyName.Text);
        command.Parameters.AddWithValue("@JerseyNumber", Convert.ToInt32(lblJerseyNumber.Text));
        command.ExecuteNonQuery();
        con.Close();
        lblConfirmationMessage.Text = "Your order has been confirmed!";
    }
}