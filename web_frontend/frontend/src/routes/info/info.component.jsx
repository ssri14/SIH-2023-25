import Auth from "../login_auth/auth.component";
import { useState } from "react";
import axios from "axios";

const Info = () => {
  const isAdmin = localStorage.getItem("isAdmin");
  return (
    <div className="info">
      {isAdmin ? (
        <div className="components">
          <AddSubordData />
          <GetSubordData />
        </div>
      ) : (
        <Auth />
      )}
    </div>
  );
};

const AddSubordData = () => {
  const [name, setName] = useState("");
  const [phonenum, setPhonenum] = useState("");
  const [department, setDept] = useState("");
  const [district, setDistrict] = useState("");
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [depHead, setDephead] = useState("");

  const onSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await axios.post(
        "https://jade-mushy-lion.cyclic.cloud/user/addSubordinate",
        {
          name,
          phonenum,
          department,
          district,
          username,
          password,
          depHead,
        }
      );

      if (response.data.status === 200) {
        setName("");
        setPhonenum("");
        setDept("");
        setDistrict("");
        setUsername("");
        setPassword("");
        setDephead("");
      }
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <Form
      name
      setName
      phonenum
      setPhonenum
      department
      setDept
      district
      setDistrict
      username
      setUsername
      password
      setPassword
      depHead
      setDephead
      label="Add Subordinate"
      onSubmit={onSubmit}
      id_name="subd-name"
      id_num="subd-no"
      id_dept="subd-dept"
      id_dis="subd-dis"
      id_u_name="subd-username"
      id_p="subd-pass"
      id_dh="subd-dh"
    />
  );
};

const GetSubordData = () => {
  
  return (
    <div className="getsuborddata">
      
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
  depHead,
  setDephead,
  label,
  onSubmit,
  id_name,
  id_num,
  id_dept,
  id_dis,
  id_u_name,
  id_p,
  id_dh,
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
        <div className="form-group">
          <label htmlFor="depthead">DeptHead:</label>
          <input
            type="text"
            id={id_dh}
            value={depHead}
            onChange={(event) => {
              setDephead(event.target.value);
            }}
          />
        </div>
        <button type="submit" id="button">
          {label}
        </button>
      </form>
    </div>
  );
};

export default Info;
