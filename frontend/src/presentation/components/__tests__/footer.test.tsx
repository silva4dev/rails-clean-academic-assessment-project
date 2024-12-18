import { render } from "@testing-library/react";
import Footer from "../footer";

describe('Footer', () => {
  test('should render the footer content with the current year and correct text', () => {
    const currentYear = new Date().getFullYear();
    const { getByText } = render(<Footer />);
    expect(getByText(/Developed with/i)).toBeInTheDocument();
    expect(getByText('Lucas Alves')).toBeInTheDocument();
  });

  test('should render the heart icon with correct color', () => {
    const { getByTestId } = render(<Footer />);
    const heartIcon = getByTestId('heart-icon');
    expect(heartIcon).toBeInTheDocument();
    expect(heartIcon).toHaveClass('text-red-500');
  });
});
