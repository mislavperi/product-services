import { Navigation } from "./components";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import routes from "./configs/routes";
function App(): JSX.Element {
  return (
    <>
      <Navigation />
      <BrowserRouter>
        <Routes>
          {routes.map((route) => {
            return (
              <Route
                index={route.index}
                path={route.path}
                element={route.element}
              />
            );
          })}
        </Routes>
      </BrowserRouter>
    </>
  );
}

export default App;
