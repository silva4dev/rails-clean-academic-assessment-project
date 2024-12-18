import React from "react";
import { HeartIcon } from "@heroicons/react/24/solid";

const Footer: React.FC = () => (
  <footer className="bg-zinc-700 text-white p-4 text-end">
    <p className="text-[16px] flex items-center justify-end">
       Developed with <HeartIcon data-testid="heart-icon" className="h-5 w-5 text-red-500 mx-2" />
       by <span className="font-bold m-2">Lucas Alves</span>
    </p>
  </footer>
);

export default Footer;
