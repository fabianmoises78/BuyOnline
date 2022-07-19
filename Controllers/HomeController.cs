using BuyOnline.DTO;
using BuyOnline.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web.Mvc;

namespace BuyOnline.Controllers
{
    public class HomeController : Controller
    {
        Datos conexion = new Datos();

        public ActionResult Index()
        {
            if (Session["Message"] != null)
            {
                ViewBag.Message = Session["Message"];
                Session["Message"] = null;
            }
            //Datos dt = new Datos();
            ViewBag.ListarProducto = ListarProducto();
            return View();
        }
        //[HttpGet]
        //public Producto SearchProduct(String nombre)
        //{
        //    //Datos dt = new Datos();
        //    ViewBag.ListarProducto = ListarProducto();
        //    return View();
        //}

        public List<ShowProducts_Result> ListarProducto()
        {
            Datos td = new Datos();
            List<ShowProducts_Result> result = new List<ShowProducts_Result>();

            using (td)
            {
                var listarProductos = td.ShowProducts();

                foreach (var item in listarProductos)
                {
                    var asiganr = new ShowProducts_Result()
                    {
                        IdProducto = item.IdProducto,
                        Nombre = item.Nombre,
                        Descripcion = item.Descripcion,
                        Imagen = item.Imagen,
                        precio = item.precio,
                        Exis = item.Exis,
                        Valoracion = item.Valoracion,
                        IdEstado = item.IdEstado,
                        Estado = item.Estado,
                        Cat = item.Cat,
                        IdCat = item.IdCat,
                        Detalles = item.Detalles
                    };
                    result.Add(asiganr);
                }
            }
            return result;
        }

        public void InsertarDeseos(int? idproducto)
        {
            string user = Session["Usuario"].ToString();
            Datos dt = new Datos();
        }

        public ActionResult inicio()
        {
            return View();
        }

        public ActionResult Tarjeta()
        {
            return View();
        }

        public void _LoginIniciar(string user, string password)
        {
            Datos dtl = new Datos();

            //var iniciar = dtl.LoginU(user, password);

            using (dtl)
            {
                var iniciarseion = dtl.LoginU(user, password);
            }
        }

        public ActionResult Login()
        {
            if (Session["Message"] != null)
            {
                ViewBag.Message = Session["Message"];
                Session["Message"] = null;
            }
            return View();
        }
        //public Management LoginIniciar(Cliente cliente)
        public JsonResult LoginIniciar(Cliente cliente)
        {
            Datos dtl = new Datos();
            Management mg = new Management();
            GenericDTO dto = new GenericDTO();

            if (Session["Message"] != null)
            {
                Session["Message"] = null;
            }
            try
            {
                List<LoginU_Result> result = dtl.LoginU(cliente.Usuario, cliente.Contraseña).ToList();
                if (result.Count > 0)
                {
                    if (result[0].IdEstado == 1)
                    {
                        dto.Status = 1;
                        dto.Message = "Success";

                        Session["Status"] = "true";
                        Session["IdCliente"] = result[0].IdCliente;
                        Session["Usuario"] = result[0].Usuario;
                        mg.status = "true";
                        //return mg;
                        return Json(dto);
                    }
                    else
                    {
                        dto.Status = 0;
                        dto.Message = "El usuario que intenta ingresar está desactivado.";

                        Session["Status"] = "false";
                        Session["IdCliente"] = "";
                        Session["Usuario"] = "";
                        mg.mensaje = "El usuario que intenta ingresar está desactivado.";
                        //return mg;
                        return Json(dto);
                    }
                }
                else
                {
                    dto.Status = 0;
                    dto.Message = "Error usuario o contraseña no validos.";

                    Session["Message"] = "Ërror usuario o contraseña no validos.";
                    //return mg;
                    return Json(dto);
                }
            }
            catch(Exception ex)
            {
                dto.Status = 0;
                dto.Message = ex.Message;
                return Json(dto);
            }
        }

        public ActionResult RecuperarCuenta()
        {
            return View();
        }
        public ActionResult Logout()
        {
            Session.Abandon();
            return RedirectToAction("Login");
        }

