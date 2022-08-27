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

        /*
        [HttpPost]
        [Route("inicioAdmin")]
        public JsonResult inicioAdmin(Administrador administradores)
        {
            GenericDTO response = new GenericDTO();

            try
            {
                List<LoginA_Result> LoginAdmin = conexion.LoginA(administradores.Usuario, administradores.Contraseña).ToList();

                if(LoginAdmin.Count > 0)
                {
                    if(LoginAdmin[0].IdEstado == 1)
                    {
                        response.Status = 1;
                        response.Message = "Bienvenido!";

                        Session["Status"] = "true";
                        Session["IdAdmin"] = LoginAdmin[0].IdAdmin;
                        Session["Usuario"] = LoginAdmin[0].Usuario;

                        return Json(response);
                    }
                    else
                    {
                        response.Status = 0;
                        response.Message = "El Administrador está desactivado.";

                        Session["Status"] = "False";
                        Session["IdAdmin"] = "";
                        Session["Usuario"] = "";

                        return Json(response);
                    }
                    
                }
                else
                {
                    response.Status = 0;
                    response.Message = "El usuario o contraseña son invalidos.";

                    Session["Status"] = "False";
                    Session["IdAdmin"] = "";
                    Session["Usuario"] = "";

                    return Json(response);
                }

            }
            catch(Exception ex)
            {
                response.Status = 0;
                response.Message = "Error "+ ex;
                return Json(response);
            }
        }*/

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

        public JsonResult PaisbyId(string id) //this controller will show you on a Modal the country's name
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

        [HttpPost]
        [Route("EditarPais")]
        public JsonResult EditarPais(string idpais, string nombrepais) //this controller will edit the country
        {
            GenericDTO response = new GenericDTO();

            try
            {
                var idpais2 = Convert.ToInt32(idpais);
                conexion.ActualizarPais(nombrepais, idpais2);
                response.Status = 1;
                response.Message = "País editado con éxito.";
                return Json(response);
            }
            catch
            {
                response.Status = 0;
                response.Message = "Un error ha ocurrido";
                return Json(response);
            }
        }

        [HttpPost]
        [Route("EliminarPais")]
        public JsonResult EliminarPais(string idpais)
        {
            GenericDTO response = new GenericDTO();

            try
            {
                var idpais2 = Convert.ToInt32(idpais);

                conexion.EliminarPais(idpais2);
                response.Status = 1;
                response.Message = "País Eliminado con éxito, recuerda esta acción es irreversible...";
                return Json(response);
            }
            catch
            {
                response.Status = 0;
                response.Message = "Un error ha ocurrido...";
                return Json(response);
            }
        }

        [HttpPost]
        [Route("BuscarPais")]
        public JsonResult BuscarPais(string pais)
        {
            List<BuscarPais_Result> BuscarPais = new List<BuscarPais_Result>();

            using (conexion)
            {
                var paises = conexion.BuscarPais(pais);

                foreach (var item in paises)
                {
                    var asignar = new BuscarPais_Result()
                    {
                        IdPais = item.IdPais,
                        NombrePais = item.NombrePais
                    };
                    BuscarPais.Add(asignar);
                }
            }
            return Json(BuscarPais);
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

            using (conexion)
            {
                var bsuquedacliente = conexion.SearchCustumer(dat);

                foreach (var item in bsuquedacliente)
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

        [HttpPost]
        [Route("ListarPCategorias")]
        public JsonResult ListarPCategorias()
        {
            List<LeerCat_Result> Categorias = new List<LeerCat_Result>();

            using (conexion)
            {
                var listarCate = conexion.LeerCat();

                foreach (var item in listarCate)
                {
                    var asignar = new LeerCat_Result()
                    {
                        IdCat = item.IdCat,
                        Cat = item.Cat
                    };
                    Categorias.Add(asignar);
                }
            }
            return Json(Categorias);
        }

        [HttpPost]
        [Route("ListarCatbyId")]
        public JsonResult ListarCatbyId(string idcat)
        {
            var IdCat = Convert.ToInt32(idcat);

            List<listarCatbyid_Result> ListarCat = new List<listarCatbyid_Result>();

            using (conexion)
            {
                var CatId = conexion.listarCatbyid(IdCat).ToList();

                var asignar = new listarCatbyid_Result()
                {
                    IdCat = CatId[0].IdCat,
                    Cat = CatId[0].Cat
                };
                ListarCat.Add(asignar);
            }
            return Json(ListarCat);
        }

        [HttpPost]
        [Route("InsertarCategoria")]
        public JsonResult InsertarCategoria(string nombreCat)
        {
            GenericDTO response = new GenericDTO();

            try
            {
                conexion.AgregarCat(nombreCat);
                response.Status = 1;
                response.Message = "Categoría registrada con éxito.";
                return Json(response);
            }
            catch (Exception ex)
            {
                response.Status = 0;
                response.Message = "Un error ha ocurrido " + ex;
                return Json(response);
            }
        }

        [HttpPost]
        [Route("EditarCategoria")]
        public JsonResult EditarCategoria(string idcat, string cat)
        {
            GenericDTO response = new GenericDTO();

            try
            {
                var idcat2 = Convert.ToInt32(idcat);
                conexion.ActualizarCat(cat, idcat2);
                response.Status = 1;
                response.Message = "Categoria editada con éxito.";
                return Json(response);
            } catch (Exception error)
            {
                response.Status = 0;
                response.Message = "Un error ha ocurrido " + error;
                return Json(response);
            }
        }

        [HttpPost]
        [Route("EliminarCategoria")]
        public JsonResult EliminarCategoria(int idcat)
        {
            GenericDTO response = new GenericDTO();

            try
            {
                conexion.EliminarCat(idcat);
                response.Status = 1;
                response.Message = "Categoría eliminada, esta acción es irreversible....";
                return Json(response);
            }
            catch (Exception ex)
            {
                response.Status = 0;
                response.Message = "Un error ha ocurrido " + ex;
                return Json(response);
            }
        }
        
        [HttpPost]
        [Route("BuscarCategoria")]
        public JsonResult BuscarCategoria(string cat)
        {
            List<BuscarCat_Result> BuscarCategoria = new List<BuscarCat_Result>();

            using (conexion)
            {
                var Bcat = conexion.BuscarCat(cat).ToList();

                foreach(var item in Bcat)
                {
                    var asignar = new BuscarCat_Result()
                    {
                        IdCat = item.IdCat,
                        Cat = item.Cat
                    };
                    BuscarCategoria.Add(asignar);
                }
            }
            return Json(BuscarCategoria);
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

        [HttpPost]
        [Route("ListarTipoPago")]
        public JsonResult ListarTipoPago()
        {
            List<ListarTPago_Result> TipoPago = new List<ListarTPago_Result>();

            using (conexion)
            {
                var listatp = conexion.ListarTPago();

                foreach(var item in listatp)
                {
                    var asignar = new ListarTPago_Result()
                    {
                        IdTipoP = item.IdTipoP,
                        TipoPago = item.TipoPago
                    };
                    TipoPago.Add(asignar);
                }
            }
            return Json(TipoPago);
        }

        [HttpPost]
        [Route("InsertarTipoPago")]
        public JsonResult InsertarTipoPago(string nombreTP)
        {
            GenericDTO response = new GenericDTO();

            try
            {
                if(nombreTP != "")
                {
                    conexion.InsertarTPago(nombreTP);
                    response.Status = 1;
                    response.Message = "Tipo de pago insertado con éxito";
                    return Json(response);
                }
                else
                {
                    response.Status = 0;
                    response.Message = "Por favor no deje en blanco el espacio...";
                    return Json(response);
                }
            }catch(Exception er)
            {
                response.Status = 0;
                response.Message = "Un error ha ocurrido " + er;
                return Json(response);
            }
        }

        [HttpPost]
        [Route("ListarTPbyId")]
        public JsonResult ListarTPbyId(int idtp)
        {
            List<ListarTPagobyId_Result> ListarTPId = new List<ListarTPagobyId_Result>();

            using (conexion)
            {
                var tpid = conexion.ListarTPagobyId(idtp).ToList();

                var asignar = new ListarTPagobyId_Result()
                {
                    IdTipoP = tpid[0].IdTipoP,
                    TipoPago = tpid[0].TipoPago
                };
                ListarTPId.Add(asignar);
            }
            return Json(ListarTPId);
        }


        [HttpPost]
        [Route("EditarTipoPago")]
        public JsonResult EditarTipoPago(string idtp, string nombretp)
        {
            GenericDTO response = new GenericDTO();
            try
            {
                var idtp2 = Convert.ToInt32(idtp);
                conexion.ActualizarTPago(idtp2, nombretp);
                response.Status = 1;
                response.Message = "Tipo Pago editado con éxito.";
                return Json(response);
            }catch(Exception ex)
            {
                response.Status = 0;
                response.Message = "Un error ha ocurrido " + ex;
                return Json(response);
            }
        }

        [HttpPost]
        [Route("EliminarTipoPago")]
        public JsonResult EliminarTipoPago(int idtp)
        {
            GenericDTO response = new GenericDTO();
            try
            {
                conexion.EliminarTPago(idtp);
                response.Status = 1;
                response.Message = "Tipo Pago eliminado, esta acción es irreversible...";
                return Json(response);
            } catch(Exception ex)
            {
                response.Status = 0;
                response.Message = "Un error ha ocurrido " +  ex;
                return Json(response);
            }
        }
    }
}