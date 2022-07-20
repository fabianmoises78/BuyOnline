using BuyOnline.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BuyOnline.Controllers
{
    public class adminController : Controller
    {
        // GET: admin
        Datos conexion = new Datos();

        public ActionResult Mantenimiento()
        {
            return View();
        }

        public ActionResult LoginAdmin()
        {
            return View();
        }

        public ActionResult CRUDpais()
        {
            return View();
        }

        public ActionResult CRUDcliente()
        {
            return View();
        }

        public JsonResult

        public ActionResult CRUDadmin()
        {
            return View();
        }

        public ActionResult CRUDcategoria()
        {
            return View();
        }

        public ActionResult CRUDestados()
        {
            return View();
        }

        public ActionResult CRUDcompras()
        {
            return View();
        }

        public ActionResult CRUDdetallecompra()
        {
            return View();
        }

        public ActionResult CRUDproductos()
        {
            return View();
        }

        public ActionResult CRUDtarjeta()
        {
            return View();
        }

        public ActionResult CRUDtipopago()
        {
            return View();
        }
    }
}