using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ProjectCustomer
/// </summary>
public class ProjectCustomer
{
    public int CustomerID { get; set; }

    public string CustomerFname { get; set; }

    public string CustomerLName { get; set; }

    public string CustomerStreetAddress { get; set; }
    public string CustomerCity { get; set; }
    public string CustomerState { get; set; }
    public string CustomerZipCode { get; set; }

    public string CustomerPhone { get; set; }

    public string CustomerEmail { get; set; }

    public int TeamID { get; set; }




    public ProjectCustomer()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}