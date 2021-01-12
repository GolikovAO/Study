using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using CRUD.Models.Repos;
using CRUD.Models.Entites;

namespace CRUD
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            List <SW> SWs = new List <SW> ();

            SWs.Add(new SW("M12D4", "Machete", 12, 1000, 350, 2.5, 154, 280));
            SWs.Add(new SW("LP 15", "Pride", 15, 1270, 450, 2.5, 168, 354));
            SWs.Add(new SW("Sport M12D1", "Machete", 12, 1500, 750, 2.75, 168, 281.5));
            SWs.Add(new SW("SA-15 V3 D2", "Sundown Audio", 15, 1450, 750, 2.5, 191, 359));
            SWs.Add(new SW("PATRIOT 8", "Ural", 8, 1500, 750, 2, 125, 215));
            SWs.Add(new SW("HSS-2812 D2", "Hannibal", 12, 1200, 600, 2.75, 154.7, 283.6));
            SWs.Add(new SW("Pro-Power 301D", "Kicx", 12, 1250, 2500, 3, 205, 284));
            foreach (var sw in SWs)
                SWrepos.Instance.Add(sw);
        }
    }
}
