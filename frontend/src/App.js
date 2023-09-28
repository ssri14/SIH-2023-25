import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Auth from "./routes/login_auth/auth.component";
import Info from "./routes/all_info/info/info.component";
import News from "./routes/all_news/news/news.component";

import GetInfo from "./routes/all_info/get_info/get_info.component";
import GetNews from "./routes/all_news/get_news/get_news.component";

function App() {
  return (
    <div className="App">
      <Router>
        <Routes>
          <Route path="/" element={<Auth />} />
          <Route path="/info" element={<Info />} />
          <Route path="/news" element={<News />} />
          <Route path="/get_info" element={<GetInfo />} />
          <Route path="/get_news" element={<GetNews />} />
        </Routes>
      </Router>
    </div>
  );
}

export default App;
