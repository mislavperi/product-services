import React, { useState, useEffect } from "react";

import { Flex, Text, Heading } from "@chakra-ui/react";
import Highlight from "./Highlight";

export default function Home(): JSX.Element {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    fetch("/api/v1/highlight", {
      headers: {
        apikey: "7B5zIqmRGXmrJTFmKa99vcit",
        authorization: localStorage.getItem("access_token"),
        sub: localStorage.getItem("sub")
      },
    })
      .then((res) => res.json())
      .then((res) => {
        if (res.data === undefined) {
          setProducts([]);
        } else {
          setProducts(res.data);
        }
      });
  }, []);

  return (
    <Flex flexDir="column" align="center">
      <Text fontSize="36px">Product page </Text>
      {products.length === 0 ? (
        <Text> No highlighted products were found</Text>
      ) : (
        <Highlight data={products} />
      )}
    </Flex>
  );
}
