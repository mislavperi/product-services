import { Flex, Text, Heading } from "@chakra-ui/react";
import Highlight from "./Highlight";

export default function Home(): JSX.Element {
  const data = [
    {
      title: "Item 1",
      price: "22€",
      image: "",
    },
    {
      title: "item 2",
      price: "22€",
      image:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
    },
    {
      title: "Item 3",
      price: "22€",
      image: "",
    },
  ];

  return (
    <Flex flexDir="column" align="center">
      <Text fontSize="36px">Product page </Text>
      <Highlight data={data} />
    </Flex>
  );
}
