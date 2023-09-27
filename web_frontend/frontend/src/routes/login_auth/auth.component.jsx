import "./auth.styles.scss";
import { useState } from "react";
import axios from "axios";
//import { useCookies } from "react-cookie";
import { useNavigate } from "react-router-dom";

const Auth = () => {
  return (
    <div className="auth">
      <Login />
    </div>
  );
};

const Login = () => {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  //const [, setCookies] = useCookies(["access_token"]);

  const navigate = useNavigate();

  const onSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await axios.post(
        "https://jade-mushy-lion.cyclic.cloud/user/login",
        {
          username,
          password,
        },{
          timeout: 5000, 
        }
      );

      //setCookies("access_token", response.data.token);
      window.localStorage.setItem("username", response.data.Name);
      window.localStorage.setItem("isAdmin", response.data.isAdmin);
      navigate("/info");
      setUsername("");
      setPassword("");
    } catch (error) {
      console.error(error);
    }
  };
  return (
    <Form
      username={username}
      setUsername={setUsername}
      password={password}
      setPassword={setPassword}
      label="Login"
      onSubmit={onSubmit}
      id_u="login-username"
      id_p="login-password"
      id_e="login-email"
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
        <h2>{label}</h2>
        <div className="form-group">
          <label htmlFor="username">Username:</label>
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
          {label}
        </button>
      </form>
    </div>
  );
};

export default Auth;
