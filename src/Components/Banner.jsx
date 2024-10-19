import React from 'react'
import logo from "/Public/image.png";
import  "../Estilos/Banner.css";
const Banner = () => {
  return (
    <div className="banner-conten">
    <div className="banner-img">
      <img src={logo} alt="" />
    </div>
    <div className="bannerText">
      <h1>MANEJA EL AUTO DE TUS SUEÑOS</h1>
      <p>ACERCATE A LA AGENCIA MAS CERCANA O REGISTRATE PARA ENTERARTE DE NUESTRAS MEJORES OFERTAS.</p>
      <a href="/" className="btn-1">
        MAS INFORMACIÓN
      </a>
    </div>
  </div>

  )
}

export default Banner