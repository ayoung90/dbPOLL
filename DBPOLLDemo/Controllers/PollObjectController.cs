﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using DBPOLLDemo.Models;
using System.Threading;
using System.Globalization;

namespace DBPOLLDemo.Controllers
{
    public class PollObjectController : Controller
    {
        //
        // GET: /Object/

        public ActionResult Index(int pollid, String pollname)
        {
            if (Session["uid"] == null || Session["uid"].ToString().Equals(""))
            {
                return RedirectToAction("Index", "Home");
            }
            if ((int)Session["user_type"] < User_Type.POLL_MASTER)
            {
                return RedirectToAction("Invalid", "Home");
            }

            ViewData["pollid"] = pollid;
            ViewData["pollname"] = pollname;
            return View(new pollObjectModel().indexObjects(pollid));
        }
        
       
        public ActionResult Delete(int objectid, int pollid)
        {
            if (Session["uid"] == null || Session["uid"].ToString().Equals(""))
            {
                return RedirectToAction("Index", "Home");
            }
            if ((int)Session["user_type"] < User_Type.POLL_CREATOR)
            {
                return RedirectToAction("Invalid", "Home");
            }

            pollObjectModel ob = new pollObjectModel(objectid);
            ob.deleteObject();

            return RedirectToAction("Index", "PollObject", new { pollid = pollid, pollname = ViewData["pollname"] });
        }

        //
        // GET: /Object/Create

        public ActionResult Create(int pollid)
        {
            if (Session["uid"] == null || Session["uid"].ToString().Equals(""))
            {
                return RedirectToAction("Index", "Home");
            }
            if ((int)Session["user_type"] < User_Type.POLL_CREATOR)
            {
                return RedirectToAction("Invalid", "Home");
            }
            ViewData["pollid"] = pollid;
            return View();
        }

        //
        // POST: /Object/Create

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(int obtype, String attribute, int pollid)
        {
            if (Session["uid"] == null || Session["uid"].ToString().Equals(""))
            {
                return RedirectToAction("Index", "Home");
            }
            if ((int)Session["user_type"] < User_Type.POLL_CREATOR)
            {
                return RedirectToAction("Invalid", "Home");
            }



            ViewData["pollid"] = pollid;

            pollObjectModel ob = new pollObjectModel();

            if (ob.getObject(obtype, pollid).obid != -1)
            {
                ViewData["created"] = "This object already exists.";
                return View();
            }

            try
            {
                switch (obtype)
                {
                    case 1:
                        ViewData["created"] = "Added a Countdown Timer";
                        break;
                    case 2:
                        ViewData["created"] = "Added a Response Counter";
                        break;
                    case 3:
                        ViewData["created"] = "Added a Correct Answer Indicator";
                        break;
                    default:
                        break;
                }
                pollObjectModel po = new pollObjectModel();
                po.createObject(obtype, attribute, pollid);

                //return RedirectToAction("Index", new { pollid = pollid });
                return View();
            }
            catch (Exception e)
            {
                ViewData["error1"] = "!ERROR: " + e.Message;
                return View();
            }
        }

    }
}
