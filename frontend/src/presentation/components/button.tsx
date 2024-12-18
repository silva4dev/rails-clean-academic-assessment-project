import React from "react";
import { Link } from "react-router-dom";

interface ButtonProps {
  studentId: string;
}

const Button: React.FC<ButtonProps> = ({ studentId }) => {
  return (
    <Link
      to={`/student/${studentId}`}
      className="px-4 py-2 text-sm font-medium text-white bg-blue-600 rounded-lg shadow hover:bg-blue-700 focus:outline-none focus:ring focus:ring-blue-300"
    >
      View Details
    </Link>
  );
};

export default Button;
