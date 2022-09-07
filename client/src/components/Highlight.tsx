import React from "react";

import { Flex, Image, Text } from "@chakra-ui/react";

interface ItemData {
  title: string;
  price: string;
  image: string;
  description: string;
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
              fallbackSrc="https://cdn.dribbble.com/users/27766/screenshots/3488007/media/ac55b16291e99eb1740c17b4ac793454.png"
            />
            <Text fontSize="22px" p="4px">
              {item.title}
            </Text>
            <Text fontSize={14} m="5px">
              {item.description}
            </Text>
            <Text m="2px">{item.price} €</Text>
          </Flex>
        );
      })}
    </Flex>
  );
};

export default Highlight;
