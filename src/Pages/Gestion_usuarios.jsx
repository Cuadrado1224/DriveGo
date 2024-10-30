import React, { useEffect, useState } from "react";
import Modal_Ges from "../Pages_Admin/Registro_adm";
import "../Styles/Gestion_Usuario.css";

const Gestion_usuarios = () => {
  const [showModal, setShowModal] = useState(false);
  const handleSessionClick = () => {
    setShowModal(true);
  };

  const closeModal = () => {
    setShowModal(false);
  };
  const [users, setUsers] = useState([]);
  useEffect(() => {
    fetch("http://localhost/Api-DriverGo/Ver_usuarios.php")
      .then((response) => response.json())
      .then((data) => {
        console.log(data.users);
        if (data.status) {
          setUsers(data.users);
        } else {
          console.error("Error: ", data.message);
        }
      })
      .catch((error) => console.error("Error fetching users:", error));
  }, []);
  return (
    <div className="card">
      <div className="card-header">
        <h2 className="card-tit">Gestión de Usuarios</h2>
        <button className="btn-nu" onClick={handleSessionClick}>
          <i className="fa-solid fa-plus"></i>Nuevo Usuario
        </button>
      </div>
      <div className="card-conte">
        <table className="table-cont">
          <thead>
            <tr>
              <th className="table-head">Nombre</th>
              <th className="table-head">Apellido</th>
              <th className="table-head">Correo</th>
              <th className="table-head">Cargo</th>
              <th className="table-head">Acciones</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user.id_usu}>
                <td className="table-cell">{user.nom_usu}</td>
                <td className="table-cell">{user.ape_usu}</td>
                <td className="table-cell">{user.corr_usu}</td>
                <td className="table-cell">{user.cargo}</td>
                <td className="table-cell">
                  <div className="btn-activs">
                    <button className="btn-acti">
                      <i className="fa-solid fa-pencil"></i>
                    </button>
                    <button className="btn-acti">
                      <i className="fa-solid fa-trash"></i>
                    </button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      {showModal && <Modal_Ges closeModal={closeModal} />}
    </div>
  );
};

export default Gestion_usuarios;