        public ActionResult ViewProduct()
        {
            return View();
        }

        [HttpPost]
        [Route("WishList")]
        public JsonResult WishList(Producto producto, int? idproducto)
        {
            GenericDTO response = new GenericDTO();
            if (Session["Message"] != null)
            {
                Session["Message"] = null;
            }

            var sesion = Convert.ToInt32(Session["IdCliente"]);

            try
            {
                if (sesion > 0)
                {
                    var idcleinte = Convert.ToInt32(Session["IdCliente"]);
                    conexion.RecordWishList(producto.IdProducto, idcleinte);

                    /*
                     * Se elimino el uso se session que enviaba los mensajes, ahora se usa un GenericDTO
                     * El metodo sera llamado desde un request async por lo que ya no debe devolver un ActionResult.
                    */
                    //Session["Message"] = "Producto agregado a favoritos.";
                    response.Message = "Producto agregao a favoritos.";
                    response.Status = 1;
                    return Json(response);
                    
                }
                else
                {
                    response.Message = "Debe iniciar sesion para poder agregar a favoritos";
                    response.Status = 0;
                    return Json(response);
                }
            }catch (Exception ex)
            {
                response.Message = ex.Message;
                response.Status = 0;
                return Json(response);
            }
        }

        public ActionResult Registro()
        {
            ViewBag.ListarPaises = ListarPaises();
            return View();
        }

        public List<Pais> ListarPaises()
        {
            Datos dt = new Datos();
            List<Pais> ListaPais = new List<Pais>();

            using (dt)
            {
                var ListaPaises = dt.ListarPais();

                foreach (var item in ListaPaises)
                {
                    var asignar = new Pais
                    {
                        IdPais = item.IdPais,
                        Nombre = item.Nombre
                    };
                    ListaPais.Add(asignar);
                }
            }
            return ListaPais;
        }

        public ActionResult RegistroNuevo(string nombre, string apellido, string edad, string numero, string pais, string usuario, string correo, string contraseña)
        {
            Datos dt = new Datos();
            //Console.WriteLine(Convert.ToInt32(opciones));
            var edad1 = Convert.ToInt32(edad);
            var pais1 = Convert.ToInt32(pais);
            dt.RecordPersonaXcostumer(nombre, apellido, edad1, numero, pais1, usuario, correo, contraseña);

            return RedirectToAction("Login");
            // var result =  dt.Nombre_SP();
            //if(result.target == "0")
            //{
            //    ViewBag.message = result.msg;
            //}
            //throw new NotImplementedException();
        }

        public ActionResult Carrito()
        {
            return View();
        }

        public ActionResult Nosotros()
        {
            return View();
        }

        public ActionResult RegistroTarjeta()
        {
            return View();
        }

        public ActionResult VistaProducto(Producto producto, int? IdProducto)
        {
            ViewBag.Verproducto = VistaProductos(producto);
            return View();
        }

        public List<ShowProductsbyID_Result> VistaProductos(Producto producto)
        {
            Datos productos = new Datos();
            List<ShowProductsbyID_Result> result = new List<ShowProductsbyID_Result>();
            using (productos)
            {

                var verproducto = productos.ShowProductsbyID(producto.IdProducto).ToList();
                var asignar = new ShowProductsbyID_Result()
                {
                    IdProducto = verproducto[0].IdProducto,
                    Nombre = verproducto[0].Nombre,
                    Descripcion = verproducto[0].Descripcion,
                    Imagen = verproducto[0].Imagen,
                    precio = verproducto[0].precio,
                    Exis = verproducto[0].Exis,
                    Valoracion = verproducto[0].Valoracion,
                    Estado = verproducto[0].Estado,
                    Cat = verproducto[0].Cat,
                    IdCat = verproducto[0].IdCat,
                    Detalles = verproducto[0].Detalles
                };
                result.Add(asignar);
            }
            return result;
        }

        public ActionResult Compra()
        {
            return View();
        }

        public ActionResult Perfil()
        {
            return View();
        }

        public ActionResult Mantenimiento()
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