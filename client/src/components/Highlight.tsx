import React from "react";

import { Flex, Image, Text } from "@chakra-ui/react";

interface ItemData {
  title: string;
  price: string;
  image: string;
}

interface HighlightProps {
  data: ItemData[];
}

const Highlight: React.FC<HighlightProps> = (props) => {
  return (
    <Flex>
      {props.data.map((item) => {
        return (
          <Flex
            flexDir="column"
            border="1px solid black"
            borderRadius="md"
            padding="15px"
            margin="5px"
            width="250px"
            height="300px"
            align="center"
            justify="center"
            _hover={{
              cursor: "pointer",
            }}
          >
            <Image
              src={item.image}
              fallbackSrc="https://dummyimage.com/600x400/000/fff"
            />
            <Text m="2" fontSize={22}>
              {item.title}
            </Text>
            <Text m="2" fontSize={16}>
              {item.price}
            </Text>
          </Flex>
        );
      })}
    </Flex>
  );
};

export default Highlight;
