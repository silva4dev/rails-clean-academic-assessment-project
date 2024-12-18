import { render, screen } from "@testing-library/react";
import Navbar from "../navbar";

describe('Navbar', () => {
  test('should render the title "Academic Assessment" in the navbar', () => {
    render(<Navbar />);
    
    const title = screen.getByText(/Academic Assessment/i);
    expect(title).toBeInTheDocument();
  });

  test('should have the correct navbar background color', () => {
    render(<Navbar />);
    const navbar = screen.getByRole('navigation'); 
    expect(navbar).toHaveClass('bg-white');
  });

  test('should have shadow class applied to navbar', () => {
    render(<Navbar />);

    const navbar = screen.getByRole('navigation');
    expect(navbar).toHaveClass('shadow-md');
  });
});
