import React from 'react'
import logo from "/Public/Logo.jpg";
import "../Estilos/Footer.css"
const Footer = () => {
  return (
   <footer className='footer'>
    <a href="/" className="logo">
        <img src={logo} alt='logo de la empresa'/> 
      </a>
      <div className='ubicacion'>
       <a>
        Pagina web dedicada a la renta de carros 
       </a>
       <a>
        Ubicacion: Uta
       </a>
      </div>
      <div className="social-media"> 
        <a className='let'>
            Redes Sociales
        </a>
        <a
          href="https://facebook.com"
          target="_blank"
          rel="noopener noreferrer"
        >
          <i className="fa-brands fa-facebook"></i>
          Facebook
        </a>
        <a href="https://WhatsApp.com" target="_blank" rel="noopener noreferrer">
          <i className="fa-brands fa-whatsapp"></i>
          Whatsapp
        </a>
        <a
          href="https://instagram.com"
          target="_blank"
          rel="noopener noreferrer"
        >
          <i className="fa-brands fa-instagram"></i>
          Instagram
        </a>
      </div>
      <p className='derechos'>© 2024 DriveGo. All Rights Reserved.</p> 
   </footer>
    
  )
}

export default Footer