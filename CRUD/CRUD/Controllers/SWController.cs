using System;
using System.Web.Mvc;
using CRUD.Models.Repos;
using CRUD.Models.Entites;


namespace CRUD.Controllers
{
    // Класс Контроллер
    public class SWController : Controller
    {
        [HttpGet]
        public ViewResult Index() // Возвращает html код с данными сабвуферов
        {
            var sws = SWrepos.Instance.SWs;
            ViewBag.SWs = sws;
            return View();
        }

        [HttpPost]
        public ActionResult Delete(int id) // удаляет сабвуфер по id
        {
            SWrepos.Instance.Remove(id);
            var sws = SWrepos.Instance.SWs;
            ViewBag.SWs = sws;
            return View("Index");
        }

        [HttpGet]
        public ViewResult Extract(int id = 0)  // метод для редактирования и создания
        {
            SW sw;
            ViewBag.Method = "post";
            if (id == 0)
            {
                sw = null;
                ViewBag.header = "Добавить новый сабвуфер";
                ViewBag.Action = "Create";
            }
            else
            {
                sw = SWrepos.Instance.Find(id); // находит по id сабвуфер
                ViewBag.header = "Редактировать";
                ViewBag.Action = "Update";
            }
            ViewBag.sw = sw;
            return View("sw"); 
        }

        [HttpPost]
        public ActionResult Update(string model, string manufacturer, string diameter,
             string max, string rms, string dCoil, string idepth, string idiam, string id)
        { // второй метод для редактирования
            try
            {
                SW sw = new SW(model, manufacturer, Convert.ToInt32(diameter), Convert.ToInt32(max),
                       Convert.ToInt32(rms), Convert.ToDouble(dCoil), Convert.ToDouble(idepth),
                       Convert.ToDouble(idiam), Convert.ToInt32(id));
                SWrepos.Instance.Update(sw);
                var sws = SWrepos.Instance.SWs;
                ViewBag.SWs = sws;
                return View("Index");
            }
            catch (Exception ex)
            {
                ViewBag.ErrMessage = ex.Message;
                return View("ExceptPage");
            }
        }


        [HttpPost]
        public ActionResult Create(string model, string manufacturer, string diameter,
             string max, string rms, string dCoil, string iDepth, string iDiam)
        { // второй метод для добавления
            try
            {
                SW sw = new SW(model, manufacturer, Convert.ToInt32(diameter), Convert.ToInt32(max),
                    Convert.ToInt32(rms), Convert.ToDouble(dCoil), Convert.ToDouble(iDepth),
                    Convert.ToDouble(iDiam));

                SWrepos.Instance.Add(sw);
                var sws = SWrepos.Instance.SWs;
                ViewBag.SWs = sws;
                return View("Index");
            }
            catch (Exception ex)
            {
                ViewBag.ErrMessage = ex.Message;
                return View("ExceptPage");
            }
        }

        [HttpGet]
        public ViewResult Show(int id) // для просмотра
        { 
            ViewBag.sw = SWrepos.Instance.Find(id);
            return View();
        }
    }
}