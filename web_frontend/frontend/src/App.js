import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Auth from "./routes/login_auth/auth.component";
import Info from "./routes/info/info.component";
import News from "./routes/news/news.component";

function App() {
  return (
    <div className="App">
      <Router>
        <Routes>
          <Route path="/" element={<Auth />} />

          <Route path="/info" element={<Info />} />
          <Route path="/news" element={<News />} />
        </Routes>
      </Router>
    </div>
  );
}

export default App;
