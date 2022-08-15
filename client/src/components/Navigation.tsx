import React from "react";

import { Flex, Link, Text, Box } from "@chakra-ui/react";
import { VscAccount } from "react-icons/vsc";

export default function Navigation(): JSX.Element {
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
        <Link href="/orders" m="4">
          Orders
        </Link>
      </Flex>
      <Flex
        align="center"
        justify="flex-end"
        width="20%"
        height="100%"
        mr="20px"
      >
        <Flex
          _hover={{
            cursor: "pointer",
            color: "red",
          }}
        >
          <Text mr="10px">Login</Text>
          <VscAccount size={24} />
        </Flex>
      </Flex>
    </Flex>
  );
}
