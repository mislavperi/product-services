import { Checkout, Home, Products, Navigation } from "../components";

interface Routes {
  name: string;
  path: string;
  privateRoute: boolean;
  index: boolean;
  element: any;
}

const routes: Routes[] = [
  {
    name: "Home",
    path: "/",
    privateRoute: false,
    element: (
      <>
        <Navigation />
        <Home />
      </>
    ),
    index: true,
  },
  {
    name: "Products",
    path: "/products",
    privateRoute: false,
    element: (
      <>
        <Navigation />
        <Products />
      </>
    ),
    index: false,
  },
  {
    name: "Checkout",
    path: "/checkout",
    privateRoute: true,
    element: <Checkout />,
    index: false,
  },
];

export default routes;
