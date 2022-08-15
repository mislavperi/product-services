import { Home, Orders, Products } from "../components"

interface Routes {
  name: string;
  path: string;
  privateRoute: boolean;
  index: boolean
  element: any
}

const routes: Routes[] = [
  {
    name: "Home",
    path: "/",
    privateRoute: false,
    element: <Home />,
    index: true
  },
  {
    name: "Products",
    path: "/products",
    privateRoute: false,
    element: <Products />,
    index: false
  },
  {
    name: "Home",
    path: "/orders",
    privateRoute: true,
    element: <Orders />,
    index: false,
  },
];

export default routes;
