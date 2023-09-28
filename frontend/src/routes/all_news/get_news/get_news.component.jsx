import { useState, useEffect } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import Auth from "../../login_auth/auth.component";
import CheckIcon from "@material-ui/icons/Check";
import Navbar from "../../navbar/navbar.component";
import "./get_news.styles.scss";

const GetNews = () => {
  const navigate = useNavigate();
  const onclick = () => {
    navigate("/news");
  };

  const isAdmin = localStorage.getItem("isAdmin");
  return (
    <div className="getting_news">
      {isAdmin ? (
        <div className="newsGet">
          <div className="imgsnav">
            <div className="navs">
              <a href="/">
                <img src="/imgs/Group 173.png" alt="logo" id="logo"></img>
              </a>
              <Navbar />
            </div>

            <img src="/imgs/emergency asset 1.png" alt="emergency"></img>
          </div>
          <div className="news">
            <p id="heading">News</p>
            <Getnewsdata />
            <button id="addnews" onClick={onclick}>
              Add News
            </button>
          </div>
        </div>
      ) : (
        <Auth />
      )}
    </div>
  );
};

const Getnewsdata = () => {
  const [getnews, setGetNews] = useState([]);

  const handleApproveClick = async (articleId) => {
    try {
      await axios.get(
        `https:/jade-mushy-lion.cyclic.cloud/news/approval/${articleId}`
      );
    } catch (error) {
      console.error("Error:", error);
    }
    fetchNews();
  };

  const fetchNews = async () => {
    try {
      const district = localStorage.getItem("district");
      const response = await axios.get(
        `https://jade-mushy-lion.cyclic.cloud/news/${district}`
      );
      setGetNews(response.data);
      console.log(response.data);
    } catch (error) {
      console.error(error);
    }
  };
  useEffect(() => {
    fetchNews();
  }, []);
  return (
    <div className="all_news">
      {getnews.news && getnews.news.length > 0 ? (
        <div className="card-containers">
          {getnews.news.map((article) => (
            <div className="articles">
              <div className="card">
                <h2 style={{ fontSize: "medium" }}>Type: {article.type}</h2>
                <p style={{ fontSize: "small" }}>News: {article.news}</p>
                <p style={{ fontSize: "small" }}>
                  Location: {article.location}
                </p>
                <p style={{ fontSize: "small" }}>
                  Status: {article.isApproved}
                </p>
                <div className="timeNbtn">
                  <p style={{ fontSize: "small" }}>Time: {article.time}</p>
                  <button
                    id="tick"
                    onClick={() => handleApproveClick(article._id)}
                  >
                    <CheckIcon />
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      ) : (
        <p className="no-data-message">No news available.</p>
      )}
    </div>
  );
};

export default GetNews;
