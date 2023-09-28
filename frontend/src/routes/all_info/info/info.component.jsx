import { useState } from "react";
import Auth from "../../login_auth/auth.component";

import axios from "axios";
import { useNavigate } from "react-router-dom";
import "./info.styles.scss"

const Info = () => {
  const isAdmin = localStorage.getItem("isAdmin");
  

  return (
    <div className="info">
      {isAdmin ? (
        <div className="components">
          <div className="logoNimg">
             <a href="/"><img src="/imgs/Group 173.png" alt="logo" id="logo"></img></a>
             <img src="imgs/emergency asset 1.png" alt="emergency" id="emergency"></img>
          </div>
          <AddSubordData />
        </div>
      ) : (
        <Auth />
      )}
    </div>
  );
};

const AddSubordData = () => {
  const [name, setName] = useState("");
  const [phoneNo, setPhonenum] = useState("");
  const [department, setDept] = useState("");
  const [district, setDistrict] = useState("");
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  
  const navigate=useNavigate();
  
  const adminUsername = localStorage.getItem("username");
  const onSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await axios.post(
        `https://jade-mushy-lion.cyclic.cloud/user/addSubordinate`,
        {
          name,
          phoneNo,
          department,
          district,
          username,
          password,
          adminUsername,
        },
        {
          timeout: 5000,
        }
      );
      
      if (response.status === 200) {
        
        navigate("/get_info");
      }
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <div className="addsubOrd">
      
        <Form
          name={name}
          setName={setName}
          phonenum={phoneNo}
          setPhonenum={setPhonenum}
          department={department}
          setDept={setDept}
          district={district}
          setDistrict={setDistrict}
          username={username}
          setUsername={setUsername}
          password={password}
          setPassword={setPassword}
          label="Add Subordinate"
          onSubmit={onSubmit}
          id_name="subd-name"
          id_num="subd-no"
          id_dept="subd-dept"
          id_dis="subd-dis"
          id_u_name="subd-username"
          id_p="subd-pass"
        />
      
    </div>
  );
};

const Form = ({
  name,
  setName,
  phonenum,
  setPhonenum,
  department,
  setDept,
  district,
  setDistrict,
  username,
  setUsername,
  password,
  setPassword,

  label,
  onSubmit,
  id_name,
  id_num,
  id_dept,
  id_dis,
  id_u_name,
  id_p,
}) => {
  return (
    <div className="info-container">
      <form onSubmit={onSubmit}>
        <h2>{label}</h2>
        <div className="form-group">
          <label htmlFor="name">Name:</label>
          <input
            type="text"
            id={id_name}
            value={name}
            onChange={(event) => {
              setName(event.target.value);
            }}
          />
        </div>
        <div className="form-group">
          <label htmlFor="phonenum">PhoneNo:</label>
          <input
            type="Number"
            id={id_num}
            value={phonenum}
            onChange={(event) => {
              setPhonenum(event.target.value);
            }}
          />
        </div>
        <div className="form-group">
          <label htmlFor="department">Department:</label>
          <input
            type="text"
            id={id_dept}
            value={department}
            onChange={(event) => {
              setDept(event.target.value);
            }}
          />
        </div>
        <div className="form-group">
          <label htmlFor="district">District:</label>
          <input
            type="text"
            id={id_dis}
            value={district}
            onChange={(event) => {
              setDistrict(event.target.value);
            }}
          />
        </div>
        <div className="form-group">
          <label htmlFor="username">Username:</label>
          <input
            type="text"
            id={id_u_name}
            value={username}
            onChange={(event) => {
              setUsername(event.target.value);
            }}
          />
        </div>

        <div className="form-group">
          <label htmlFor="password">Password:</label>
          <input
            type="password"
            id={id_p}
            value={password}
            onChange={(event) => {
              setPassword(event.target.value);
            }}
          />
        </div>

        <button type="submit" id="button">
          Add
        </button>
      </form>
    </div>
  );
};

export default Info;
