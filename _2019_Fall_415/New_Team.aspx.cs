using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class New_Team : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;//unobtrusive validation is disabled
    }

    protected void btnAddTeam_Click(object sender, EventArgs e)
    {
        string strConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MMABooksConnectionString2"].ConnectionString;
        string query = "";
        SqlConnection con = new SqlConnection();
        con.ConnectionString = strConnectionString;//allows for connection to SQL Database
        SqlCommand command;

        con.Open();
        query = "INSERT INTO dbo.TeamTable (TeamName,TeamColorID) " +
            "VALUES (@TeamName,@TeamColorID)";//code for insert statement for the TeamTable in our sql database, this allows user to add a new team to the database from our webform
        command = new SqlCommand(query, con);
        command.Parameters.AddWithValue("@TeamName", txtNewTeamName.Text);//sets parameters of new entry to be equal to text typed in the teamname textbox, as inputted by user
        command.Parameters.AddWithValue("@TeamColorID", ddlTeamColor.SelectedValue);//sets parameters of new entry to be equal to selection made in team color drop down list, as selected by user
        command.ExecuteNonQuery();//executes insert statement with information that has been inputted for the parameters
        con.Close();
        GridView1.DataBind();//Makes sure the grid view shows the now updated information 

    }
}