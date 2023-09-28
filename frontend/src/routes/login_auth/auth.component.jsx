import "./auth.styles.scss";
import { useState } from "react";
import axios from "axios";
import { useCookies } from "react-cookie";
import { useNavigate } from "react-router-dom";

const Auth = () => {
  return (
    <div className="auth">
      <img
        src="imgs/10093790_39250 1.png"
        alt="imagelogin"
        id="login_img"
        style={{ width: "673.5px", height: "600.5px",paddingTop:"70px",marginRight:"20px"}}
      ></img>
      <div className="loginInfo">
        <div className="texts">
          <img src="imgs/Group 175.png" alt="text" style={{paddingLeft:"80px",paddingTop:"60px"}}></img>

        </div>
        <Login  />
      </div>
    </div>
  );
};

const Login = () => {
  const [adminUsername, setUsername] = useState("");
  const [adminPassword, setPassword] = useState("");

  const [, setCookies] = useCookies(["access_token"]);

  const navigate = useNavigate();

  const onSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await axios.post(
        "https://jade-mushy-lion.cyclic.cloud/user/loginAdmin",
        {
          adminUsername,
          adminPassword,
        },
        {
          timeout: 5000,
        }
      );

      setCookies("access_token", response.data.token);
      window.localStorage.setItem("username", response.data.Username);
      window.localStorage.setItem("isAdmin", response.data.isAdmin);
      window.localStorage.setItem("district", response.data.District);
      navigate("/get_info");
      setUsername("");
      setPassword("");
      console.log(response);
    } catch (error) {
      console.error(error);
    }
  };
  return (
    <Form
      username={adminUsername}
      setUsername={setUsername}
      password={adminPassword}
      setPassword={setPassword}
      label="Login"
      onSubmit={onSubmit}
      id_u="login-username"
      id_p="login-password"
    />
  );
};

const Form = ({
  username,
  setUsername,
  password,
  setPassword,
  label,
  onSubmit,
  id_u,
  id_p,
}) => {
  return (
    <div className="auth-container">
      <form onSubmit={onSubmit}>
        
        <div className="form-group">
          <label htmlFor="username">Username</label>
          <input
            type="text"
            id={id_u}
            value={username}
            onChange={(event) => {
              setUsername(event.target.value);
            }}
          />
        </div>

        <div className="form-group">
          <label htmlFor="password">Password</label>
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
          {label}
        </button>
      </form>
    </div>
  );
};

export default Auth;
