import { useState } from "react";
import axios from "axios";
import Auth from "../../login_auth/auth.component";
import { useNavigate } from "react-router-dom";
import "./news.styles.scss";

const News = () => {
  const isAdmin = localStorage.getItem("isAdmin");

  return (
    <div className="news">
      {isAdmin ? (
        <div className="navNnews">
          <div className="logoNimg">
            <a href="/">
              <img src="/imgs/Group 173.png" alt="logo" id="logo"></img>
            </a>
            <img
              src="imgs/emergency asset 1.png"
              alt="emergency"
              id="emergency"
            ></img>
          </div>
          <AddNews />
        </div>
      ) : (
        <Auth />
      )}
    </div>
  );
};

const AddNews = () => {
  const [news, setNews] = useState("");
  const [type, setType] = useState("");
  const [location, setLocation] = useState("");
  const navigate = useNavigate();
  const time = new Date().toLocaleTimeString();
  const isApproved = "True";

  const onSubmit = async (event) => {
    event.preventDefault();
    try {
      const response = await axios.post(
        "https://jade-mushy-lion.cyclic.cloud/news/postNews",
        {
          news,
          type,
          location,
          time,
          isApproved,
        }
      );

      if (response.status === 200) {
        navigate("/get_news");
      }
    } catch (error) {
      console.error(error);
    }
  };
  return (
    <div className="addnews">
      <Form
        news={news}
        setNews={setNews}
        type={type}
        setType={setType}
        location={location}
        setLocation={setLocation}
        label="Add news"
        onSubmit={onSubmit}
        id_n="news"
        id_t="type"
        id_l="loc"
      />
    </div>
  );
};

const Form = ({
  news,
  setNews,
  type,
  setType,
  location,
  setLocation,
  label,
  onSubmit,
  id_n,
  id_t,
  id_l,
}) => {
  return (
    <div className="news-container">
      <form onSubmit={onSubmit}>
        <h2>{label}</h2>
        <div className="form-group">
          <label htmlFor="news">News:</label>
          <input
            type="text"
            id={id_n}
            value={news}
            onChange={(event) => {
              setNews(event.target.value);
            }}
          />
        </div>

        <div className="form-group">
          <label htmlFor="type">Type:</label>
          <input
            type="text"
            id={id_t}
            value={type}
            onChange={(event) => {
              setType(event.target.value);
            }}
          />
        </div>
        <div className="form-group">
          <label htmlFor="location">Location:</label>
          <input
            type="text"
            id={id_l}
            value={location}
            onChange={(event) => {
              setLocation(event.target.value);
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
export default News;
