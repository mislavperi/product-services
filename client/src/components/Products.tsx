import React, { useState, useEffect } from "react";

import {
  Flex,
  Text,
  Image,
  Button,
  Divider,
  Input,
  Box,
  useToast,
} from "@chakra-ui/react";

import { FcMinus } from "react-icons/fc";

interface Products {
  id: number;
  title: string;
  image: string;
  description: string;
  price: number;
}

export default function Products() {
  const toast = useToast();
  const [search, setSearch] = useState("");
  const [items, setItems] = useState<Products[]>([]);
  const [filteredItems, setFilteredItems] = useState<Products[]>([]);
  const [refresh, setRefresh] = useState<Boolean>(false);

  useEffect(() => {
    fetch("/api/products", {
      headers: {
        apikey: "7B5zIqmRGXmrJTFmKa99vcit",
      },
    })
      .then((res) => res.json())
      .then((res) => {
        setItems(res.data);
        setFilteredItems(res.data);
      });
  }, []);

  const filterItems = (value: string) => {
    setSearch(value);
    const filtered = items.filter((item) =>
      item.title.toLowerCase().includes(value)
    );
    setFilteredItems(filtered);
  };

  const checkIfItemExists = (title: string) => {
    const items = localStorage.getItem("cart") || "";
    if (items == "") {
      return false;
    }
    const parsedItems = JSON.parse(items);
    if (parsedItems.filter((item: any) => item.title === title).length > 0) {
      return true;
    }
    return false;
  };

  const addToCart = (title: string) => {
    let oldItems = localStorage.getItem("cart") || "";
    if (checkIfItemExists(title)) {
      return;
    }
    const newItem = items.filter((item) => item.title === title);
    if (oldItems !== "") {
      oldItems = JSON.parse(oldItems);
    }
    const joinedArray =
      oldItems !== "" ? [...oldItems, newItem[0]] : [newItem[0]];
    localStorage.setItem("cart", JSON.stringify(joinedArray));
    toast({
      title: "Added to cart",
      description: `${title} was added to cart`,
      status: "success",
      duration: 3000,
      isClosable: true,
    });
    setRefresh(!refresh);
  };

  const containsItem = (title: string) => {
    if (checkIfItemExists(title)) {
      return true;
    }
    return false;
  };

  const removeItem = (title: string) => {
    const items = localStorage.getItem("cart") || "";
    if (items != "") {
      const parsed = JSON.parse(items);
      const filteredItems = parsed.filter((item: any) => item.title !== title);
      localStorage.setItem("cart", JSON.stringify(filteredItems));
      toast({
        title: "Removed item from cart",
        description: `${title} was removed from cart`,
        status: "error",
        duration: 3000,
        isClosable: true,
      });
      setRefresh(!refresh);
    }
  };

  return (
    <Box>
      <Flex width="fit-content" align="center" ml="30px">
        <Text>Search for products</Text>
        <Input
          size="sm"
          value={search}
          onChange={(v) => filterItems(v.target.value)}
        />
      </Flex>
      <Flex align="center" justify="center">
        {filteredItems.length === 0 ? (
          <Flex flexDir="column" align="center">
            <Text fontSize={24}>No products are found at this moment</Text>
            <FcMinus size={48} />
          </Flex>
        ) : (
          filteredItems.map((item: any) => {
            return (
              <Flex
                key={item.title}
                borderRadius="md"
                flexDir="column"
                align="center"
                justify="center"
                m="5px"
                p="5px"
                shadow="md"
              >
                <Image
                  src={item.image}
                  fallbackSrc="https://cdn.dribbble.com/users/27766/screenshots/3488007/media/ac55b16291e99eb1740c17b4ac793454.png"
                  boxSize="200px"
                />
                <Text fontSize="22px" p="4px">
                  {item.title}
                </Text>
                <Text fontSize={14} m="5px">
                  {item.description}
                </Text>
                <Text m="2px">{item.price} €</Text>
                <Divider m="2px" />
                {containsItem(item.title) ? (
                  <Button
                    size="sm"
                    m="3px"
                    bg="red"
                    color="white"
                    onClick={() => removeItem(item.title)}
                  >
                    Remove from cart
                  </Button>
                ) : (
                  <Button
                    size="sm"
                    m="3px"
                    onClick={() => addToCart(item.title)}
                  >
                    Add to cart
                  </Button>
                )}
              </Flex>
            );
          })
        )}
      </Flex>
    </Box>
  );
}
