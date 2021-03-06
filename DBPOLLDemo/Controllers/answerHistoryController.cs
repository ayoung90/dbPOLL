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
    public class answerHistoryController : Controller
    {
        //
        // GET: /answerHistory/

        public ActionResult Index(int id, String name)
        {
            if (Session["uid"] == null || Session["uid"].ToString().Equals(""))
            {
                return RedirectToAction("Index", "Home");
            }
            if ((int)Session["user_type"] < User_Type.POLL_MASTER)
            {
                return RedirectToAction("Invalid", "Home");
            }

            answerHistoryModel a = new answerHistoryModel();
            List<answerHistoryModel> list = a.displayAnswerHistory(id);
            ViewData["name"] = name;
            if (list.Count > 0)
            {
                
                return View(list);
            }
            else 
            {
                ViewData["message"] = "There are no previous versions of this answer.";
                return View(list);
            }
        }


        public ActionResult Revert(int answerid, String answer, int correct, String weight, string ansnum)
        {
            if (Session["uid"] == null || Session["uid"].ToString().Equals(""))
            {
                return RedirectToAction("Index", "Home");
            }
            if ((int)Session["user_type"] < User_Type.POLL_MASTER)
            {
                return RedirectToAction("Invalid", "Home");
            }
            
            answerModel a = new answerModel();
            a = a.getAnswer(answerid);

            /* Create a record of the old answer in the Answer History table */
            new answerHistoryModel(answerid).createAnswerHistory(a.answerid, a.answer, a.correct, a.weight, a.ansnum);

            /* Update the answer*/
            a.updateAnswer(answerid, answer, correct, int.Parse(weight), int.Parse(ansnum));
            a = a.getAnswer(answerid);
            return RedirectToAction("Index", "answerHistory", new { id = a.answerid, name = a.answer } );
        }

        public ActionResult Delete(int aid, int ahid) 
        {
            if (Session["uid"] == null || Session["uid"].ToString().Equals(""))
            {
                return RedirectToAction("Index", "Home");
            }
            if ((int)Session["user_type"] < User_Type.POLL_MASTER)
            {
                return RedirectToAction("Invalid", "Home");
            }

            new answerHistoryModel(ahid).deleteAnswerHistory();

            answerModel a = new answerModel();
            a = a.getAnswer(aid);
            return RedirectToAction("Index", "answerHistory", new { id = a.answerid, name = a.answer });
        }
    }
  
}
