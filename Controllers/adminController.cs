using BuyOnline.DTO;
using BuyOnline.Models;
using System;
using System.Collections.Generic;
using System.Linq;
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
                foreach (var item in listarpaises)
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

        [HttpPost]
        [Route("RegistrarPais")]
        public JsonResult RegistrarPais(string nombrepais)
        {
            GenericDTO response = new GenericDTO();

            try
            {
                conexion.InsertarPais(nombrepais);
                response.Status = 1;
                response.Message = "Pais registrado con éxito.";
                return Json(response);
            }
            catch
            {
                response.Status = 0;
                response.Message = "Un problema ha ocurrido...";
                return Json(response);
            }
        }

        public JsonResult PaisbyId(string id)
        {
            List<ListarPaisbyid_Result> ListaPais = new List<ListarPaisbyid_Result>();

            var idpais2 = Convert.ToInt32(id);

            using (conexion)
            {
                var PaisId = conexion.ListarPaisbyid(idpais2).ToList();

                var asiganr = new ListarPaisbyid_Result() //esto es un array
                {
                    IdPais = PaisId[0].IdPais,
                    NombrePais = PaisId[0].NombrePais
                };
                ListaPais.Add(asiganr);
            }
            return Json(ListaPais);
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

                foreach (var item in listarClientes)
                {
                    var asignar = new ShowCostumerXPersona_Result()
                    {
                        IdPersona = item.IdPersona,
                        Nombre = item.Nombre,
                        Apellido = item.Apellido,
                        Edad = item.Edad,
                        Telefono = item.Telefono,
                        IdPais = item.IdPais,
                        NombrePais = item.NombrePais,
                        IdEstado = item.IdEstado,
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

        [HttpPost]
        [Route("VerClienteID")]
        public JsonResult VerClienteID(int idpersona)
        {
            List<ShowCostumerXPersonabyId_Result> ClienteId = new List<ShowCostumerXPersonabyId_Result>();
            using (conexion)
            {
                var clienteID = conexion.ShowCostumerXPersonabyId(idpersona).ToList();

                var asignar = new ShowCostumerXPersonabyId_Result()
                {
                    IdPersona = clienteID[0].IdPersona,
                    Nombre = clienteID[0].Nombre,
                    Apellido = clienteID[0].Apellido,
                    Edad = clienteID[0].Edad,
                    Telefono = clienteID[0].Telefono,
                    IdPais = clienteID[0].IdPais,
                    NombrePais = clienteID[0].NombrePais,
                    IdEstado = clienteID[0].IdEstado,
                    Estado = clienteID[0].Estado,
                    IdCliente = clienteID[0].IdCliente,
                    Usuario = clienteID[0].Usuario,
                    Correo = clienteID[0].Correo,
                    Contraseña = clienteID[0].Contraseña
                };
                ClienteId.Add(asignar);
            }
            return Json(ClienteId);
        }

        [HttpPost]
        [Route("BuscarCliente")]
        public JsonResult BuscarCliente(string dat)
        {
            List<SearchCustumer_Result> busqueda = new List<SearchCustumer_Result>();

            using(conexion)
            {
                var bsuquedacliente = conexion.SearchCustumer(dat);

                foreach(var item in bsuquedacliente)
                {
                    var asignar = new SearchCustumer_Result()
                    {
                        IdPersona = item.IdPersona,
                        Nombre = item.Nombre,
                        Apellido = item.Apellido,
                        Edad = item.Edad,
                        Telefono = item.Telefono,
                        IdPais = item.IdPais,
                        NombrePais = item.NombrePais,
                        IdEstado = item.IdEstado,
                        Estado = item.Estado,
                        IdCliente = item.IdCliente,
                        Usuario = item.Usuario,
                        Correo = item.Correo,
                        Contraseña = item.Contraseña
                    };
                    busqueda.Add(asignar);
                }
            }
            return Json(busqueda);
        }

        [HttpPost]
        [Route("RegistrarClientes")]
        public JsonResult RegistrarClientes(string nombre, string apellido, string edad, string numero, string idpais, string usuario, string correo, string contraseña)
        {
            GenericDTO response = new GenericDTO();

            try
            {
                var idpais1 = Convert.ToInt32(idpais);
                var edad1 = Convert.ToInt32(edad);
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

        [HttpPost]
        [Route("EditarCliente")]
        public JsonResult EditarCliente(string idpersona, string nombre, string apellido, string edad, string numero, string idpais, string usuario, string correo, string contraseña)
        {
            GenericDTO response = new GenericDTO();
            try
            {
                var idpersona2 = Convert.ToInt32(idpersona);
                var idpais2 = Convert.ToInt32(idpais);
                var edad2 = Convert.ToInt32(edad);

                conexion.UpdatePersonaXCustumer(idpersona2, nombre, apellido, edad2, numero, idpais2, usuario, correo, contraseña);

                response.Message = "Usuario editado.";
                response.Status = 1;
                return Json(response);
            }
            catch (Exception e)
            {
                response.Message = "Un error ha ocurrido " + e;
                response.Status = 0;
                return Json(response);
            }
        }

        [HttpPost]
        [Route("ActiDesac")]
        public JsonResult ActiDesac(string idcliente, string idestado)
        {
            GenericDTO response = new GenericDTO();
            try
            {
                var idcliente2 = Convert.ToInt32(idcliente);
                var idestado2 = Convert.ToInt32(idestado);

                conexion.DisablePersonaXCustumer(idcliente2, idestado2);
                if (idestado == "1")
                {
                    response.Message = "Usuario Desactivado.";
                    response.Status = 1;
                }
                else if (idestado == "2")
                {
                    response.Message = "Usuario Activado";
                    response.Status = 1;
                }
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