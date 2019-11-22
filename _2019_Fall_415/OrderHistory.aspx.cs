using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OrderHistory : System.Web.UI.Page
{
    /// <summary>
    /// The page load does not have any parameters because it simply displays the GridView for the order history table and a find customer textbox
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    /// <summary>
    /// the find order button when clicked displays only that chose customer on the GridView with the data from the database
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnFindOrder_Click(object sender, EventArgs e)
    {
        if (txtEmail.Text != "")
        {
            GridView1.DataSourceID = sdsCustomerOrders.ID;
        }
    }
    //the reset button when clicked reconnects the GridView to the SQL data source and displays all the customer records again
    protected void btnReset_Click(object sender, EventArgs e)
    {
        GridView1.DataSourceID = SqlDataSource1.ID;
    }
}