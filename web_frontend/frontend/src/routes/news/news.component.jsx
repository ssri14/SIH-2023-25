import { useState, useEffect } from "react";
import axios from "axios";
import Auth from "../login_auth/auth.component";

const News = () => {
  const isAdmin = localStorage.getItem("isAdmin");
  return (
    <div className="news">
      {isAdmin ? (
        <div className="newsinfo">
          <AddNews /> <GetNews />
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
  const time = new Date().toLocaleTimeString([], {
    hour: "2-digit",
    minute: "2-digit",
  });

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
        }
      );

      if (response.data.status === 200) {
        setNews("");
        setType("");
        setLocation("");
      }
    } catch (error) {
      console.error(error);
    }
  };
  return (
    <div className="addnews">
      <Form
        news
        setNews
        type
        setType
        location
        setLocation
        label="Add news"
        onSubmit={onSubmit}
        id_n="news"
        id_t="type"
        id_l="loc"
      />
    </div>
  );
};

const GetNews = async () => {
  useEffect(() => {
    fetchNews();
  }, []);
  const [getnews, setGetNews] = useState([]);

  const fetchNews = async () => {
    try {
      const response = await axios.get(
        "https://jade-mushy-lion.cyclic.cloud/news/"
      );
      setGetNews(response.data);
    } catch (error) {
      console.error(error);
    }
  };
  return (
    <div className="all_news">
      {getnews && getnews.length > 0 ? (
        <ul>
          {getnews.map((article) => (
            <li key={article._id}>
              <h2>{article.type}</h2>
              <p>{article.news}</p>
              <p>{article.location}</p>
              <p>{article.time}</p>
            </li>
          ))}
        </ul>
      ) : (
        <p className="no-data-message">No news available.</p>
      )}
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
