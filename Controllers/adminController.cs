using BuyOnline.DTO;
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

        [HttpPost]
        [Route("ListaPais")]
        public JsonResult ListaPais()
        {
            List<ListarPais_Result> ListaPais = new List<ListarPais_Result>();

            using (conexion)
            {
                var listarpaises = conexion.ListarPais();
                foreach(var item in listarpaises)
                {
                    var asignar = new ListarPais_Result()
                    {
                        IdPais = item.IdPais,
                        NombrePais = item.NombrePais
                    };
                    ListaPais.Add(asignar);
                }
            }
            return Json(ListaPais);
        }

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

        [HttpPost]
        [Route("ListarClientes")]
        public JsonResult ListarClientes()
        {
            List<ShowCostumerXPersona_Result> clientes = new List<ShowCostumerXPersona_Result>();
            using (conexion)    
            {
                var listarClientes = conexion.ShowCostumerXPersona();

                foreach(var item in listarClientes)
                {
                    var asignar = new ShowCostumerXPersona_Result()
                    {
                        IdPersona = item.IdPersona,
                        Nombre = item.Nombre,
                        Apellido = item.Apellido,
                        Edad = item.Edad,
                        Telefono = item.Telefono,
                        NombrePais = item.NombrePais,
                        Estado = item.Estado,
                        IdCliente = item.IdCliente,
                        Usuario = item.Usuario,
                        Correo = item.Correo,
                        Contraseña = item.Contraseña
                    };
                    clientes.Add(asignar);
                }
            }
            return Json(clientes);
        }

        public JsonResult RegistrarClientes(string nombre, string apellido, string edad, string numero, string idpais, string usuario, string correo, string contraseña)
        {
            GenericDTO response = new GenericDTO();

            var idpais1 = Convert.ToInt32(idpais);
            var edad1 = Convert.ToInt32(edad);

            try
            {
                conexion.RecordPersonaXcostumer(nombre, apellido, edad1, numero, idpais1, usuario, correo, contraseña);
                response.Message = "Usuario registrado con exito.";
                response.Status = 1;
                return Json(response);
            }
            catch
            {
                response.Message = "Un error ha ocurrido.";
                response.Status = 0;
                return Json(response);
            }
        }

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