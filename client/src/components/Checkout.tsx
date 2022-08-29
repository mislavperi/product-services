import React, { useState, useEffect } from "react";
import { useAuth0 } from "@auth0/auth0-react";
import { Flex, Image, Box, Text, Button, Heading } from "@chakra-ui/react";

interface Item {
  price: string;
}

export default function Checkout() {
  const [items, setItems] = useState([]);
  const { loginWithRedirect, isAuthenticated } = useAuth0();

  useEffect(() => {
    const cartItems = localStorage.getItem("cart") || "";
    if (cartItems !== "") {
      const parsed = JSON.parse(cartItems);
      setItems(parsed);
    }
  }, []);

  const concatValues = () => {
    return items.reduce((p: any, curr: any) => {
      const num = parseInt(curr.price.split("€")[0]);
      return p + num;
    }, 0);
  };

  return isAuthenticated ? (
    <Flex align="center" flexDirection="column">
      <Heading m="20px">Generic store name.com</Heading>
      <Flex
        flexDir="column"
        align="center"
        border="1px solid grey"
        p="20px"
        width="fit-content"
      >
        {items.map((item: any) => {
          return (
            <Flex
              p="5px"
              align="center"
              m="5px"
              border="1px solid grey"
              borderRadius="md"
              width="fit-content"
            >
              <Image
                src={item?.image}
                fallbackSrc="https://cdn.dribbble.com/users/27766/screenshots/3488007/media/ac55b16291e99eb1740c17b4ac793454.png"
                boxSize="150px"
                padding="10px"
                borderRadius="md"
              />
              <Box>
                <Text fontSize="22px">{item?.title}</Text>
                <Text>{item?.price}</Text>
              </Box>
              <Button ml="50px" mr="5px">
                Remove item
              </Button>
            </Flex>
          );
        })}
        <Flex mt="15px">
          <Text fontWeight="bold" mt="10px" mr="45px">
            Total: {concatValues()} €
          </Text>
          <Button>Checkout</Button>
        </Flex>
      </Flex>
      <Button m="10px">Return to store</Button>
    </Flex>
  ) : (
    <Flex align="center" justify="center" flexDir="column">
      <Text>Please login first</Text>
      <Button onClick={() => loginWithRedirect()}>Login</Button>
    </Flex>
  );
}
