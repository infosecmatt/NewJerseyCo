using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Team_Information : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnFindTeam_Click(object sender, EventArgs e)
    {
        if (txtTeamName.Text != "")//as long as the team name entered is not blank
        {
            GridView1.DataSourceID = sdsTeamMembers.ID;//the teams members will be displayed, if the team does not exist, no team members will be displayed, meaning the team is not on record in our system
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        GridView1.DataSourceID = SqlDataSource1.ID;//brings you back to default grid view with all different teams and their members, unfiltered
    }
}