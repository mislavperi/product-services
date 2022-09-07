import React, { useState, useEffect } from "react";

import {
  Flex,
  Link,
  Text,
  Box,
  Image,
  Modal,
  Button,
  ModalOverlay,
  ModalContent,
  ModalHeader,
  ModalFooter,
  ModalBody,
  ModalCloseButton,
  useDisclosure,
} from "@chakra-ui/react";
import { VscAccount, VscError } from "react-icons/vsc";
import { AiOutlineShoppingCart, AiOutlineClose } from "react-icons/ai";
import { useAuth0 } from "@auth0/auth0-react";
import { useNavigate } from "react-router-dom";

interface Products {
  title: string;
  image: string;
  description: string;
  price: number;
}

export default function Navigation(): JSX.Element {
  const {
    loginWithRedirect,
    user,
    isAuthenticated,
    logout,
    getAccessTokenSilently,
  } = useAuth0();
  const { isOpen, onOpen, onClose } = useDisclosure();
  const [cart, setCart] = useState<Products[]>([]);
  const navigate = useNavigate();

  useEffect(() => {
    const getUserMetadata = async () => {
      const domain = "dev-jy4007c0.us.auth0.com";

      try {
        const accessToken = await getAccessTokenSilently({
          audience: `https://${domain}/api/v2/`,
          scope: "read:current_user",
        });

        localStorage.setItem("access_token", accessToken);
        localStorage.setItem("sub", user?.sub);
        console.log(user?.sub);
      } catch (e) {
        console.log(e.message);
      }
    };

    getUserMetadata();
  }, [getAccessTokenSilently, user]);

  const triggerUpdates = () => {
    const items = localStorage.getItem("cart") || "";
    if (items != "") {
      const parsed = JSON.parse(items);
      setCart(parsed);
    }
    onOpen();
  };

  const concatValues = () => {
    return cart.reduce((p: any, curr: any) => {
      return p + curr.price;
    }, 0);
  };

  const removeItem = (title: string) => {
    const items = localStorage.getItem("cart") || "";
    if (items != "") {
      const parsed = JSON.parse(items);
      const filteredItems = parsed.filter((item: any) => item.title !== title);
      localStorage.setItem("cart", JSON.stringify(filteredItems));
      setCart(filteredItems);
    }
  };

  return (
    <Flex
      minHeight="40px"
      borderBottom="1px solid black"
      align="center"
      height="40px"
    >
      <Flex width="80%" height="100%" align="center" ml="10px">
        <Link href="/" m="4">
          Home
        </Link>
        <Link href="/products" m="4">
          Products
        </Link>
      </Flex>
      <Flex
        align="center"
        justify="flex-end"
        width="20%"
        height="100%"
        mr="20px"
      >
        {isAuthenticated ? (
          <Flex>
            <Flex>
              <Text>{user?.name}</Text>
              <Image
                src={user?.picture}
                alt={user?.name}
                boxSize="24px"
                borderRadius="50%"
                ml="5px"
                mr="5px"
              />
              <VscError
                style={{
                  cursor: "pointer",
                  marginRight: "5px",
                }}
                size={24}
                onClick={() => logout({ returnTo: window.location.origin })}
              />
            </Flex>
            <AiOutlineShoppingCart
              style={{
                cursor: "pointer",
              }}
              size={24}
              onClick={triggerUpdates}
            />
            <Modal isOpen={isOpen} onClose={onClose}>
              <ModalOverlay />
              <ModalContent>
                <ModalHeader>Shopping cart</ModalHeader>
                <ModalCloseButton />
                <ModalBody>
                  {cart.length === 0 ? (
                    <Text>Cart is empty</Text>
                  ) : (
                    cart.map((item: any) => {
                      return (
                        <Flex
                          border="1px solid grey"
                          align="center"
                          m="10px"
                          borderRadius="md"
                        >
                          <Image
                            src={item.image}
                            fallbackSrc="https://cdn.dribbble.com/users/27766/screenshots/3488007/media/ac55b16291e99eb1740c17b4ac793454.png"
                            boxSize="110px"
                            borderRadius="md"
                            m="20px"
                          />
                          <Box>
                            <Text fontSize="22px">{item.title}</Text>
                            <Text fontSize={14}>{item.description}</Text>
                            <Text>{item.price} €</Text>
                          </Box>
                          <AiOutlineClose
                            size={18}
                            style={{
                              marginLeft: "auto",
                              marginRight: "30px",
                              cursor: "pointer",
                            }}
                            onClick={() => removeItem(item?.title)}
                          />
                        </Flex>
                      );
                    })
                  )}
                </ModalBody>

                <ModalFooter>
                  <Text mr="auto" ml="20px" fontWeight="bold" mb="10px">
                    Total: {concatValues()}€
                  </Text>
                  <Button
                    colorScheme="blue"
                    mr={3}
                    onClick={() => navigate("/checkout")}
                  >
                    Checkout
                  </Button>
                </ModalFooter>
              </ModalContent>
            </Modal>
          </Flex>
        ) : (
          <Flex>
            <Flex
              _hover={{
                cursor: "pointer",
                color: "red",
              }}
              onClick={() => {
                loginWithRedirect();
              }}
            >
              <Text mr="10px">Login</Text>
              <VscAccount size={24} />
            </Flex>
          </Flex>
        )}
      </Flex>
    </Flex>
  );
}
