import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";

import overrides from "./theme";

import { ChakraProvider } from "@chakra-ui/react";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <ChakraProvider theme={overrides}>
    <React.StrictMode>
      <App />
    </React.StrictMode>
  </ChakraProvider>
);
