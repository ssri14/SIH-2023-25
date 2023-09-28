import { Link } from "react-router-dom";
import { useCookies } from "react-cookie";
import { useNavigate } from "react-router-dom";
import "./navbar.styles.scss";

const Navbar = () => {
  const [cookies, setCookies] = useCookies(["access_token"]);
  
  const navigate=useNavigate();

  const logout = () => {
    setCookies("access_token", "");
    window.localStorage.removeItem("userId");
    navigate("/");
  };
  return (
    <div className="nav">
      <Link to={"/get_info"} style={{ color: "white" }}>
        Info
      </Link>
      <Link to={"/get_news"} style={{ color: "white" }}>
        News
      </Link>
      {!cookies.access_token ? (
        <Link to={"/"} style={{ color: "white" }}>
          Login
        </Link>
      ) : (
        <div className="logout">

          <button onClick={logout} id="logout_btn" style={{color:"white",background:"transparent",border:"none",fontSize:"14px",cursor:"pointer"}}>
            Log Out
          </button>
        </div>
      )}
    </div>
  );
};

export default Navbar;
