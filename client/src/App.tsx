import { Navigation } from "./components";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import routes from "./configs/routes";
function App(): JSX.Element {
  return (
    <>
      <BrowserRouter>
        <Routes>
          {routes.map((route) => {
            return (
              <Route
                key={route.name}
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
