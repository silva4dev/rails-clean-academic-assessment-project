import { Meta, StoryObj } from "@storybook/react";
import Button from "./button";
import { BrowserRouter } from "react-router-dom";

const meta: Meta<typeof Button> = {
  title: "Components/Button",
  component: Button,
  tags: ["autodocs"],
  parameters: {
    layout: "fullscreen",
  },
  argTypes: {
    studentId: {
      control: "text",
      description: "ID of the student to link to.",
      defaultValue: "123",
    },
  },
  decorators: [
    (Story) => (
      <BrowserRouter>
        <Story />
      </BrowserRouter>
    ),
  ],
};

export default meta;
type Story = StoryObj<typeof Button>;

export const Default: Story = {
  args: {
    studentId: "123",
  },
};
