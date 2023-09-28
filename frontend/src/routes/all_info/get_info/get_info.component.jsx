import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import Auth from "../../login_auth/auth.component";
import Navbar from "../../navbar/navbar.component";
import "./get_info.styles.scss";
import axios from "axios";

const GetInfo = () => {
  const navigate = useNavigate();
  const toggleAddNews = () => {
    navigate("/info");
  };
  const isAdmin = localStorage.getItem("isAdmin");
  return (
    <div className="get_info">
      {isAdmin ? (
        <div className="infoGet">
          <div className="imgsnav">
            <div className="navs">
            <a href="/"><img src="/imgs/Group 173.png" alt="logo" id="logo"></img></a>
              <Navbar />
            </div>

            <img src="/imgs/emergency asset 1.png" alt="emergency"></img>
          </div>
          <div className="infos">
            <p id="heading">Subordinate Info.</p>
            <GetSubordData />
            <button onClick={toggleAddNews}>Add Subordinate</button>
          </div>
        </div>
      ) : (
        <Auth />
      )}
    </div>
  );
};

const GetSubordData = () => {
  useEffect(() => {
    fetchSubordData();
  }, []);

  const [getSubordData, setSubordData] = useState([]);
  const fetchSubordData = async () => {
    try {
      const adminUsername = localStorage.getItem("username");
      const response = await axios.get(
        `https://jade-mushy-lion.cyclic.cloud/user/${adminUsername}`
      );
      setSubordData(response.data);
    } catch (error) {
      console.error(error);
    }
  };
  setTimeout(() => {
    
  }, 1000);
  return (
    <div className="getsuborddata">
      {getSubordData.allSubordinates &&
      getSubordData.allSubordinates.length > 0 ? (
        <div className="cards-container">
          {getSubordData.allSubordinates.map((sub) => (
            <div className="subs">
              <div className="card">
                <h2 style={{fontSize:"medium"}}>Name: {sub.name}</h2>
                <p style={{fontSize:"small"}}>Ph.No: {sub.phoneNo}</p>
                <p style={{fontSize:"small"}}>Department: {sub.department}</p>
                <p style={{fontSize:"small"}}>District: {sub.district}</p>
              </div>
            </div>
          ))}
        </div>
      ) : (
        <p className="no-data-message">No Subordinate available.</p>
      )}
    </div>
  );
};

export default GetInfo;
