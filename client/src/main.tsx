import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";

import overrides from "./theme";

import { ChakraProvider } from "@chakra-ui/react";
import { Auth0Provider } from "@auth0/auth0-react";

ReactDOM.createRoot(document.getElementById("root") as HTMLElement).render(
  <Auth0Provider
    domain="dev-jy4007c0.us.auth0.com"
    clientId="25eX7KWNIzOL6sh1JVcDMVvRIVBtvTPG"
    redirectUri={window.location.origin}
    audience="https://dev-jy4007c0.us.auth0.com/api/v2/"
    scope="read:current_user update:current_user_metadata"
  >
    <ChakraProvider theme={overrides}>
      <React.StrictMode>
        <App />
      </React.StrictMode>
    </ChakraProvider>
  </Auth0Provider>
);
