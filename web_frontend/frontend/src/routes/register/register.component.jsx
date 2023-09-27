import { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import Auth from "../login_auth/auth.component";

const Register=()=>{
    const id=localStorage.getItem("userId");
    return(
        <div className="reg_org">
           {id?(<RegisterOrg/>):(<Auth/>)}
        </div>
    )
}

const RegisterOrg = () => {
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [email,setEmail]=useState("");
    const navigate=useNavigate();
  
    const onSubmit = async (event) => {
      event.preventDefault();
      try {
        await axios.post("http://localhost:3000/auth/register", {
          username,
          email,
          password,
        });
        alert("Registration completed successfully. Now login");
        setUsername("");
        setPassword("");
        setEmail("");
        navigate("/info");
      } catch (error) {
        console.error(error);
      }
    };
    return (
      <Form
        username={username}
        setUsername={setUsername}
        email={email}
        setEmail={setEmail}
        password={password}
        setPassword={setPassword}
        label="Register"
        onSubmit={onSubmit}
        id_u="register-username"
        id_p="register-password"
        id_e="register-email"
      />
    );
  };

  const Form = ({
    username,
    setUsername,
    email,
    setEmail,
    password,
    setPassword,
    label,
    onSubmit,
    id_u,
    id_p,
    id_e
  }) => {
    return (
      <div className="auth-container">
        <form onSubmit={onSubmit}>
          <h2>{label}</h2>
          <div className="form-group">
            <label htmlFor="username">Organisation:</label>
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
            <label htmlFor="email">Email:</label>
            <input
              type="email"
              id={id_e}
              value={email}
              onChange={(event) => {
                setEmail(event.target.value);
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
          <button type="submit" id="button">{label}</button>
        </form>
      </div>
    );
  };

  export default Register;