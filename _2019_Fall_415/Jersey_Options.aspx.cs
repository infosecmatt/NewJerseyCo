using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Jersey_Options : System.Web.UI.Page
{
    /// <summary>
    /// This is the key business process that connects the color table to the size table, and leads into the page that connects the order and customer tables.
    /// This page allows users to customize and order jerseys.
    /// 
    /// When page loads, turn off unobtrusive validation and populate jersey number dropdown with the numbers 0-99
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        int x = 0;
       while ( x < 100)
            {
            ddlNumber.Items.Add(Convert.ToString(x));
            x++;
        }
        
    }

    protected void btnConfirmOrder_Click(object sender, EventArgs e)
    {
        
    }

    /// <summary>
    /// Based on what the user selects as their jersey size, this function gets the price of the jersey and returns it.
    /// </summary>
    /// <param name="strSize">The chosen jersey size as determined by the customer</param>
    /// <returns>the price of the jersey size given by the variable strSize</returns>
    private decimal GetPrice(string strSize)
    {
        SqlConnection con = new SqlConnection();

        string strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MMABooksConnectionString2"].ConnectionString;
        con.ConnectionString = strConnectionString;
        con.Open();
        string query = "SELECT Price FROM SizeTable WHERE Size = @size";
        SqlCommand command = new SqlCommand(query, con);
        command.Parameters.AddWithValue("@size", strSize);
       
        SqlDataReader reader = command.ExecuteReader();
        decimal decPrice = 0;
        //if the chosen size exists, this will set decPrice to what the database returned
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                decPrice = reader.GetDecimal(0);
            }
        }
        reader.Close();
        con.Close();
        return decPrice;

    }
    /// <summary>
    /// If the user selects a team, the team color is automatically populated and the user is unable to change it.
    /// </summary>
    /// <param name="intTeamID">ID of selected team</param>
    /// <returns>returns the ID of the team color</returns>
    private int GetTeamColorID(int intTeamID)
    {
        SqlConnection con = new SqlConnection();

        string strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MMABooksConnectionString2"].ConnectionString;
        con.ConnectionString = strConnectionString;
        con.Open();
        //gets the ColorID for the selected team
        string query = 
            "SELECT TeamColorID " +
            "FROM dbo.TeamTable " +
            "WHERE TeamID = @TeamID";
        SqlCommand command = new SqlCommand(query, con);
        command.Parameters.AddWithValue("@TeamID", intTeamID);

        //run query
        SqlDataReader reader = command.ExecuteReader();
        //sets default color id, can't exist in DB
        int intTeamColorID = -1;
        //if query returns something
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                intTeamColorID = reader.GetInt32(0);
            }
            
        }
        reader.Close();
        con.Close();
        return intTeamColorID;
    }

    /// <summary>
    /// When user selects a size, set lblPrice to the respective price for the size
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlSize_SelectedIndexChanged(object sender, EventArgs e)
    {
        //calls GetPrice() function which queries the DB for the price of a given size
        decimal decReturnPrice = GetPrice(ddlSize.SelectedItem.Text);
        //formats as currency
        lblPrice.Text = decReturnPrice.ToString("c2");
    }

    /// <summary>
    /// if the customer has selected a team, sets color to the given team's color and disables the ability to choose a color
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ddlTeamNames_SelectedIndexChanged(object sender, EventArgs e)
    {
        //user has selected a team
        if (ddlTeamNames.SelectedItem.Text != "None")
        {
            //gets ColorID based on TeamID
            int intTeamColorID = GetTeamColorID(Convert.ToInt32(ddlTeamNames.SelectedValue));
            ddlColor.SelectedValue = intTeamColorID.ToString();
            ddlColor.Enabled = false;
            //CSS class that changes the appearance of a disabled ddl
            ddlColor.CssClass = "ddldisabled";
        }
        //none is selected
        else
        {
            ddlColor.Enabled = true;
            ddlColor.CssClass = "ddl";
        }
    }
}